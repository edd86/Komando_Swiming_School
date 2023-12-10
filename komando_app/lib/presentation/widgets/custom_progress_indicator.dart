// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  double? size = 50;
  CustomProgressIndicator({this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/komandos.gif',
        height: size,
        width: size,
      ),
    );
  }
}
