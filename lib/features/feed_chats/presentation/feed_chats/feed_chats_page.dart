import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedChatsPage extends StatefulWidget {
  const FeedChatsPage({super.key});

  @override
  State<FeedChatsPage> createState() => _FeedChatsPageState();
}

class _FeedChatsPageState extends State<FeedChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/search-user/');
        },
        child: const Icon(Icons.message),
      ),
      body: const Placeholder(),
    );
  }
}
