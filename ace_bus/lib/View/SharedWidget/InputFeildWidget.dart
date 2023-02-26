import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';

class InputModel{
  TextInputType keyboardType;
  TextEditingController controller;
  GlobalKey key;
  Function? onSubmitted=(){};
  Function(String) validator;
  IconData prefix;
  IconData? suffix;
  String title;
  String hint;
  bool isSecure;
  bool outoCorrect;
  String  validateTitle;
  double width;
  InputModel({
    required this.key,
    required this.controller,
    this.title="",
    this.hint="",
    required this.prefix,
    this.isSecure=false,
    this.outoCorrect=true,
    this.keyboardType=TextInputType.text,
    this.onSubmitted,
    required this.validator,
    this.validateTitle="",
    this.width=double.infinity,
    this.suffix

  });

}


class InputField extends StatefulWidget {
  InputField({Key? key,  required this.model}) : super(key: key);
  InputModel model;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(
        vertical:AppSize.size10 ,
        horizontal:AppSize.size5,
      ),
      width:widget.model.width ,
      child: TextFormField(
          keyboardType:widget.model.keyboardType,
          controller: widget.model.controller,
          key:widget.model.key ,
          onFieldSubmitted:(x){
            widget.model.onSubmitted!();
          },
          validator:(x){
            return widget.model.validator(x!.toString());

          } ,
          obscureText:widget.model.isSecure ,
          autocorrect:widget.model.outoCorrect ,
          decoration:InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.size10)),
            labelText:widget.model.title ,
            labelStyle:FontsManager.getTextStyleLight() ,
            hintText:widget.model.hint ,
            hintStyle:FontsManager.getTextStyleLight(color: ColorsManager.greyLightColor,size: AppSize.size15) ,
            prefixIcon: Icon(widget.model.prefix,size: AppSize.size20,color: ColorsManager.darkBlueColor,),
            suffixIcon:widget.model.prefix==IconsManager.passwordIcon?sharedIcon(
                icon: IconsManager.eyeIcon,
                onPressed: (){
                  setState((){
                    widget.model.isSecure= !widget.model.isSecure;
                  });
                },
                color: ColorsManager.lightBlueColor) : Icon(widget.model.suffix,color: ColorsManager.lightBlueColor,) ,
            errorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.size20),
              borderSide:const BorderSide(
                color:ColorsManager.redColor,
                width: AppSize.sizeD1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.size20),
              borderSide:const BorderSide(
                color: ColorsManager.darkBlueColor,
                width: AppSize.sizeD1,
              ),
            ),
            enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.size20),
              borderSide:const BorderSide(
                width: AppSize.sizeD1,
                color: ColorsManager.darkBlueColor,
              ),
            ),

          )



      ),
    );
  }
}
