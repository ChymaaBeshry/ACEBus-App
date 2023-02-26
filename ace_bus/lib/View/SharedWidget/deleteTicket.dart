import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/CompanyCubit/CompanyStates.dart';
import 'package:ace_bus/Model/ticketModel.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DeleteTicket extends StatefulWidget {
   DeleteTicket({Key? key,required this.ticketModel}) : super(key: key);
TicketModel ticketModel;
  @override
  State<DeleteTicket> createState() => _DeleteTicketState();
}

class _DeleteTicketState extends State<DeleteTicket> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyController,CompanyStates>(
      builder:(context,state){
        return sharedIcon(
          icon: IconsManager.deleteIcon ,
          color:ColorsManager.darkBlueColor,
          onPressed: ()async{
             BlocProvider.of<CompanyController>(context).deleteOneTicket(widget.ticketModel);
          },
        );
      }
    );
  }
}
