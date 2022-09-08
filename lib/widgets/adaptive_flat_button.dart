import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton(
      {super.key, required this.handler, required this.text});

  final String text;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () {
              handler();
            },
            child: const Text(
              'Choose date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
        : TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.secondary)),
            onPressed: () {
              handler();
            },
            child: const Text(
              'Choose date',
            ));
  }
}
