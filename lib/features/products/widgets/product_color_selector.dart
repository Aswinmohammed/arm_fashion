import 'package:flutter/material.dart';

class ProductColorSelector extends StatelessWidget {
  const ProductColorSelector({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<Color> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        colors.length,
        (index) {
          final isSelected = index == selectedIndex;

          return Padding(
            padding: EdgeInsets.only(right: index == colors.length - 1 ? 0 : 10),
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: Container(
                width: 22,
                height: 22,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.transparent,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors[index],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
