
import 'package:ace_bus/Controller/TabBarCubit/tabBarStates.dart';
import 'package:ace_bus/View/Screens/Company/Search/cheapest.dart';
import 'package:ace_bus/View/Screens/Company/Search/fastest.dart';
import 'package:ace_bus/View/Screens/Company/Search/recommended.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class TabBarController extends Cubit<TabBarStates>{
  TabBarController():super(InitialTabBarState());

  List<Widget> tabBarScreens = [
    RecommendedScreen(),
    CheapestScreen(),
    FastestScreen(),
  ];
  int currentIndex=0;

 void getNextPageTabBar(index) {
    print(index);
    currentIndex=index;
    print(currentIndex);
    emit(ChangeTabBarState(index: index, screen: tabBarScreens[currentIndex]));
  }
}