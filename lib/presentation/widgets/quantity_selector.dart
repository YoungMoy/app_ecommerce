import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(
            Icons.remove_circle_outline,
          ),
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius:
                BorderRadius.circular(8),
          ),
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        IconButton(
          onPressed: onIncrement,
          icon: const Icon(
            Icons.add_circle_outline,
          ),
        ),
      ],
    );
  }
}