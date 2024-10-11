import 'package:flutter/material.dart';

class PalierWidget extends StatelessWidget {
  final int currentLevel;
  final List<int> paliers = [
    100, 200, 300, 500, 1000,
    2000, 4000, 8000, 16000, 32000,
    64000, 125000, 250000, 500000, 1000000
  ];

  PalierWidget({required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.black.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: paliers.reversed.map((palier) {
            int index = paliers.indexOf(palier);
            return Text(
              '${palier} Bactéries',
              style: TextStyle(
                color: index == currentLevel ? Colors.yellow : Colors.white,
                fontSize: 18,
                fontWeight: index == currentLevel ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
