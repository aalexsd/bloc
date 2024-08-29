import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teste_bloc/features/home/bloc/home_bloc.dart';

import '../../../data/cart_items.dart';
import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitalEvent>(cartInitalEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    on<CartNavigateToHomeEvent>(cartNavigateToHomeEvent);
  }

  FutureOr<void> cartInitalEvent(
      CartInitalEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    print('Removing from cart: ${event.clickedProduct.name}');

    cartItems.removeWhere((item) => item.id == event.clickedProduct.id);

    print('Cart items after removal: $cartItems');
    emit(CartRemovedProductState(cartItems: cartItems));
  }

  FutureOr<void> cartNavigateToHomeEvent(
      CartNavigateToHomeEvent event, Emitter<CartState> emit) {
    emit(CartNavigatoToHomeState());
  }
}
