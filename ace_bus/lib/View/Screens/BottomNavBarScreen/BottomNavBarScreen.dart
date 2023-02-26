import 'package:ace_bus/Controller/BottomNavBarCubit/BottomNavBarController.dart';
import 'package:ace_bus/Controller/BottomNavBarCubit/BottomNavBarStates.dart';

import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  List<Map>bottomNavBarData=[
    {
      "icon":IconsManager.houseIcon,
      "title":StringsManager.home,
      "selectedColor":ColorsManager.whiteColor
    },
    {
      "icon":IconsManager.ticketIcon,
      "title":StringsManager.trips,
      "selectedColor":ColorsManager.whiteColor    },
    {
      "icon":IconsManager.accountIcon,
      "title":StringsManager.profile,
      "selectedColor":ColorsManager.whiteColor    }
  ];
   int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    BottomNavBarController bottomController=BlocProvider.of<BottomNavBarController>(context);
    return BlocBuilder<BottomNavBarController,BottomNavBarStates>(
    builder: (context,state){
      if(state is BottomNavBarChangeScreenState){
        return Scaffold(
            body: state.screen,
            bottomNavigationBar: Container(
              margin:const EdgeInsetsDirectional.all(AppSize.size25),
              decoration: BoxDecoration(
                color: ColorsManager.darkBlueColor,
                borderRadius: BorderRadiusDirectional.circular(AppSize.size50),
              ),
              child: SalomonBottomBar(
                  itemShape:const StadiumBorder(
                    side: BorderSide(
                      color: ColorsManager.whiteColor,
                      width: AppSize.sizeD1,
                      style: BorderStyle.solid,
                    ),
                  ) ,
                  curve: Curves.easeOutQuint ,
                  duration:const Duration(milliseconds: 700),
                  currentIndex: currentIndex,
                  margin:const EdgeInsets.all(AppSize.size5),
                  onTap: (i) => bottomController.getNextPageBottomNavBar(i),
                  items: [
                    for(int i=0 ; i<bottomNavBarData.length; i++)
                      SalomonBottomBarItem(
                        unselectedColor: ColorsManager.redColor,
                        icon: Icon(bottomNavBarData[i]["icon"],color:ColorsManager.whiteColor),
                        title:Text( bottomNavBarData[i]["title"]),
                        selectedColor:bottomNavBarData[i]["selectedColor"] ,
                      ),
                  ]


              ),
            )
        );
      }else{
        return centerErrorText();
      }

    },
  );
  }

  /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton:Row(
          children: [
            for(int i=0 ; i<bottomNavBarData.length ; i++ )
            floatingSection(bottomNavBarData[i]["icon"],bottomNavBarData[i]["title"],bottomNavBarData[i]["left"],i),
          ],
        )
  InkWell floatingSection(IconData icon, String title,double left,index){
    return  InkWell(
      onTap: (){
        setState(() {
          currentIndex=index;
        });
      },
      child: Container(
        margin:EdgeInsets.fromLTRB(left, AppSize.size20, AppSize.size20, AppSize.size40),
        height: AppSize.size50,
        width:AppSize.size50,
       // alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.size30),
          color: ColorsManager.lightBlueColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: ColorsManager.darkBlueColor,),
            Text(title,style: FontsManager.getTextStyleLight(color: ColorsManager.darkBlueColor,size: AppSize.size15),),
          ],
        ),
      ),
    ) ;
  }
*/
}

























/*bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon:Row(
                  children: [
                    Icon( Icons.house),
                    Text("home")
                  ],
                )),
            BottomNavigationBarItem(
                icon:Icon( Icons.house),
            label: "home"),
            BottomNavigationBarItem(
                icon:Icon( Icons.house),
                label: "home"),
            BottomNavigationBarItem(
                icon:Icon( Icons.house),
                label: "home"),
          ]),*/