import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tuto_provider/main.dart';

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> items;
  const BreadCrumbWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: items
          .map(
            (breadCrumb) => Text(
              breadCrumb.title,
              style: TextStyle(
                  color: breadCrumb.isActive ? Colors.blue : Colors.black,
                  fontSize: 16),
            ),
          )
          .toList(),
    );
  }
}
