import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/CompanyCubit/CompanyStates.dart';
import 'package:ace_bus/View/SharedWidget/ticketWidget.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripsScreen extends StatefulWidget {
   const TripsScreen({Key? key,}) : super(key: key);
  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
@override
  void initState() {
  BlocProvider.of<CompanyController>(context).getUserTicket();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CompanyController companyController=BlocProvider.of<CompanyController>(context);
    return  BlocBuilder<CompanyController,CompanyStates>(
    builder: (context,state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsManager.darkBlueColor,
              title: Text("Trips", style: FontsManager.getTextStyleBold(
                color: ColorsManager.whiteColor,
                size: AppSize.size30,
              ),),
              centerTitle: true,
              actions: [
                sharedIcon(
                    icon:IconsManager.deleteIcon ,
                    color: ColorsManager.whiteColor,
                    onPressed:()async{
                      companyController.deleteAllTickets();
                    }
                )
              ],
            ),
            body: ListView.builder(
              itemBuilder: (context, index) =>
              TicketWidget(ticketModel: companyController.userTickets[index]),
              itemCount: companyController.userTickets.length,
            ),
        );
      }

    );
  }
}
