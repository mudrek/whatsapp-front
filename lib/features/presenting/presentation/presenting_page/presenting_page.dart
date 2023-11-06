import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_button.dart';

class PresentingPage extends StatefulWidget {
  const PresentingPage({super.key});

  @override
  State<PresentingPage> createState() => _PresentingPageState();
}

class _PresentingPageState extends State<PresentingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/chat-illustration.png',
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Column(
              children: [
                Text(
                  'Bem-vindo ao Kydrem Whatsapp',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper arcu id elit elementum bibendum. Donec et turpis sem. Donec ut luctus eros. Cras laoreet sem vel efficitur pellentesque.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Column(
              children: [
                AppButton(
                  text: 'Entrar',
                  onPressed: () {
                    Modular.to.pushNamed('/login/');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AppButton(
                  text: 'Cadastrar',
                  onPressed: () {},
                  isPrimaryColor: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
