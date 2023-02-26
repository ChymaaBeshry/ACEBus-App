import 'package:ace_bus/Controller/BottomNavBarCubit/BottomNavBarStates.dart';
import 'package:ace_bus/View/Screens/BottomNavBarScreen/accountScreen.dart';
import 'package:ace_bus/View/Screens/BottomNavBarScreen/tripsScreen.dart';
import 'package:ace_bus/View/Screens/BottomNavBarScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarController extends Cubit<BottomNavBarStates>{

  BottomNavBarController():super(BottomNavBarChangeScreenState(index: 0, screen:const HomeScreen()));
  List<Widget> screens=const[
     HomeScreen(),
     TripsScreen(),
     AccountScreen(),
  ];

  getNextPageBottomNavBar(index) {
    emit(BottomNavBarChangeScreenState(index: index, screen: screens[index]));
  }

}