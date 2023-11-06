import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/appthemes/app_theme_dark.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: MaterialApp.router(
        title: 'My Chat App',
        debugShowCheckedModeBanner: false,
        theme: AppThemeDark.whatsappThemeDark,
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}
