import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_shimmer_widget.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/products_shimmer_widget.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/products_widget.dart';
import 'package:shopping_app/features/home/presentation/view_model/categories_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  late final ProductsCubit _productsCubit;
  late final CategoriesCubit _categoriesCubit;

  @override
  void initState() {
    super.initState();

    _productsCubit = serviceLocator<ProductsCubit>()..fetchFirstPage();
    _categoriesCubit = serviceLocator<CategoriesCubit>()..fetchCategories();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _productsCubit.fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productsCubit.close();
    _categoriesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _categoriesCubit),
        BlocProvider.value(value: _productsCubit),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppSpacing.allX2,
                  child: Text("Hi !\nLet's Start Your Day", style: Theme.of(context).textTheme.headlineMedium),
                ),

                BlocBuilder<CategoriesCubit, BaseState<List<CategoryEntity>>>(
                  builder: (context, state) {
                    return BaseStateBuilder<List<CategoryEntity>>(
                      state: state,
                      onLoading: const CategoriesShimmerWidget(),
                      onSuccess: (categories) {
                        return CategoriesWidget(categories: categories, onCategoryTap: (name, slug) {});
                      },
                    );
                  },
                ),

                verticalSpace(AppSpacing.x2),

                BlocBuilder<ProductsCubit, PaginationState<ProductItemEntity>>(
                  builder: (context, state) {
                    if (state.isFirstLoading) {
                      return const ProductsShimmerWidget();
                    }

                    if (state.errorMessage != null && state.items.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: AppSpacing.allX2,
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ProductsWidget(products: state.items),
                        if (state.isLoadingMore)
                          const Padding(
                            padding: AppSpacing.allX2,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
