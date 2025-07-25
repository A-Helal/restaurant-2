import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_task/core/shared_widgets/custom_text_field.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/menu/data/cubits/menu/menu_cubit.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({super.key});

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Container(
        padding: const EdgeInsets.all(Constants.paddingMedium),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.largeBorderRadius),
            topRight: Radius.circular(Constants.largeBorderRadius),
          ),
        ),
        child: Column(
          children: [
            SearchTextField(
              controller: _searchController,
              hintText: 'Search for dishes...',
              onChanged: (query) {
                context.read<MenuCubit>().searchMenuItems(query);
              },
              onClear: () {
                context.read<MenuCubit>().clearSearch();
              },
            ),
            const SizedBox(height: Constants.paddingMedium),
          ],
        ),
      ),
    );
  }
}
