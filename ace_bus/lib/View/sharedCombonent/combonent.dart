import 'package:ace_bus/Model/userModel.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:flutter/material.dart';

List<UserModel> users = [];
List<DateTime> startDates = [
  DateTime.utc(2022, 22, 11, 01, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 01, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 02, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 02, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 03, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 03, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 04, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 04, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 05, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 05, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 06, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 06, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 07, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 07, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 08, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 08, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 09, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 09, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 10, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 10, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 11, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 11, 30, 25, 00000),
  DateTime.utc(2022, 22, 11, 12, 00, 25, 00000),
  DateTime.utc(2022, 22, 11, 12, 30, 25, 00000),
];


List<String> textBackgroundList = ["125 EGP", "02:20"];

Container sharedButton({
  required Function onPressed,
  required String title,
}) =>
    Container(
        margin: const EdgeInsets.symmetric(vertical: AppSize.size10),
        height: AppSize.size50,
        width: AppSize.size250,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.size50),
          color: ColorsManager.darkBlueColor,
        ),
        child: TextButton(
            onPressed: () {
              onPressed();
            },
            child: Text(
              title,
              style: FontsManager.getTextStyleRegular(
                  color: ColorsManager.whiteColor),
            )));

Container companyDetailSection(IconData icon, String title) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
        shape: BoxShape.rectangle,
        color: ColorsManager.lightGreyColor,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorsManager.greenColor,
          ),
          Text(
            "      $title    ",
            style: FontsManager.getTextStyleLight(
                color: ColorsManager.darkBlueColor),
          ),
        ],
      ),
    );

Container textBackground(String title) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(AppSize.size15),
        color: ColorsManager.lightGreyColor,
      ),
      alignment: Alignment.center,
      height: AppSize.size20,
      width: AppSize.size100,
      child: Text(
        title,
        style: FontsManager.getTextStyleLight(
          color: ColorsManager.blackColor,
        ),
      ),
    );

Padding divider(Color color) => Padding(
      padding: const EdgeInsets.only(bottom: AppSize.size15),
      child: Divider(
        height: AppSize.sizeD1,
        color: color,
        thickness: AppSize.sizeD1,
        endIndent: AppSize.size25,
        indent: AppSize.size25,
      ),
    );

Text text(String title) => Text(
      "   $title",
      style:
          FontsManager.getTextStyleRegular(color: ColorsManager.darkBlueColor),
    );

SnackBar snack(String title) => SnackBar(
      content: Text(title),
      backgroundColor: ColorsManager.darkBlueColor,
      width: double.infinity,
      shape: const StadiumBorder(
        side: BorderSide(
          color: ColorsManager.lightBlueColor,
          style: BorderStyle.solid,
          width: AppSize.sizeD1,
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
IconButton sharedIcon(
    {required IconData icon,
    required Function onPressed,
    required Color color}) {
  return IconButton(
      padding: const EdgeInsetsDirectional.all(AppSize.size5),
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        icon,
        color: color,
      ));
}

TextButton sharedTextButton(
    {required String title,
    required Function onPressed,
    required Color color}) {
  return TextButton(
    child: Text(
      title,
      style: FontsManager.getTextStyleMedium(color: color),
    ),
    onPressed: () {
      onPressed();
    },
  );
}

Container decoration(
        {required Widget widget,
        required double smallHeight,
        required double width}) =>
    Container(
      margin: const EdgeInsets.all(AppSize.size5),
      padding: const EdgeInsets.all(AppSize.sizeD1),
      height: smallHeight+AppSize.size20,
      width: width,
      decoration: BoxDecoration(
          color: ColorsManager.darkBlueColor,
          borderRadius: BorderRadius.circular(AppSize.size20)),
      child: Container(
        height: smallHeight,
        width: AppSize.size250,
        decoration: BoxDecoration(
            color: ColorsManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.size20)),
        child: widget,
      ),
    );
Center centerLoading()=>const Center(
  child: CircularProgressIndicator(),
);

Center centerErrorText()=>const Center(
  child: Text(StringsManager.somethingWentWrong),
);