import 'package:flutter/widgets.dart';

@immutable
class Priority {
  const Priority({
    required this.name,
    required this.value,
  });

  final String name;
  final int value;

  static final priorities = [
    const Priority(
      name: 'High',
      value: 1,
    ),
    const Priority(
      name: 'Medium',
      value: 2,
    ),
    const Priority(
      name: 'Low',
      value: 3,
    ),
  ];

  @override
  bool operator ==(Object other) =>
      other is Priority && name == other.name && value == other.value;

  @override
  int get hashCode => Object.hash(name, value);
}
