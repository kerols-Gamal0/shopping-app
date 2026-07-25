import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_list_widget.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_shimmer_widget.dart';
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CategoriesCubit>()..fetchCategories()),
        BlocProvider(create: (context) => getIt<ProductsCubit>()..fetchFirstPage()),
      ],
      child: Builder(
        builder: (context) {
          _scrollController.addListener(() {
            if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 200) {
              context.read<ProductsCubit>().fetchNextPage();
            }
          });

          return SafeArea(
            child: Scaffold(
              // appBar: AppBar(
              //   title: Text('Home', style: Theme.of(context).textTheme.headlineMedium),
              //   centerTitle: true,
              // ),
              body: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Hi !\nLet's Start Your Day",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    BlocBuilder<CategoriesCubit, BaseState<List<CategoryEntity>>>(
                      builder: (context, state) {
                        return BaseStateBuilder<List<CategoryEntity>>(
                          state: state,
                          onLoading: const CategoriesShimmerWidget(),
                          onSuccess: (categories) => CategoriesWidget(
                            categories: categories,
                            onCategoryTap: (name, slug) {
                              // TODO: هنا هيتبعت الـ name والـ slug لصفحة/فيتشر "Products by Category"
                              // اللي هيعمله زميلك (هيستخدم الاتنين) — التنقل مش شغلي هنا
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ProductsCubit, PaginationState<ProductEntity>>(
                      builder: (context, state) {
                        if (state.isFirstLoading) {
                          return const ProductsShimmerWidget();
                        }
                        if (state.errorMessage != null && state.items.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
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
                                padding: EdgeInsets.all(16),
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
          );
        },
      ),
    );
  }
}