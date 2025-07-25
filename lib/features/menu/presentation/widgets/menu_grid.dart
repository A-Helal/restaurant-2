import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/menu/data/models/menu_item_model.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/menu_item_card.dart';


class MenuGrid extends StatelessWidget {
  final List<MenuItem> menuItems;

  const MenuGrid({
    super.key,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(Constants.paddingMedium),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Constants.gridCrossAxisCount,
          childAspectRatio: Constants.gridChildAspectRatio,
          crossAxisSpacing: Constants.gridSpacing,
          mainAxisSpacing: Constants.gridSpacing,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return MenuItemCard(menuItem: menuItems[index]);
        },
    );
  }
}