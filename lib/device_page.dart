import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ConnectedDevicePage extends StatefulWidget {
  const ConnectedDevicePage(this.cn, this.bl, this.deviceNo, {Key? key})
      : super(key: key);
  final BluetoothConnection cn;
  final BluetoothDevice bl;
  final int deviceNo;
  @override
  State<ConnectedDevicePage> createState() => _ConnectedDevicePageState();
}

class _ConnectedDevicePageState extends State<ConnectedDevicePage> {
  @override
  void initState() {
    widget.cn.input?.listen((Uint8List data) {
      setState(() {
        testData = ascii.decode(data);
      });
      if (kDebugMode) {
        print('Data incoming: $testData');
      }
    });
    super.initState();
  }

  String testData = '';

  @override
  Widget build(BuildContext context) {
    final String deviceName = widget.bl.name ?? 'Device ${widget.deviceNo}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected to $deviceName'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TEST DATA : $testData'),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xffc5deff),
                  ),
                  onPressed: () async {
                    widget.cn.input?.listen((event) {
                      setState(() {
                        testData = ascii.decode(event);
                      });
                    });
                  },
                  child: const Text("TEST READ"),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xffc5deff),
                  ),
                  onPressed: () async {
                    widget.cn.output.add(ascii.encode('TRT'));
                  },
                  child: const Text("TEST WRITE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
