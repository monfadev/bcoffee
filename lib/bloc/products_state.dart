part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<Products> products;

  const ProductsState(this.products);

  @override
  List<Object> get props => [products];
}
