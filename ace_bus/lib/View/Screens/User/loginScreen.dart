import 'package:ace_bus/Controller/UserCubit/userController.dart';
import 'package:ace_bus/Controller/UserCubit/userStates.dart';
import 'package:ace_bus/Model/userModel.dart';
import 'package:ace_bus/View/Screens/BottomNavBarScreen/BottomNavBarScreen.dart';
import 'package:ace_bus/View/Screens/User/signUpScreen.dart';
import 'package:ace_bus/View/SharedWidget/InputFeildWidget.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/imagesManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
 const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController resetEmailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey emailKey = GlobalKey<ScaffoldState>();
  GlobalKey phoneKey = GlobalKey<ScaffoldState>();
  GlobalKey resetEmailKey = GlobalKey<ScaffoldState>();

  GlobalKey passwordKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool check = false;
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<UserController,UserStates>(
   builder:(context,state){
     UserController userController =BlocProvider.of<UserController>(context);
     return Scaffold(
         backgroundColor: ColorsManager.whiteColor,
         body: Form(
             key: _formKey,
             child: ListView(
                 children: [
                   Text("\n${StringsManager.nameApp}\n",style: FontsManager.getTextStyleBold(
                     size: AppSize.size25,
                     color: ColorsManager.darkBlueColor,
                   ),textAlign: TextAlign.center,),
                   Text(StringsManager.findCheapBusTickets,style: FontsManager.getTextStyleRegular(
                     color: ColorsManager.lightBlueColor,
                   ),textAlign: TextAlign.center,),
                   Container(
                     height: AppSize.size200,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage(ImagesManager.logo),
                           fit: BoxFit.fill,
                         )),
                   ),
                   Column(
                       children: [
                         InputField(
                           model: InputModel(
                               controller: emailController,
                               key: emailKey,
                               prefix: IconsManager.emailIcon,
                               keyboardType: TextInputType.emailAddress,
                               title: StringsManager.email,
                               validator: (emailController) {
                                 if (emailController.isEmpty) {
                                   return StringsManager.pleaseEnterThisField;
                                 }else{
                                   for (UserModel user in userController.users) {
                                     if (user.userEmail != emailController) {
                                       return StringsManager.wrongEmailPleaseTryAgain;
                                     }
                                   }
                                 }

                               }
                           ),
                         ),
                         InputField(
                           model: InputModel(
                               controller: passwordController,
                               key: passwordKey,
                               isSecure: true,
                               prefix: IconsManager.passwordIcon,
                               keyboardType: TextInputType.visiblePassword,
                               title: StringsManager.password,
                               validator: (passwordController) {
                                 if (passwordController.isEmpty) {
                                   return StringsManager.pleaseEnterThisField;
                                 }else{
                                   for (UserModel user in userController.users) {
                                     if (user.userPassword != passwordController) {
                                       return StringsManager.wrongPasswordPleaseTryAgain;
                                     }
                                   }
                                 }

                               }
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 Checkbox(
                                   onChanged: (value) {
                                     setState(() {
                                       check = value!;
                                     });
                                   },
                                   value: check,
                                   activeColor: ColorsManager.lightBlueColor,
                                   hoverColor: ColorsManager.darkBlueColor,
                                   focusColor: ColorsManager.lightBlueColor,
                                   checkColor: ColorsManager.darkBlueColor,
                                 ),
                                 const Text(StringsManager.remember),
                               ],
                             ),
                             InkWell(
                                 child: Text(StringsManager.forgotYourPassword,style: FontsManager.getTextStyleLight(
                                     size: AppSize.size20
                                 ),),
                                 onTap: () {
                                   showDialog(
                                       context: context,
                                       builder: (context) {
                                         return AlertDialog(
                                           title:  Text(StringsManager.forgotYourPassword,style: FontsManager.getTextStyleRegular(
                                             color: ColorsManager.lightBlueColor,
                                           ),),
                                           content: Column(
                                             mainAxisSize: MainAxisSize.min,
                                             children: [
                                               InputField(
                                                 model: InputModel(
                                                     key: resetEmailKey,
                                                     keyboardType: TextInputType.emailAddress,
                                                     controller: resetEmailController,
                                                     title: StringsManager.name,
                                                     prefix: IconsManager.emailIcon,
                                                     validator: (phoneController){
                                                       if(resetEmailController.text.isEmpty){
                                                         return "";
                                                       }
                                                     }
                                                 ),
                                               ),
                                               InputField(
                                                 model: InputModel(
                                                     key: phoneKey,
                                                     keyboardType: TextInputType.name,
                                                     controller: phoneController,
                                                     isSecure: true,
                                                     title: StringsManager.phone,
                                                     prefix: IconsManager.phoneIcon,
                                                     validator: (phoneController){
                                                       if(phoneController.isEmpty){
                                                         return "enter Your phone number";
                                                       }
                                                     }
                                                 ),
                                               ),
                                             ],
                                           ),
                                           actions: [
                                             TextButton(
                                               onPressed: () {
                                                 Navigator.pop(context);
                                               },
                                               child: Text(StringsManager.cancel,style: FontsManager.getTextStyleRegular(),),
                                             ),
                                             TextButton(
                                               onPressed: () {},
                                               child: Text(
                                                 StringsManager.send,
                                                 style: FontsManager.getTextStyleRegular(),
                                               ),
                                             ),
                                           ],
                                         );
                                       });
                                 })
                           ],
                         ),
                         sharedButton(
                             onPressed: (){
                               if(_formKey.currentState!.validate()) {
                                 Navigator.pushNamed(context, "bottomNavBar");
                               }
                             },
                             title:StringsManager.login)

                       ]
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(StringsManager.dontHaveAccount ,style: FontsManager.getTextStyleLight()),
                       sharedTextButton(title: StringsManager.sign,
                           color: ColorsManager.lightBlueColor
                           ,onPressed: () {
                         Navigator.pushNamed(
                             context,"signUp");
                       }),
                     ],
                   ),
                 ])),
       );
     }
   );
  }
}
