part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopChangeBottomNavState extends ShopState {}

final class ShopLoadingHomeDataState extends ShopState {}

final class ShopSuccesHomeDataState extends ShopState {}

final class ShopErrorHomeDataState extends ShopState {
  final String error;

  ShopErrorHomeDataState({required this.error});
}

final class ShopSuccesCategoriesDataState extends ShopState {}

final class ShopErrorCategoriesDataState extends ShopState {
  final String error;

  ShopErrorCategoriesDataState({required this.error});
}

final class ShopChangeFavoritesState extends ShopState {}

final class ShopSuccesChangeFavoritesState extends ShopState {
  final ChangeFavoritesModel model;

  ShopSuccesChangeFavoritesState({required this.model});
}

final class ShopErrorChangeFavoritesState extends ShopState {
  final String error;

  ShopErrorChangeFavoritesState({required this.error});
}

final class ShopLoadingGetFavoritesState extends ShopState {}

final class ShopSuccesGetFavoritesState extends ShopState {}

final class ShopErrorGetFavoritesState extends ShopState {
  final String error;

  ShopErrorGetFavoritesState({required this.error});
}

final class ShopSuccesUserDataState extends ShopState {
  final ShopLoginModel loginModel;

  ShopSuccesUserDataState({required this.loginModel});
}

final class ShopErrorUserDataState extends ShopState {
  final String error;

  ShopErrorUserDataState({required this.error});
}

final class ShopLoadingUserDataState extends ShopState {}

final class ShopLoadingUpdateUserState extends ShopState {}

final class ShopSuccesUpdateUserState extends ShopState {
  final ShopLoginModel loginModel;
  ShopSuccesUpdateUserState({required this.loginModel});
}

final class ShopErrorUpdateUserState extends ShopState {
  final String error;

  ShopErrorUpdateUserState({required this.error});
}
