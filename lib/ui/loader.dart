import 'package:flutter/material.dart';
import 'package:nuuz/ui/loader_screen.dart';

BuildContext? _appLoaderContext;

appLoader(BuildContext context) {
  _appLoaderContext = context;

  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => LoaderScreen(context),
    ),
  );
}

void removeAppLoader() {
  if (_appLoaderContext != null) {
    Navigator.of(_appLoaderContext!).pop();
    _appLoaderContext = null;
  }
}
