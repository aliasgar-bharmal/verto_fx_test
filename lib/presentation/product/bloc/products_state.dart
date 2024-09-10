part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<Product> products;
  const ProductsSuccess({required this.products});
}

final class ProductsLoadingMore extends ProductsState {
  final List<Product> products;
  const ProductsLoadingMore({required this.products});
}

final class ProductsLoading extends ProductsState {}

final class ProductsError extends ProductsState {
  final String error;
  const ProductsError({required this.error});
}
