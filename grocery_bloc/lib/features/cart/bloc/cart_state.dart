// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState({
    required this.cartItems,
  });
}

class CartRemovedProductState extends CartState {
  final List<ProductDataModel> cartItems;
  CartRemovedProductState({
    required this.cartItems,
  });
}

class CartNavigatoToHomeState extends CartActionState {}
