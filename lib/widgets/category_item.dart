
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF3A332E)
                  : const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: selected ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
