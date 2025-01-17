part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;
  WishlistSuccessState({
    required this.wishlistItems,
  });
}

class WishlistRemovedProductState extends WishlistState {
  final List<ProductDataModel> wishlistItems;
  WishlistRemovedProductState({
    required this.wishlistItems,
  });
}

class WishlistNavigatoToHomeState extends WishlistActionState {}
