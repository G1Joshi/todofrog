import 'package:flutter/material.dart';

Color getShade(MaterialColor color, int priority) {
  return priority == 1
      ? color.shade200
      : priority == 2
          ? color.shade100
          : color.shade50;
}

String getPriority(int priority) {
  return priority == 1
      ? 'High'
      : priority == 2
          ? 'Medium'
          : 'Low';
}
