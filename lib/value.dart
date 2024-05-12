import 'package:flutter/material.dart';

class ValueShow extends StatelessWidget {
  final String email;
  final String pass;
  const ValueShow({super.key, required this.email, required this.pass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: []),
      ),
    );
  }
}
