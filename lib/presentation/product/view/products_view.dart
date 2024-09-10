import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_verto/presentation/product/bloc/products_bloc.dart';
import 'package:test_verto/presentation/product/domain/product_model.dart';
import 'package:test_verto/presentation/product/view/product_widgets.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late final ProductsBloc _productsBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _productsBloc = ProductsBloc()..add(ProductsLoadDataEvent());
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.75)) {
        _productsBloc.add(ProductsLoadDataEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Products"),
      ),
      body: BlocProvider(
        create: (_) => _productsBloc,
        child: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: _productsBloc,
          buildWhen: (previous, current) =>
              previous != current || current is! ProductsError,
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsSuccess ||
                state is ProductsLoadingMore) {
              List<Product> products = [];
              if (state is ProductsSuccess) {
                products = state.products;
              } else if (state is ProductsLoadingMore) {
                products = state.products;
              }
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      controller: _scrollController,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                    ),
                  ),
                  if (state is ProductsLoadingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            } else if (state is ProductsError) {
              return Center(child: Text('No data available. ${state.error}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
