abstract class AppStates{}


class AppInitialStates extends AppStates{}

class AppChangeBottomNavBarState extends AppStates{
  final int currentIndex;
  AppChangeBottomNavBarState(this.currentIndex);
}


class AppCreateDatabaseState extends AppStates{}

class AppGetDatabaseLoadingState extends AppStates{}


class AppGetDatabaseState extends AppStates{}


class AppInsertDatabaseState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}


class AppChangeBottomSheetState extends AppStates{}


class AppChangeModeState extends AppStates{}
