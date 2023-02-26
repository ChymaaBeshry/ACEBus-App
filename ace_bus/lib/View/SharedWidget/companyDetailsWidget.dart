import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/CompanyCubit/CompanyStates.dart';
import 'package:ace_bus/Model/companyModel.dart';
import 'package:ace_bus/View/Screens/Company/detailsCompany.dart';
import 'package:ace_bus/View/Screens/Company/detailsTrip.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyDetailsWidget extends StatefulWidget {
  CompanyDetailsWidget({Key? key, required this.companyModel,required this.isDetail,})
      : super(key: key);
  CompanyModel companyModel;
  bool isDetail=false;

  @override
  State<CompanyDetailsWidget> createState() => _CompanyDetailsWidgetState();
}

class _CompanyDetailsWidgetState extends State<CompanyDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    String timeT = widget.companyModel.companyTripTime;
    int hourT = int.parse(timeT.substring(0, 1)); //tot
    int minuteT = int.parse(timeT.substring(2, 3)); //
    num availableSeat = 14-(widget.companyModel.companyNumberOfTravelers );
    CompanyController companyController = BlocProvider.of<CompanyController>(context);
    //companyController.totalBooked=14-( widget.companyModel.companyNumberOfTravelers+ selectedSeat);
    return BlocBuilder<CompanyController , CompanyStates>(
         builder: (context ,state){
          return Container(
            margin:const EdgeInsetsDirectional.all(AppSize.size10),
            decoration: BoxDecoration(
                color:widget.isDetail==false? ColorsManager.backGroundColor:ColorsManager.whiteColor,
                borderRadius: BorderRadiusDirectional.circular(AppSize.size25)),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(AppSize.size10),
              child: Column(
                children: [
                  Text(
                    "${widget.companyModel.companyDescribe}\n",
                    style: FontsManager.getTextStyleBold(
                        color:handleText(widget.companyModel.companyDescribe)),
                  ),
                  ListTile(
                    title: Text(
                      widget.companyModel.companyName,
                      style: FontsManager.getTextStyleBold(
                          color: ColorsManager.greenColor),
                    ),
                    leading:InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=> DetailsCompany(companyModel: widget.companyModel)));
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.companyModel.companyImg,),
                      ),
                    ) ,
                    trailing: textBackground("${widget.companyModel.companyTotalPrice.toString()} EGP"),
                  ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "\n ${widget.companyModel.companyLocationFrom} ",
                          style: FontsManager.getTextStyleLight(),
                        ),
                      ),
                      Text(
                        "\n ${widget.companyModel.companyLocationTo} ",
                        style: FontsManager.getTextStyleLight(),
                      ),
                    ],
                  ),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(

                children: [

                  Text(
                      "${widget.companyModel.companyStartTime.hour}: ${widget.companyModel.companyStartTime.minute}"),
                  PopupMenuButton(
                      shape:const StadiumBorder(
                          side: BorderSide(
                              color: ColorsManager.darkBlueColor,
                              width: AppSize.sizeD1,
                              style: BorderStyle.solid
                          )
                      ),
                      elevation: 10,
                      child: const Icon(
                        IconsManager.downIcon,
                        color: ColorsManager.darkBlueColor,
                        size: AppSize.size30,
                      ),

                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<DateTime>>[
                          for (int i = 0; i < startDates.length; i++)
                            PopupMenuItem(
                              value: startDates[i],
                              child: Text(
                                  "${startDates[i].hour}:${startDates[i].minute}"),
                            ),
                        ];
                      },
                      onSelected: (value) {
                        widget.companyModel.companyStartTime =
                            DateTime.parse(value.toString());

                        widget.companyModel.companyEndTime =
                            widget.companyModel.companyStartTime.add(
                                Duration(hours: hourT, minutes: minuteT)); //end

                        setState(() {});
                      }

                  ),

                ],
              ),
              textBackground("$hourT:$minuteT"),
              Text(
                  "${widget.companyModel.companyEndTime.hour} :${widget.companyModel.companyEndTime.minute}  "),
            ]),
                   Padding(
                    padding: const EdgeInsets.only(
                      top: AppSize.size10,
                      bottom: AppSize.size10,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${widget.companyModel.numOfTravellers} selected "),
                              PopupMenuButton(
                                  shape:const StadiumBorder(
                                      side: BorderSide(
                                          color: ColorsManager.darkBlueColor,
                                          width: AppSize.sizeD1,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  elevation: 10,
                                  child: const Icon(
                                    IconsManager.downIcon,
                                    color: ColorsManager.darkBlueColor,
                                    size: AppSize.size30,
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<int>>[
                                      for (int i =1; i <= availableSeat; i++)
                                        PopupMenuItem(
                                          value: i,
                                          child:Text("$i        seat",textAlign: TextAlign.center) ,
                                          onTap:(){
                                            companyController.calcSeat(widget.companyModel, i);
                                          } ,
                                        )
                                    ];
                                  }
                              )
                            ],
                          ),
                          textBackground("${widget.companyModel.numOfTravellers}"
                              " of ${14 - widget.companyModel.companyNumberOfTravelers }  "),
                          Text("${widget.companyModel.companyNumberOfTravelers
                              + widget.companyModel.numOfTravellers} booked "),
                        ]),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        companyDetailSection( IconsManager.personIcon,"${widget.companyModel.numOfTravellers}"),
                      companyDetailSection(IconsManager.roadIcon,StringsManager.oneWay)
                    ],
                  ),
                  widget.isDetail==false? sharedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailsTripScreen(
                                  companyModel: widget.companyModel,
                                )));
                      },
                      title: StringsManager.details):const SizedBox(),
                ],
              ),
            ),
          );
    });
  }
}
