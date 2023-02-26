import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/MapCubit/mapStates.dart';
import 'package:ace_bus/View/Screens/Company/Search/search.dart';
import 'package:ace_bus/View/SharedWidget/InputFeildWidget.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/fontsManager.dart';
import 'package:ace_bus/View/Utilities/iconsManager.dart';
import 'package:ace_bus/View/Utilities/imagesManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:ace_bus/Controller/MapCubit/mapController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../SharedWidget/avgWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController currentLocationController =
      TextEditingController();
  final TextEditingController searchLocationController =
      TextEditingController();
  final GlobalKey currentLocationKey = GlobalKey<ScaffoldState>();
  final GlobalKey whereToLocationKey = GlobalKey<ScaffoldState>();
  final GlobalKey dateKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String date = DateTime.now().toString().substring(0, 10);
  String title = StringsManager.whereTo;
  bool absorb = false;
  @override
  Widget build(BuildContext context) {
    MapController mapController = BlocProvider.of<MapController>(context);
    CompanyController companyController =BlocProvider.of<CompanyController>(context);
    return BlocBuilder<MapController, MapStates>(builder: (context, state) {
      if (state is LoadingMapState) {
        return centerLoading();
      } else if (state is ErrorMapState) {
        return centerLoading();
      } else if (state is ErrorStatusMapState) {
        return AlertDialog(
          backgroundColor: ColorsManager.darkBlueColor,
          elevation: AppSize.size100,
          title: text(StringsManager.permission),
          titleTextStyle: FontsManager.getTextStyleBold(),
        );
      } else {
        return Scaffold(
          body: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: AppSize.size5,
                      vertical: AppSize.size20),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(ImagesManager.logo),
                      radius: AppSize.size40,
                    ),
                    title: Text(
                      StringsManager.nameApp,
                      style: FontsManager.getTextStyleBold(
                          color: ColorsManager.darkBlueColor,
                          size: AppSize.size25),
                    ),
                    subtitle: const Text(StringsManager.findCheapBusTickets),
                  ),
                ),
              ),
              Flexible(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      decoration(
                        smallHeight: AppSize.size380+AppSize.size10,
                          width: double.infinity,
                          widget: Column(
                            children: [
                              ListTile(
                                leading: Text(
                                  StringsManager.oneWay,
                                  style: FontsManager.getTextStyleRegular(
                                      color: ColorsManager.darkBlueColor),
                                ),
                                title: Text(
                                  StringsManager.roundTrip,
                                  style: FontsManager.getTextStyleLight(
                                      size: AppSize.size15),
                                ),
                                trailing: const Icon(
                                  IconsManager.personIcon,
                                  color: ColorsManager.lightBlueColor,
                                ),
                              ),
                              divider(ColorsManager.lightBlueColor),
                              InputField(
                                model: InputModel(
                                    controller: currentLocationController,
                                    key: currentLocationKey,
                                    title:mapController.currentTitle,
                                    prefix: IconsManager.myLocationIcon,
                                     hint:mapController.currentTitle,
                                    keyboardType: TextInputType.text,
                                    width: AppSize.size250,
                                    suffix: IconsManager.roadIcon,
                                    validator: (currentLocationController) {
                                    },
                                    onSubmitted: () {
                                        mapController.getSearchLocation(currentLocationController.text);
                                        print(mapController.currentLocation);
                                          mapController.currentTitle=currentLocationController.text;
                                          mapController.currentLocation =mapController.searchLocation;
                                          print(mapController.currentLocation);


                                    }),
                              ),
                              InputField(
                                model: InputModel(
                                    controller: searchLocationController,
                                    key: whereToLocationKey,
                                    title: title,
                                    hint:title ,
                                    prefix: IconsManager.locationIcon,
                                    keyboardType: TextInputType.text,
                                    width: AppSize.size250,
                                    validator: (searchLocationController) {
                                      if(searchLocationController.isEmpty){
                                      return StringsManager.pleaseEnterThisField;
                                    }
                                    },
                                    onSubmitted: () async {
                                      await mapController.getSearchLocation(searchLocationController.text);
                                      num dis= mapController.getDistance();
                                      companyController.getTripTotalPrice(
                                        dis,
                                        mapController.currentTitle,
                                        searchLocationController.text,
                                      );
                                        title = searchLocationController.text;
                                        absorb = true;

                                    }),
                              ),
                              decoration(
                                width: AppSize.size250,
                                smallHeight: AppSize.size50,
                                widget: ListTile(
                                  key: dateKey,
                                  leading: const Icon(
                                    IconsManager.calenderIcon,
                                    color: ColorsManager.lightBlueColor,
                                  ),
                                  title: const Text("\n${StringsManager.date}"),
                                  subtitle: Text("$date\n\n"),
                                  onTap: () async {
                                    DateTime? currentDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2024),
                                    );
                                    setState(() {
                                      date = currentDate.toString().substring(0, 10);
                                    });
                                  },
                                ),
                              ),
                              sharedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SearchScreen(
                                                distance: mapController.totalDistance,
                                                locationFrom:mapController.currentTitle,
                                                locationTo:searchLocationController.text,
                                                date: date,
                                              )));
                                    } else {
                                      snack(StringsManager.pleaseEnterYourInformation);
                                    }
                                  },
                                  title: StringsManager.search),
                            ],
                          ),
                          ),
                      absorb==true?AvgWidget(
                        locationFrom:mapController.currentTitle ,
                        locationTo:searchLocationController.text ,
                      ):const SizedBox(),


                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
