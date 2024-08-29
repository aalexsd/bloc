// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitalEvent extends CartEvent {}

class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel clickedProduct;
  CartRemoveFromCartEvent({
    required this.clickedProduct,
  });
}

class CartNavigateToHomeEvent extends CartEvent {}
