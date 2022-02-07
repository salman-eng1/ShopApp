import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class  SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel? model;
  
  void search (String text){
    DioHelper.postData(url: PRODUCTS_SEARCH, data: {'text' : text,'token' : token})
    .then((value)  {
      model= SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    })
    .catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}