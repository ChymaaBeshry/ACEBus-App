import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/View/SharedWidget/companyDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FastestScreen extends StatefulWidget {
   const FastestScreen({Key? key}) : super(key: key);

  @override
  State<FastestScreen> createState() => _FastestScreenState();
}

class _FastestScreenState extends State<FastestScreen> {
  List<Map>companyDetailSectionList=[
    {
      "icon":IconsManager.downIcon,
      "title":StringsManager.transfer,
    },
    {
      "icon":IconsManager.personIcon,
      "title":"2",
    },
    {
      "icon":IconsManager.roadIcon,
      "title":StringsManager.oneWay,
    },
  ];

  List<String>textBackgroundList=[
    "125 EGP","02:20"
  ];

  @override
  Widget build(BuildContext context) {
    CompanyController companyController=BlocProvider.of<CompanyController>(context);
    companyController.getFastestCompany();
            return Scaffold(
                body: ListView.builder(
                  itemBuilder: (context, index) =>
                      CompanyDetailsWidget(
                        companyModel: companyController.fastest[index],
                        isDetail: false,),
                  itemCount: companyController.fastest.length,)

    );
  }
}

