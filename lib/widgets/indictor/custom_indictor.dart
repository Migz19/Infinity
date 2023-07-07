import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    Key? key,
    required this.isSelected,
    this.size = 18.0,
  }) : super(key: key);
  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedContainer(
        height: isSelected ? size : size - 3,
        width: isSelected ? size : size - 3,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(
            color: Colors.white10,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
