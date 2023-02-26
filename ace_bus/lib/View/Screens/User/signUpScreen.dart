import 'package:ace_bus/Controller/UserCubit/userController.dart';
import 'package:ace_bus/Controller/UserCubit/userStates.dart';
import 'package:ace_bus/Model/userModel.dart';
import 'package:ace_bus/View/Screens/User/loginScreen.dart';
import 'package:ace_bus/View/SharedWidget/InputFeildWidget.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmCPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  GlobalKey emailKey = GlobalKey<ScaffoldState>();
  GlobalKey phoneKey = GlobalKey<ScaffoldState>();
  GlobalKey passwordKey = GlobalKey<ScaffoldState>();
  GlobalKey confirmPasswordKey = GlobalKey<ScaffoldState>();
  GlobalKey nameKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool check = false;

  @override
  Widget build(BuildContext context) {
    UserController userController=BlocProvider.of<UserController>(context);
    return BlocBuilder<UserController,UserStates>(
        builder: (context,state){
          return Scaffold(
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text("\n${StringsManager.welcome}",style: FontsManager.getTextStyleBold(
                    size: AppSize.size25,
                    color: ColorsManager.darkBlueColor,
                  ),textAlign: TextAlign.center,
                  ),
                  Text(StringsManager.createYourAccount,style: FontsManager.getTextStyleRegular(
                    color: ColorsManager.lightBlueColor,
                  ),textAlign: TextAlign.center,),
                  text(StringsManager.name),

                  InputField(
                    model: InputModel(
                      controller: fullNameController,
                      key: nameKey,
                      prefix: IconsManager.personIcon,
                      keyboardType: TextInputType.text,
                      title: StringsManager.name,
                      validator: (fullNameController){
                        if(fullNameController.isEmpty){
                          return "enter Your Full Name";
                        }
                      },
                      onSubmitted: (){
                        userController.users[0].userName=fullNameController.text;
                      }
                    ),
                  ),
                  text(StringsManager.email),

                  InputField(
                    model: InputModel(
                        controller: emailController,
                        key: emailKey,
                        prefix: IconsManager.emailIcon,
                        keyboardType: TextInputType.emailAddress,
                        title: StringsManager.email,
                        validateTitle: "enter Your Email",
                        onSubmitted: (){
                          userController.users[0].userEmail=emailController.text;

                          for(UserModel user in BlocProvider.of<UserController>(context).users ){
                          if(user.userEmail == emailController.text) {
                            return snack("email already used ");
                          }
                          }
                        },
                        validator:(emailController){
                          if(emailController.isEmpty){
                            return "enter your email";
                          }else if(!emailController.contains("@gmail.com")){
                                   return "please enter @gmail.com";
                          }
                          }

                    ),
                  ),

                  text(StringsManager.password),

                  InputField(
                    model: InputModel(
                        controller: passwordController,
                        key: passwordKey,
                        isSecure: true,
                        prefix: IconsManager.passwordIcon,
                        keyboardType: TextInputType.visiblePassword,
                        title: StringsManager.password,
                        validator:(phoneController){
                          if(passwordController.text.length <12 ){
                            return "please enter password 12 numbers and contain on characters ";
                          }else if(passwordController.text.isEmpty){
                            return "enter your Password";
                          }
                        },
                      onSubmitted: (){
                        userController.users[0].userPassword=passwordController.text;

                      }
                    ),
                  ),
                  text(StringsManager.confirm),
                  InputField(
                    model: InputModel(
                        controller: confirmCPasswordController,
                        key: confirmPasswordKey,
                        isSecure: true,
                        prefix: IconsManager.passwordIcon,
                        keyboardType: TextInputType.visiblePassword,
                        title: StringsManager.confirmPassword,
                        validator:(phoneController){
                          if(passwordController.text != confirmCPasswordController.text ){
                            return "password doesn't match";
                          }else if(confirmCPasswordController.text.isEmpty){
                            return "enter your  confirm Password";
                          }

                        }
                    ),
                  ),
                  text(StringsManager.phone),
                  InputField(
                    model: InputModel(
                        controller: phoneController,
                        key: phoneKey,
                        prefix: IconsManager.phoneIcon,
                        keyboardType: TextInputType.phone,
                        title: StringsManager.phone,
                        // validateTitle: "enter Your Phone Number",
                        validator:(phoneController){
                          if(phoneController.length > 11 ){
                            return "pleas enter 11 numbers";
                          }else if(phoneController.isEmpty){
                            return "enter your  phone number";
                          }
                        },
                      onSubmitted: (){
                        userController.users[0].userPhone=phoneController.text;
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
                          const Text(StringsManager.acceptTermsConditions),
                        ],
                      ),
                     Row(
                       children: [
                         sharedTextButton(title: StringsManager.login,
                             color: ColorsManager.lightBlueColor
                         ,onPressed: () {
                           Navigator.pushNamed(
                               context, "login");
                         }),
                       ],
                     )
                    ],
                  ),
                  sharedButton(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          BlocProvider.of<UserController>(context).signup(
                               emailController.text,passwordController.text);
                          SharedPreferences saveUser= await SharedPreferences.getInstance();
                          saveUser.setInt("userId",1);
                          UserModel user= UserModel(
                              userName: fullNameController.text,
                              userEmail: emailController.text,
                              userPassword: passwordController.text,
                              userPhone:phoneController.text,);
                          print(user);
                          userController.addUser(user);
                          userController.users.add(user);
                          Navigator.pushNamed(context, "bottomNavBar");
                        }
                      },
                      title:StringsManager.sign)

                ],
              ),
            ),
          );
        });
  }
}
/* SharedPreferences saveUser= await SharedPreferences.getInstance();
                          saveUser.setInt("userId",1);
                          users.add(UserModel(
                              uid: saveUser.getInt("userId")!,
                              userName: fullNameController.text,
                              userEmail: emailController.text,
                              userPassword: passwordController.text,
                              userPhone: int.parse(phoneController.text)));
                          print(users);
                          print(users.length);*/