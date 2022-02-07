import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<Widget> bottomScreen=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
 HomeModel? homeModel;
 Map <int,bool> favorites={};
  void getHomeDate(){
emit(ShopLoadingHomeDataState());
DioHelper.getData(url: HOME,token: token).then((value)
{
homeModel=HomeModel.fromJson(value.data);
// printFullText(homeModel!.data!.banners[0].image);
// print(homeModel!.status);
homeModel!.data!.products.forEach((element) {
  favorites.addAll({
    element.id: element.inFavorites,
  });
});
print(favorites.toString());
emit(ShopSuccessHomeDataState());
}
).catchError((error)
{
emit(ShopErrorHomeDataState(error.toString()));
print(error.toString());
});
  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    DioHelper.getData(url: GET_CATEGORIES,token: token).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.status);
      emit(ShopSuccessCategoriesDataState());
    }
    ).catchError((error)
    {
      emit(ShopErrorCategoriesDataState(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId]= !(favorites[productId])!;
    emit(ShopSuccessChangeState());
    DioHelper.postData(
        url: FAVORITES,
        data: {'product_id': productId},
    token: token,)
        .then((value) {
          changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
          print(changeFavoritesModel!.message);
          if
          (!changeFavoritesModel!.status)
          {
            favorites[productId]= !(favorites[productId])!;

          }else {
            getFavorites();
          }
          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    })
        .catchError((error){
      favorites[productId]= !(favorites[productId])!;

      emit(ShopErrorChangeFavoritesState(error.toString()));
    });


  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(url: FAVORITES,token: token).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessFavoritesDataState());
    }
    ).catchError((error)
    {
      emit(ShopErrorFavoritesDataState(error.toString()));
      print(error.toString());
    });
  }

 late ShopLoginModel userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE,token: token).then((value)
    {
      userModel=ShopLoginModel.fromJason(value.data);
      // print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel));
    }
    ).catchError((error)
    {
      emit(ShopErrorUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
      data: {
          'name' :name,
        'email' : email,
        'phone' : phone
      },
    ).then((value)
    {
      userModel=ShopLoginModel.fromJason(value.data);
      // print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }
    ).catchError((error)
    {
      emit(ShopErrorUpdateUserDataState(error.toString()));
      print(error.toString());
    });
  }

}