import 'package:flutter/material.dart';

class AppProfileImage extends StatelessWidget {
  const AppProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: const Padding(
        padding: EdgeInsets.all(4),
        child: Icon(Icons.person),
      ),
    );
  }
}
