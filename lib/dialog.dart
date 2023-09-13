import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:just_blue/bl_avatar.dart';
import 'package:just_blue/ext.dart';

class AppDialog extends StatelessWidget {
  const AppDialog(this.bl, this.deviceNo, {Key? key}) : super(key: key);
  final BluetoothDevice bl;
  final int deviceNo;
  @override
  Widget build(BuildContext context) {
    final String deviceName = bl.name ?? 'Device $deviceNo';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Material(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                  width: 250,
                  child: BlAvatar(Icons.bluetooth_disabled),
                ),
                Text(
                  'Could not connect to $deviceName',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red[100],
                      ),
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        'CLOSE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
