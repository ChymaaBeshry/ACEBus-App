import 'dart:io';
import 'package:ace_bus/Controller/UserCubit/userController.dart';
import 'package:ace_bus/Controller/UserCubit/userStates.dart';
import 'package:ace_bus/Model/userModel.dart';
import 'package:ace_bus/View/SharedWidget/InputFeildWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';

import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/imagesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? _image;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey emailKey = GlobalKey<ScaffoldState>();
  GlobalKey phoneKey = GlobalKey<ScaffoldState>();
  GlobalKey nameKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserController, UserStates>(builder: (context, state) {
      UserController userController = BlocProvider.of<UserController>(context);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: AppSize.size0,
          backgroundColor: ColorsManager.darkBlueColor,
          title: Text(
            StringsManager.myAccount,
            style: FontsManager.getTextStyleSemiBold(
                color: ColorsManager.whiteColor),
          ),
          leading: sharedIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconsManager.leftIcon,
            color: ColorsManager.whiteColor,
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.size20),
              child: ListTile(
                leading:CircleAvatar(
                        radius: AppSize.size30,
                        backgroundImage: AssetImage(ImagesManager.account)),
                  trailing:  CircleAvatar(
                      backgroundColor: ColorsManager.transparentColor,
                      radius: AppSize.size20,
                      child: sharedIcon(
                        color: ColorsManager.darkBlueColor,
                        icon: IconsManager.cameraIcon,
                        onPressed: () {
                          pickImage();
                        },
                      ),
                    ),
                title: text(userController.users[0].userName),
                subtitle: text(userController.users[0].userEmail),
              ),
            ),
            Column(
             children: [
               InputField(
                 model: InputModel(
                     controller: fullNameController,
                     key: nameKey,
                     prefix: IconsManager.personIcon,
                     keyboardType: TextInputType.text,
                     title: userController.users[0].userName,
                     onSubmitted: () {
                       userController.users[0].userName = fullNameController.text;
                     },
                     validator: (fullNameController) {}),
               ),
               InputField(
                 model: InputModel(
                     controller: emailController,
                     key: emailKey,
                     prefix: IconsManager.emailIcon,
                     keyboardType: TextInputType.emailAddress,
                     title: userController.users[0].userEmail,
                     onSubmitted: () {
                       userController.users[0].userEmail = emailController.text;
                     },
                     validator: (emailController) {}),
               ),
               InputField(
                 model: InputModel(
                     controller: phoneController,
                     key: phoneKey,
                     prefix: IconsManager.phoneIcon,
                     keyboardType: TextInputType.phone,
                     title: userController.users[0].userPhone,
                     onSubmitted: () {
                       userController.users[0].userPhone = phoneController.text;
                     },
                     // validateTitle: "enter Your Phone Number",
                     validator: (phoneController) {}),
               ),
               sharedButton(title: StringsManager.update, onPressed: () {
                 UserModel user=UserModel(
                     userName: fullNameController.text,
                     userEmail: emailController.text,
                     userPassword:userController.users[0].userPassword,
                     userPhone: phoneController.text);
                 userController.updateUser(user,userController.users[0].uid);
                 snack("Updated Successfully");
               })
             ],
           )
          ],
        ),
      );
    });
  }

  Future pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }
}
