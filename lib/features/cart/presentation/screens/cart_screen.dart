import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_cubit.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_state.dart';
import 'package:restaurant_task/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:restaurant_task/features/cart/presentation/widgets/cart_dialogs.dart';
import 'package:restaurant_task/features/cart/presentation/widgets/cart_empty_state.dart';
import 'package:restaurant_task/features/cart/presentation/widgets/cart_error_state.dart';
import 'package:restaurant_task/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:restaurant_task/features/cart/presentation/widgets/cart_summary_section.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/loading_widget.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CartAppBar(
        onBackPressed: () => context.go('/menu'),
        onClearPressed: () => CartDialogs.showClearCartDialog(context),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return switch (state) {
            CartLoading() => const LoadingWidget(message: 'Loading your cart...'),
            CartUpdated() => _buildCartContent(context, state),
            CartError() => CartErrorState(
              message: state.message,
              onRetry: () => context.go('/menu'),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartUpdated state) {
    if (state.items.isEmpty) {
      return CartEmptyState(
        onBrowseMenu: () => context.go('/menu'),
      );
    }

    return Column(
      children: [
        Expanded(
          child: _buildCartItemsList(context, state),
        ),
        CartSummarySection(
          state: state,
          onCheckout: () => CartDialogs.showCheckoutDialog(context),
        ),
      ],
    );
  }

  Widget _buildCartItemsList(BuildContext context, CartUpdated state) {
    return ListView.builder(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final cartItem = state.items[index];
        return CartItemWidget(
          cartItem: cartItem,
          onQuantityChanged: (quantity) => _handleQuantityChanged(
            context,
            cartItem.menuItem.id,
            quantity,
          ),
          onRemove: () => _handleItemRemoval(context, cartItem.menuItem.id),
        );
      },
    );
  }

  void _handleQuantityChanged(BuildContext context, String itemId, int quantity) {
    final cartCubit = context.read<CartCubit>();

    if (quantity <= 0) {
      cartCubit.removeItem(itemId);
    } else {
      cartCubit.updateQuantity(itemId, quantity);
    }
  }

  void _handleItemRemoval(BuildContext context, String itemId) {
    context.read<CartCubit>().removeItem(itemId);
  }
}