import 'package:ace_bus/Model/companyModel.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
class DetailsCompany extends StatelessWidget {
   DetailsCompany({Key? key,required this.companyModel}) : super(key: key);
   CompanyModel companyModel;
  @override
  Widget build(BuildContext context) {
    List contactData=[
      {
        "icon": IconsManager.emailIcon,
        "title":  StringsManager.email,
        "subTitle":companyModel.companyEmail
      },
      {
        "icon": IconsManager.locationIcon,
        "title":  StringsManager.location,
        "subTitle":companyModel.companyWebsite,
      },
      {
        "icon": IconsManager.phoneIcon,
        "title":  StringsManager.hotLine,
        "subTitle":companyModel.companyHotline,
      },
      {
        "icon": IconsManager.watchIcon,
        "title":  StringsManager.availableTimes,
        "subTitle":companyModel.companyAvailableTime,
      },
    ];
    return Scaffold(
      body:Column(
          children: [
            Container(
              height: AppSize.size150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(companyModel.companyImg)
                )
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.size40),
                child: Text(
                  companyModel.companyName,
                    style: FontsManager.getTextStyleBold(
                        color: ColorsManager.greenColor,size: AppSize.size40),
                ),
              ),
            ),
            decoration(
              width: AppSize.size300,
              smallHeight: AppSize.size300,
              widget: Column(
                children: [
                  for(int i=0 ; i<=3 ;i++)
                    contactSection(contactData[i]["icon"],contactData[i]["title"],contactData[i]["subTitle"]),
                ],
              ),
            )

//widget.companyModel.companyName
          ],

        ),

    );
  }
   Column contactSection(IconData icon,String title,String subTitle)=> Column(
      children: [
        ListTile(
          leading:Icon(icon,color: ColorsManager.lightBlueColor,),
          title:Text(title,style:FontsManager.getTextStyleMedium(color:ColorsManager.darkBlueColor),),
          subtitle: Text(subTitle,style: FontsManager.getTextStyleLight(color: ColorsManager.greyLightColor),),

        ),
        //divider(ColorsManager.backGroundColor)
      ],

  );
}

