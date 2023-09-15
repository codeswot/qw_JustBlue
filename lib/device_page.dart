import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:math' as math;

import 'package:just_blue/ext.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

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
  bool livingRoomStatus = false;
  bool diningRoomStatus = false;
  bool bedRoomStatus = false;

  @override
  // void initState() {
  //   widget.cn.input?.listen((Uint8List data) {
  //     setState(() {
  //       testData = ascii.decode(data);
  //     });
  //     if (kDebugMode) {
  //       print('Data incoming: $testData');
  //     }
  //   });
  //   super.initState();
  // }

  // String testData = '';

  @override
  Widget build(BuildContext context) {
    // final String deviceName = widget.bl.name ?? 'Device ${widget.deviceNo}';
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Lights 💡',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton.filled(
            color: Colors.white,
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: TabBar(
              indicatorColor: Colors.yellowAccent,
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Living room',
                ),
                Tab(
                  text: 'Dinning',
                ),
                Tab(
                  text: 'Bed room',
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: TabBarView(
            children: [
              FakeRoomLight(
                title: 'Living Room',
                subTitle: '',
                status: livingRoomStatus,
                onToggle: (v) {
                  setState(() {
                    livingRoomStatus = v;
                  });
                },
              ),
              FakeRoomLight(
                title: 'Dining Room',
                subTitle: '',
                status: diningRoomStatus,
                onToggle: (v) {
                  setState(() {
                    diningRoomStatus = v;
                  });
                },
              ),
              FakeRoomLight(
                title: 'Bed Room',
                subTitle: '',
                status: bedRoomStatus,
                onToggle: (v) {
                  setState(() {
                    bedRoomStatus = v;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FakeRoomLight extends StatelessWidget {
  const FakeRoomLight({
    required this.title,
    required this.subTitle,
    required this.status,
    required this.onToggle,
    super.key,
  });
  final String title;
  final String subTitle;
  final bool status;
  final Function(bool value) onToggle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LighBulShow(status: status),
            LiteRollingSwitch(
              value: status,
              textOn: 'Turn Off',
              textOff: 'Turn On',
              colorOn: Colors.green,
              colorOff: Colors.grey,
              iconOn: Icons.power_settings_new_sharp,
              iconOff: Icons.power_settings_new_sharp,
              textSize: 16.0,
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class LighBulShow extends StatelessWidget {
  const LighBulShow({
    required this.status,
    super.key,
  });
  final bool status;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 200,
      backgroundColor:
          status ? Colors.yellowAccent.withOpacity(0.1) : Colors.transparent,
      child: CircleAvatar(
        radius: 150,
        backgroundColor:
            status ? Colors.yellowAccent.withOpacity(0.1) : Colors.transparent,
        child: CircleAvatar(
          radius: 120,
          backgroundColor: status
              ? Colors.yellowAccent.withOpacity(0.1)
              : Colors.transparent,
          child: CircleAvatar(
            radius: 110,
            backgroundColor: status
                ? Colors.yellowAccent.withOpacity(0.3)
                : Colors.transparent,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: status
                  ? Colors.yellowAccent.withOpacity(0.4)
                  : Colors.transparent,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: status
                    ? Colors.yellowAccent.withOpacity(0.5)
                    : Colors.transparent,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: status
                      ? Colors.yellowAccent.withOpacity(0.6)
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: status
                        ? Colors.yellowAccent.withOpacity(0.9)
                        : Colors.transparent,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: status
                          ? Colors.yellowAccent.withOpacity(0.10)
                          : Colors.transparent,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: status
                            ? Colors.yellowAccent.withOpacity(0.15)
                            : Colors.transparent,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: status
                              ? Colors.yellow.withOpacity(0.3)
                              : Colors.white,
                          child: Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child: Icon(
                              Icons.lightbulb_outline,
                              color: status
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.grey,
                              size: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
