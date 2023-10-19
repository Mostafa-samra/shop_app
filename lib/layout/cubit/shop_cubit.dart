import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/favorits_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/catogeros/catogeress_screen.dart';
import 'package:shop_app/modules/favorates/favorates_screen.dart';
import 'package:shop_app/modules/prodactes/prodactes_screen.dart';
import 'package:shop_app/modules/settinges/settinges_screen.dart';
import 'package:shop_app/sheard/components/constants.dart';
import 'package:shop_app/sheard/network/endpoint.dart';
import 'package:shop_app/sheard/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductesScreen(),
    const CategoryScreen(),
    const FavoretsScreen(),
    SettingScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorates = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.date!.products) {
        favorates.addAll({element.id!: element.inFavorites!});
      }
      emit(ShopSuccesHomeDataState());
    }).catchError((onError) {
      emit(ShopErrorHomeDataState(error: onError));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccesCategoriesDataState());
    }).catchError((onError) {
      emit(ShopErrorCategoriesDataState(error: onError));
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int prodactId) {
    favorates[prodactId] != favorates[prodactId];
    emit(ShopSuccesChangeFavoritesState(model: changeFavoritesModel));

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': prodactId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status!) {
        favorates[prodactId] != favorates[prodactId];
      } else {
        getFavorites();
      }
      emit(ShopSuccesChangeFavoritesState(model: changeFavoritesModel));
    }).catchError((onError) {
      favorates[prodactId] != favorates[prodactId];
      ShopErrorChangeFavoritesState(error: onError);
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccesGetFavoritesState());
    }).catchError((onError) {
      emit(ShopErrorGetFavoritesState(error: onError));
    });
  }

  ShopLoginModel? loginModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccesUserDataState(loginModel: loginModel!));
    }).catchError((onError) {
      ShopErrorUserDataState(error: onError);
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccesUpdateUserState(loginModel: loginModel!));
    }).catchError((onError) {
      ShopErrorUpdateUserState(error: onError);
    });
  }
}
