import 'package:aura/features/orders/presentation/controllers/orders_controller.dart';
import 'package:flutter/material.dart';

class OrdersFilterTabs extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const OrdersFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = OrdersController.filters;

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        clipBehavior: Clip.none,
        child: Row(
          children: filters.map((f) {
            final isSelected = selectedFilter == f['key'];
            final isLast = f == filters.last;
            return Padding(
              padding: EdgeInsets.only(right: isLast ? 0 : 8),
              child: ChoiceChip(
                label: Text(
                  f['label']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF475569),
                  ),
                ),
                selected: isSelected,
                selectedColor: const Color(0xFF0B3B2C),
                backgroundColor: const Color(0xFFF1F5F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                ),
                onSelected: (selected) {
                  if (selected) {
                    onFilterSelected(f['key']!);
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
