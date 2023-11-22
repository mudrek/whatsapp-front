import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/appthemes/app_theme_dark.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        child: MaterialApp.router(
          title: 'My Chat App',
          debugShowCheckedModeBanner: false,
          theme: AppThemeDark.whatsappThemeDark,
          routerConfig: Modular.routerConfig,
        ),
      ),
    );
  }
}
