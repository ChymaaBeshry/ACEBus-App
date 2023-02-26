import 'package:flutter/material.dart';

abstract class TabBarStates{}
class InitialTabBarState extends TabBarStates{}
class ChangeTabBarState extends TabBarStates{
  int index;
  Widget screen;
  ChangeTabBarState({
    required this.index,
    required this.screen,
  });
}