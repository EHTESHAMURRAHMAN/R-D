import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  final TextEditingController value;
  const Balance({super.key, required this.value});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(
          controller: widget.value,
        )
      ],
    ));
  }
}
