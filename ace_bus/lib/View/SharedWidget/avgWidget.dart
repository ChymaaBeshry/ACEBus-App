import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';

import 'package:ace_bus/View/Screens/Company/Search/cheapest.dart';
import 'package:flutter/material.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AvgWidget extends StatefulWidget {
  AvgWidget({Key? key,required this.locationFrom,required this.locationTo }) : super(key: key);
  String locationFrom;
  String locationTo;
  @override
  State<AvgWidget> createState() => _AvgWidgetState();
}
class _AvgWidgetState extends State<AvgWidget> {
  @override
  Widget build(BuildContext context) {
    CompanyController companyController=BlocProvider.of<CompanyController>(context);
                   companyController.calcAvg();
                   return Padding(
                     padding: const EdgeInsets.symmetric(vertical: AppSize.size25),
                     child: Column(
                       children: [
                         Text(
                           StringsManager.cheapBusTickets,
                           style: FontsManager.getTextStyleSemiBold(
                               color: ColorsManager.darkBlueColor),
                         ),
                         Text(
                           "From ${widget.locationFrom} To ${widget.locationTo} ",
                           style: FontsManager.getTextStyleLight(
                               color: ColorsManager.lightBlueColor),
                         ),
                         decoration(
                           width: double.infinity,
                           smallHeight: AppSize.size130,
                           widget: Padding(
                             padding: const EdgeInsets.symmetric(
                                 vertical: AppSize.size20),
                             child: Row(
                               mainAxisAlignment:
                               MainAxisAlignment.spaceAround,
                               children: [
                                 const VerticalDivider(
                                   color: ColorsManager.darkBlueColor,
                                   thickness: AppSize.size5,
                                 ),
                                 Column(
                                   mainAxisAlignment:
                                   MainAxisAlignment.spaceBetween,
                                   children: [
                                     textBackground(StringsManager.cheapest),
                                     Text("${companyController.prices[0]}",
                                         style:
                                         FontsManager.getTextStyleBold()),
                                     Container(
                                       height: AppSize.size50,
                                       decoration: BoxDecoration(
                                           color:
                                           ColorsManager.backGroundColor,
                                           borderRadius:
                                           BorderRadiusDirectional
                                               .circular(AppSize.size10)),
                                       child: sharedTextButton(
                                           title: StringsManager.findTicket,
                                           color: ColorsManager.greyLightColor,
                                           onPressed: () {
                                             Navigator.push(
                                                 context,
                                                 MaterialPageRoute( builder: (context)=>
                                                     const CheapestScreen()
                                                 )
                                             );
                                           }),
                                     )
                                   ],
                                 ),
                                 Column(
                                   mainAxisAlignment:
                                   MainAxisAlignment.spaceBetween,
                                   children: [
                                     textBackground(StringsManager.average),
                                     Text("${companyController.avg}",
                                         style:
                                         FontsManager.getTextStyleBold()),
                                     Row(
                                       children: const [
                                         Icon(
                                           IconsManager.lightIcon,
                                           color: ColorsManager.darkBlueColor,
                                         ),
                                         Text(StringsManager.averageDescribe),
                                       ],
                                     )
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                   );
  }
}
/*        builder: (context, state){
          CompanyController companyController=BlocProvider.of<CompanyController>(context);
          if (state is LoadingCompanyState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessCompanyState) {
            companyController.calcAvg();
            return Column(
              children: [
                Text(
                  StringsManager.cheapBusTickets,
                  style: FontsManager.getTextStyleSemiBold(
                      color: ColorsManager.darkBlueColor),
                ),
                Text(
                  "From ${widget.locationFrom} To ${widget.locationTo} ",
                  style: FontsManager.getTextStyleLight(
                      color: ColorsManager.lightBlueColor),
                ),
                decoration(
                  width: double.infinity,
                  bigHeight: AppSize.size170,
                  smallHeight: AppSize.size130,
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSize.size20),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        const VerticalDivider(
                          color: ColorsManager.darkBlueColor,
                          thickness: AppSize.size5,
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            textBackground(StringsManager.cheapest),
                            Text("${companyController.prices[0]}",
                                style:
                                FontsManager.getTextStyleBold()),
                            Container(
                              height: AppSize.size50,
                              decoration: BoxDecoration(
                                  color:
                                  ColorsManager.backGroundColor,
                                  borderRadius:
                                  BorderRadiusDirectional
                                      .circular(AppSize.size10)),
                              child: sharedTextButton(
                                  title: StringsManager.findTicket,
                                  color: ColorsManager.greyLightColor,
                                  onPressed: () {}),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            textBackground(StringsManager.average),
                            Text("${companyController.avg}",
                                style:
                                FontsManager.getTextStyleBold()),
                            Row(
                              children: const [
                                Icon(
                                  IconsManager.lightIcon,
                                  color: ColorsManager.darkBlueColor,
                                ),
                                Text(StringsManager.averageDescribe),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }else{
            return const Center(
              child: SizedBox(),
            );

          }*/
