
import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ace_bus/Controller/UserCubit/userStates.dart';
import 'package:ace_bus/Model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class UserController extends Cubit<UserStates>{
  UserController():super(InitialUserState()){
   getUsers();
  }
List<UserCredential> usersFirebaseList=[];
List<UserModel> users=[];

 Future<void> signUp({ required String email,required  String password})async {
   emit(LoadingUserState());
   try {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password);
     emit(SuccessUserState());
   } catch (error) {
     print(error);
     emit(ErrorUserState());
   }
 }
 Future<void> signup(String email, String password)async{
   emit(LoadingUserState());
   try {
   final UserCredential userFirebase = await FirebaseAuth.instance.createUserWithEmailAndPassword(
   email: email,
   password: password,
   );
   usersFirebaseList.add(userFirebase);
   emit(SuccessUserState());

   } on FirebaseAuthException catch (e) {
   emit(SuccessUserState());
   if (e.code == 'weak-password') {
   print('The password provided is too weak.');
   } else if (e.code == 'email-already-in-use') {
   print('The account already exists for that email.');
   }
   } catch (e) {
   print(e);
   }
   }
 Future<void> loginIn(String email, String password)async{
   emit(LoadingUserState());
   try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password);
     emit(SuccessUserState());
   }catch(error){
     print(error);
     emit(ErrorUserState());
   }
 }

  Future<void> getUsers()async{
    emit(LoadingUserState());
    try{
      http.Response res=await http.get(Uri.parse("$domain/users.json"));
      if(res.statusCode == 200){
       Map data=json.decode(res.body);
       data.forEach((key, value) {
         users.add(UserModel.fromJson(key, value));
       });
        emit(SuccessUserState());
      }else{
        emit(ErrorUserState());
      }
    }catch(error){
      print(error);
      emit(ErrorUserState());
    }
  }

  Future<void> addUser(UserModel user)async{
 emit(LoadingUserState());
 Map sendingDate={
 "userName": user.userName,
 "userEmail": user.userEmail,
 "userPassword": user.userPassword,
 "userPhone":user.userPhone
 };
  try{
    http.Response res=await http.post(Uri.parse("$domain/users.json"),
    body: json.encode(sendingDate));
    if(res.statusCode == 200){
    emit(SuccessUserState());
    }else{
      emit(ErrorUserState());
    }
  }catch(error){
    print(error);
    emit(ErrorUserState());
  }
 }

  Future<void> updateUser(UserModel user , String key)async{
    emit(LoadingUserState());
    Map sendingDate={
      "userName": user.userName,
      "userEmail": user.userEmail,
      "userPassword": user.userPassword,
      "userPhone":user.userPhone
    };
    try{
      http.Response res=await http.put(Uri.parse("$domain/users/$key.json"),
          body: json.encode(sendingDate));
      if(res.statusCode == 200){
        emit(SuccessUserState());
      }else{
        emit(ErrorUserState());
      }
    }catch(error){
      print(error);
      emit(ErrorUserState());
    }
  }
}


