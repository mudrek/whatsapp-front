import 'package:asp/asp.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/app_widget.dart';

void main() {
  Flavor.create(
    Environment.dev,
    color: Colors.green,
    name: 'PREVIEW',
    properties: {
      Keys.apiUrl: 'http://localhost:8080/api',
    },
  );

  runApp(
    RxRoot(
      child: ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
