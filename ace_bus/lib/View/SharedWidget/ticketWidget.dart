import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Model/ticketModel.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/imagesManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketWidget extends StatefulWidget {
  TicketWidget({Key? key, required this.ticketModel}) : super(key: key);
  TicketModel ticketModel;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children:[

            Container(
              margin: const EdgeInsetsDirectional.all(AppSize.size10),
              decoration: BoxDecoration(
                color: ColorsManager.backGroundColor,
                borderRadius: BorderRadiusDirectional.circular(AppSize.size10),
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: AppSize.size40,
                        backgroundImage: AssetImage(ImagesManager.account),
                      ),
                      title: Text(widget.ticketModel.userName),
                      subtitle: Text(widget.ticketModel.userPhone),
                      trailing: column("${widget.ticketModel.tripPrice} EGP",
                          "${widget.ticketModel.numOfTravellers} Traveler"),
                    ),
                    ListTile(
                      leading: Text(
                          widget.ticketModel.companyName,
                          style: FontsManager.getTextStyleBold(
                              color: ColorsManager.greenColor),
                      ),
                      title: Text(widget.ticketModel.companyLocationFrom),
                      subtitle: Text(widget.ticketModel.companyLocationTo),
                      trailing:column(
                          "\n${widget.ticketModel.companyStartTimeTrip.hour}: ${widget.ticketModel.companyStartTimeTrip.minute}",
                        "${widget.ticketModel.companyEndTimeTrip.hour} :${widget.ticketModel.companyEndTimeTrip.minute}"),
                    ),
                  ]),
            ),
            InkWell(onTap:  () async{
              BlocProvider.of<CompanyController>(context).deleteOneTicket(widget.ticketModel);
            },
                child: const Icon( IconsManager.deleteIcon , color:ColorsManager.darkBlueColor,)),
          ],
        );

  }
  Column column(String title1 , String title2) =>Column(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  Text(title1),
  Text(title2),
  ],
  );
}
