
import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/CompanyCubit/CompanyStates.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key,
    required this.distance,
    required this.locationFrom,
    required this.locationTo,
    required this.date
}) : super(key: key);
String locationFrom;
String locationTo;
String date;
num distance;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> titleTabBar = [
    StringsManager.recommended,
    StringsManager.cheapest,
    StringsManager.fastest,
];

  @override
  Widget build(BuildContext context) {
    CompanyController companyController=BlocProvider.of<CompanyController>(context);
    return BlocBuilder<CompanyController,CompanyStates>(
        builder: (context,state){
          if(state is LoadingCompanyState){
            return centerLoading();
          }else if(state is ErrorCompanyState){
            return centerErrorText();
          }else{
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: ColorsManager.darkBlueColor,
                    centerTitle: true,
                    leading: sharedIcon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: IconsManager.leftIcon,
                          color: ColorsManager.whiteColor,
                        ),
                    title: Column(
                      children: [
                        Text(
                          "${widget.locationFrom},${widget.locationTo}",
                          style: FontsManager.getTextStyleBold(
                              color: ColorsManager.whiteColor),
                        ),
                        Text(
                          widget.date,
                          style: FontsManager.getTextStyleLight(
                              color: ColorsManager.whiteColor),
                        ),
                      ],
                    ),
                    bottom:TabBar(
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
                          companyController.move(index);
                        },
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.white,
                        tabs: [
                          for (int i = 0; i < titleTabBar.length; i++)
                            Text(titleTabBar[i]),
                        ])
                ),
                body:companyController.tabBarScreens[companyController.currentIndex],
              ),
            );
          }

          }
    );

  }
}
/* body: ListView(
        children: [
          Container(
            height: AppSize.size170,
            color: ColorsManager.darkBlueColor,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(IconsManager.leftIcon,color: ColorsManager.whiteColor,)),
                   const SizedBox(width: AppSize.size70,),
                    Column(
                      children:[
                        Text("Cairo, Egypt",style: FontsManager.getTextStyleBold(color: ColorsManager.whiteColor),),
                        Text("2/6/2022",style: FontsManager.getTextStyleLight(color: ColorsManager.whiteColor),),
                      ],
                    ),
                  ],
                ),
                TabBar(
                  controller: ,
                tabs:const[
                 Text("Recommende"),
                  Text("Cheapest"),
                  Text("Fastest"),
              ],
                )
              ],
            )
          ),
        ],
      ),*/
