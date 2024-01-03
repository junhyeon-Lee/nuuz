import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/modules/connection/connection_controller/mynuuz_controller.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';

class MynuuzTestScreen extends ConsumerStatefulWidget {
  const MynuuzTestScreen(this.connectedDevice, {Key? key}) : super(key: key);

  final BluetoothDevice connectedDevice;

  @override
  ConsumerState<MynuuzTestScreen> createState() => _MynuuzTestScreenState();
}

class _MynuuzTestScreenState extends ConsumerState<MynuuzTestScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mynuuzController = ref.watch(mynuuzProvider.notifier);
      await mynuuzController.discoverService(widget.connectedDevice);
      mynuuzController.getBluetoothDate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final mynuuzController = ref.watch(mynuuzProvider.notifier);
          final bluetoothData = ref.watch(mynuuzProvider);
          return Column(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('리프래쉬')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('연결된 기기 이름 : ${widget.connectedDevice.name}'),
                                Text('연결된 기기 ID : ${widget.connectedDevice.id}'),
                              ],
                            ),
                            StreamBuilder(
                                stream: widget.connectedDevice.state,
                                builder: (s, snapshot) {
                                  return snapshot.data == BluetoothDeviceState.connected
                                      ? const Icon(Icons.thumb_up_alt)
                                      : const Icon(Icons.thumb_down);

                                  // Text(snapshot.data.toString());
                                }),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSize(30),
                            Text(
                              'Notified data',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 40),
                            ),
                            hSize(20),
                            Text(
                              'Cartridge type : ${bluetoothData.substring(3, 4)}',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 30),
                            ),
                            hSize(10),
                            Text(
                              'remain shot : ${bluetoothData.substring(5, 11)}',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 30),
                            ),
                            hSize(10),
                            Text(
                              'cartridge cap : ${bluetoothData.substring(12, 18)}',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 30),
                            ),
                            hSize(10),
                            Text(
                              'num of uses : ${bluetoothData.substring(19, 25)}',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 30),
                            ),
                            hSize(10),
                            Text(
                              'battery : ${bluetoothData.substring(26, 29)}%',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 30),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}