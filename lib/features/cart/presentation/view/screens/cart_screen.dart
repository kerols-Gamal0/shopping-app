import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_entity.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import 'package:shopping_app/features/cart/presentation/view/widgets/cart_item_card.dart';
import 'package:shopping_app/features/cart/presentation/view/widgets/cart_item_shimmer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = 'CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CartCubit>().doIntent(const GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartStatus is BaseInitialState<List<CartEntity>>) {
              return _buildOnLoadingWidget();
            }

            return BaseStateBuilder<List<CartEntity>>(
              state: state.cartStatus,
              onLoading: () => _buildOnLoadingWidget(),
              onError: (error) => _buildOnFailureWidget(error, context),
              onSuccess: (cartItems) =>
                  _buildOnSuccessWidget(cartItems: cartItems, context: context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOnSuccessWidget({
    required List<CartEntity> cartItems,
    required BuildContext context,
  }) {
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.emptyCart, height: 200),
            verticalSpace(AppSpacing.x2),
            const Text('Your cart is empty.'),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: AppSpacing.allX2,
      itemCount: cartItems.length,
      separatorBuilder: (_, _) => verticalSpace(AppSpacing.x2),
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return CartItemCard(
          imageUrl: item.thumbnail,
          title: item.title,
          price: 'EGP ${item.price}',
          quantity: item.quantity,
          onIncrement: () {
            context.read<CartCubit>().doIntent(
              AddToCartEvent(productId: item.id),
            );
          },
          onDecrement: () {
            context.read<CartCubit>().doIntent(
              DeleteCartItemEvent(productId: item.id),
            );
          },
          onDelete: () {
            context.read<CartCubit>().doIntent(
              DeleteCartItemEvent(productId: item.id),
            );
          },
        );
      },
    );
  }

  Widget _buildOnFailureWidget(String error, BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.errorIcon, height: 96),
            verticalSpace(AppSpacing.x2),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.bodyLight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnLoadingWidget({int itemCount = 4}) {
    return ListView.separated(
      padding: AppSpacing.allX2,
      itemCount: itemCount,
      separatorBuilder: (_, _) => verticalSpace(AppSpacing.x2),
      itemBuilder: (_, _) => const CartItemShimmer(),
    );
  }
}
