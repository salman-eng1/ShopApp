import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{


  AppCubit() : super(AppInitialStates());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isBottomSheetShown = false;
  IconData fabIcon=Icons.edit;


  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
})
  {
    isBottomSheetShown=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }




  ThemeMode appMode=ThemeMode.dark;
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    // ignore: unnecessary_null_comparison
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
