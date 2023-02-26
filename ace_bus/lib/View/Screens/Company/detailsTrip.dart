import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/Controller/MapCubit/mapController.dart';
import 'package:ace_bus/Controller/MapCubit/mapStates.dart';
import 'package:ace_bus/Controller/UserCubit/userController.dart';
import 'package:ace_bus/Model/companyModel.dart';
import 'package:ace_bus/View/Screens/BottomNavBarScreen/tripsScreen.dart';
import 'package:ace_bus/View/SharedWidget/companyDetailsWidget.dart';
import 'package:ace_bus/View/Utilities/StringManager.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:ace_bus/View/Utilities/valuesManager.dart';
import 'package:ace_bus/View/sharedCombonent/combonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsTripScreen extends StatefulWidget {
  DetailsTripScreen({Key? key,
    required this.companyModel,
  }) : super(key: key);
  CompanyModel companyModel;

  @override
  State<DetailsTripScreen> createState() => _DetailsTripScreenState();
}

class _DetailsTripScreenState extends State<DetailsTripScreen> {
  GoogleMapController? gmc;
@override
  void initState() {
  BlocProvider.of<MapController>(context).getPlaceMark();
  BlocProvider.of<MapController>(context).getPolyline();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MapController mapController = BlocProvider.of<MapController>(context);
    return BlocBuilder<MapController, MapStates>(builder: (context, state) {
      if (state is LoadingMapState) {
        return centerLoading();
      } else if (state is ErrorMapState) {
        return centerErrorText();
      } else {
        return Scaffold(
          backgroundColor: ColorsManager.whiteColor,
          body: Column(
            children: [
              SafeArea(
                child: SizedBox(
                    height: AppSize.size250,
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: mapController.currentLocation, zoom: 8),
                      myLocationEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        gmc = controller;
                      },
                      markers: Set<Marker>.of(mapController.markers.values),
                      polylines:mapController.polyLines,
                    )),
              ),
              Flexible(
                child: ListView(
                  children: [
                    CompanyDetailsWidget(
                      companyModel: widget.companyModel,
                      isDetail: true,
                    ),


                  ],
                ),
              ),
              sharedButton(
                  onPressed: () {
                    BlocProvider.of<CompanyController>(context).addUserTicket(BlocProvider.of<UserController>(context).users[0], widget.companyModel);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const TripsScreen()));
                  },
                  title: StringsManager.Continue),
            ],

          ),
        );
      }
    });
  }
}

/* ListTile(
                 leading: Container(
                   height: AppSize.size50,
                   width:  AppSize.size50,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image: AssetImage(ImagesManager.logo),
                           fit: BoxFit.fill
                       )
                   ),
                 ),
                 title:Row(
                   children: [
                     Text("Cairo",style: FontsManager.getTextStyleLight(),),
                     Text(" , Alexandria",style: FontsManager.getTextStyleLight(),),
                   ],
                 ),
                 subtitle:Text("1:30",style: FontsManager.getTextStyleLight(),) ,
               ),
               ListTile(
                 leading: Container(
                   height: AppSize.size50,
                   width:  AppSize.size50,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image: AssetImage(ImagesManager.logo),
                           fit: BoxFit.fill
                       )
                   ),
                 ),
                 title:Row(
                   children: [
                     Text("Alexandria",style: FontsManager.getTextStyleLight(),),
                     Text(" , Kilo 30",style: FontsManager.getTextStyleLight(),),
                   ],
                 ),
                 subtitle:Text("3:30",style: FontsManager.getTextStyleLight(),) ,
               ),*/
