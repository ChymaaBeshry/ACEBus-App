import 'package:ace_bus/Controller/BottomNavBarCubit/BottomNavBarController.dart';
import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/MapCubit/mapController.dart';
import 'package:ace_bus/Controller/UserCubit/userController.dart';
import 'package:ace_bus/Controller/blocObserver.dart';
import 'package:ace_bus/View/Screens/BottomNavBarScreen/BottomNavBarScreen.dart';
import 'package:ace_bus/View/Screens/User/loginScreen.dart';
import 'package:ace_bus/View/Screens/User/signUpScreen.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool isUser=false;
@override
  void initState() {
  check();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=> MapController(),),
        BlocProvider(create: (context)=> BottomNavBarController(),),
        BlocProvider(create: (context)=> CompanyController(),),
        BlocProvider(create: (context)=> UserController(),),

      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsManager.whiteColor
        ),
        routes: {
          "login":(context)=>const  LoginScreen(),
          "signUp":(context)=>const SignUpScreen(),
          "bottomNavBar":(context)=>const BottomNavBarScreen(),
        },
        debugShowCheckedModeBanner: false,
        home:isUser? const LoginScreen():const SignUpScreen(),
      ),
    );//isUser? const LoginScreen():const SignUpScreen()
  }

check()async{
    try{
      SharedPreferences save=await SharedPreferences.getInstance();
      int isExist=save.getInt("userId")!;
      print(isExist);
      if(isExist == 1){
        return isUser=true;
      }else{
        return isUser=false;
      }
    }catch(e){
      return isUser=false;
    }
}
}
