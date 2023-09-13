// ignore_for_file: unused_element, unused_field

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:just_blue/ext.dart';
import 'package:just_blue/fns.dart';
import 'package:just_blue/sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustBlue',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JustBlue'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _perm();
    super.initState();
  }

  Future _perm() async {
    await getPermission();
    _startDiscovery();
    _hndl();
  }

  List<_DeviceWithAvailability> devices =
      List<_DeviceWithAvailability>.empty(growable: true);

  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _hndl() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                _DeviceAvailability.maybe,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var device = i.current;
          if (device.device == r.device) {
            device.availability = _DeviceAvailability.yes;
            device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription?.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: devices.isEmpty
          ? const Center(
              child: Text('Bonded Devices will appear hear'),
            )
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: ((context, index) {
                final bl = devices[index];
                return ListTile(
                  onTap: () {
                    if (bl.availability == _DeviceAvailability.yes) {
                      context.showBottomSheet(Sheet(bl.device, index + 1));
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Device Appears to be offline !!')));
                      }
                    }
                  },
                  title: Text(
                    bl.device.name ?? 'Device ${index + 1}',
                  ),
                  subtitle: Text(
                    bl.availability == _DeviceAvailability.yes
                        ? "Online"
                        : "Offline",
                    style: TextStyle(
                      color: bl.availability == _DeviceAvailability.yes
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _restartDiscovery();
        },
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }

  @override
  void dispose() {
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}
