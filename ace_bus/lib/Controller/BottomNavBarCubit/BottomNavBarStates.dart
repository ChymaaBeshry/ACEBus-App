import 'package:flutter/material.dart';
abstract class BottomNavBarStates{}
class BottomNavBarChangeScreenState extends BottomNavBarStates{
  int index;
  Widget screen;
  BottomNavBarChangeScreenState({
    required this.index,
    required this.screen
});
}
