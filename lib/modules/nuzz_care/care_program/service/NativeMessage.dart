import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:nuuz/util/log_print.dart';

class MessageChannelTool {
  static const BasicMessageChannel _messageChannel = BasicMessageChannel('careMessageChannelPath', StandardMessageCodec());


  static Future<TransferResult> transformData(JsonParam param) async {

    return _messageChannel
        .send(param.toJson())
        .then((value) => TransferResult.fromNative(value));
  }
}

abstract class JsonParam{
  HashMap<String, dynamic> toJson();
}
class CloseParam extends JsonParam{
  @override
  HashMap<String, dynamic> toJson() {
    return HashMap<String, dynamic>()
      ..['close']="close";

  }
}
class NextRowParam extends JsonParam{
  @override
  HashMap<String, dynamic> toJson() {
    return HashMap<String, dynamic>()
      ..['nextRow']="nextRow";

  }
}
class TransferParam extends JsonParam{
  final int range;
  final int column;
  final String name;
  TransferParam(this.name,this.range, this.column);

  @override
  HashMap<String, dynamic> toJson() {
    safePrint(name);
    return HashMap<String, dynamic>()
      ..['name']=name
      ..['range'] = range
      ..['column'] = column;
  }
}

class ScaleParam extends JsonParam{
  final double x;
  final double y;

  ScaleParam(this.x, this.y);

  @override
  HashMap<String, dynamic> toJson() {
    return HashMap<String, dynamic>()
      ..['scaleX'] = x
      ..['scaleY'] = y;
  }
}
class TransferResult {
  final int code;
  final String data;

  TransferResult({required this.code, required this.data});

  factory TransferResult.fromNative(dynamic result) {
    return TransferResult(
      code: result['code'],
      data: result['data'],
    );
  }
}

