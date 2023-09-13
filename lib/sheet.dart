import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:just_blue/bl_avatar.dart';
import 'package:just_blue/device_page.dart';
import 'package:just_blue/dialog.dart';
import 'package:just_blue/ext.dart';

bool isConnected = false;

class Sheet extends StatefulWidget {
  const Sheet(this.bl, this.deviceNo, {Key? key}) : super(key: key);
  final BluetoothDevice bl;
  final int deviceNo;

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: 500,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            widget.bl.name ?? 'Device ${widget.deviceNo}',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey,
            ),
            child: Text(
              widget.bl.address,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
          const SizedBox(height: 30),
          const BlAvatar(Icons.bluetooth),
          const Spacer(),
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
                  try {
                    if (widget.bl.isBonded) {
                      BluetoothConnection connection =
                          await BluetoothConnection.toAddress(
                              widget.bl.address);

                      if (context.mounted) {
                        context.pushReplacement(ConnectedDevicePage(
                          connection,
                          widget.bl,
                          widget.deviceNo,
                        ));
                      }
                    }
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Pair with Device in phone settings first !')));
                    }
                  } catch (e, t) {
                    if (kDebugMode) {
                      print('error $e, at $t');
                    }
                    if (context.mounted) {
                      context.showAppDialog(AppDialog(
                        widget.bl,
                        widget.deviceNo,
                      ));
                    }
                  }
                },
                child: const Text(
                  'CONNECT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }
}
