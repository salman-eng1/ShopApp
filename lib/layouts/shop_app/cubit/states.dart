

import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopStates {}


class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesDataState extends ShopStates{}
class ShopSuccessCategoriesDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{
  final String error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopSuccessChangeState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}
class ShopLoadingFavoritesDataState extends ShopStates{}
class ShopSuccessFavoritesDataState extends ShopStates{}
class ShopErrorFavoritesDataState extends ShopStates{
  final String error;
ShopErrorFavoritesDataState(this.error);
}


class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
   final ShopLoginModel loginModel;
   ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{
  final String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopErrorUpdateUserDataState extends ShopStates{
  final String error;
  ShopErrorUpdateUserDataState(this.error);
}

