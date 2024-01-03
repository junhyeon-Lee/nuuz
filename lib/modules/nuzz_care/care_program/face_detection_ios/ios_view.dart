import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IosView extends StatefulWidget {
  static const Map<String, dynamic> creationParams = <String, dynamic>{
    "param": "겸식이"
  };

  const IosView({Key? key}) : super(key: key);

  @override
  State<IosView> createState() => _IosViewState();
}

class _IosViewState extends State<IosView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: UiKitView(
          viewType: 'ios',
          layoutDirection: TextDirection.ltr,
          creationParams: IosView.creationParams,
          creationParamsCodec: StandardMessageCodec(),
        ),
      ),
    );
  }
}
