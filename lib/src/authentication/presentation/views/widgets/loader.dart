import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loader extends StatelessWidget {
  final String? text;
  const Loader({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 20,
        ),
        Text(
          text ?? 'Loading...',
          style: const TextStyle(fontSize: 20),
        ),
      ]),
    );
  }
}
