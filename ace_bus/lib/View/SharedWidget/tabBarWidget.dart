import 'package:ace_bus/Controller/TabBarCubit/tabBarController.dart';
import 'package:ace_bus/Controller/TabBarCubit/tabBarStates.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {

  List<String> titleTabBar = [
    StringsManager.recommended,
    StringsManager.cheapest,
    StringsManager.fastest,
  ];

  @override
  Widget build(BuildContext context) {
    TabBarController tabBarController=BlocProvider.of<TabBarController>(context);
    return BlocBuilder<TabBarController,TabBarStates>(
        builder: (context,state) {
          if (state is ChangeTabBarState) {
            return TabBar(
              // labelPadding: ,
                isScrollable: true,
                labelStyle: FontsManager.getTextStyleLight(
                    color: ColorsManager.darkBlueColor),
                indicator: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(
                      AppSize.size20),
                  shape: BoxShape.rectangle,
                  color: ColorsManager.whiteColor,
                ),
                padding: const EdgeInsetsDirectional.only(
                    bottom: AppSize.size10),
                labelColor: ColorsManager.darkBlueColor,
                unselectedLabelColor: ColorsManager.whiteColor,
                unselectedLabelStyle: FontsManager.getTextStyleLight(),
                onTap: (index) {
                  tabBarController.getNextPageTabBar(index);
                },
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                tabs: [
                  for (int i = 0; i < titleTabBar.length; i++)
                    Text(titleTabBar[i]),
                ]);
          } else {
            return centerLoading();
          }
        });
  }
  }


