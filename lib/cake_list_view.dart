import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CakeList extends HookConsumerWidget {
  final snapshot = null;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _selectedFilter = 'All Flavours';
    return Row(
      children: [
        Container(
          width: 100,
          color: Color(0xffd8d6d5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilterTile(
                title: 'All Flavours',
                isSelected: _selectedFilter == 'All Flavours',
                onTap: () {},
              ),
              FilterTile(
                title: 'Chocolate',
                isSelected: _selectedFilter == 'Chocolate',
                onTap: () {},
              ),
              FilterTile(
                title: 'Vanilla',
                isSelected: _selectedFilter == 'Vanilla',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FilterTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  FilterTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 5,
            ),
          ),
        ),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
