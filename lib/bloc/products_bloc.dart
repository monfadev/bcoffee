import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bcoffee/models/models.dart';
import 'package:bcoffee/services/services.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  @override
  ProductsState get initialState => ProductsState([]);

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is FetchProducts) {
      List<Products> products = await ProductsServices.getProducts();

      yield ProductsState(products);
    }
  }
}