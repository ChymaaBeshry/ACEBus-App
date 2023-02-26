

import 'package:ace_bus/Controller/MapCubit/mapStates.dart';
import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
class MapController extends Cubit<MapStates> {
  MapController() :super(InitialMapState()){
   getCurrentLocation();
  }

  LatLng currentLocation = LatLng(31.233334, 30.033333);
  LatLng searchLocation = LatLng(31.233334, 30.033333);
  List<Placemark> placeMark = [];
  String currentTitle="";
  Set<Polyline> polyLines ={};
  Map<MarkerId, Marker> markers = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  num totalDistance =0;
  String googleAPiKey = "AIzaSyDJDN-hwYebCPi1AjqdSdtLY3KvtCP8OKM";
  num time=0;
  Polyline? polyline;
List<Placemark> placeMarkBetweenLocations=[];

  Future<void> getPlaceMark()async{
    for(LatLng latLng in polylineCoordinates){
      List<Placemark> place= await placemarkFromCoordinates(latLng.latitude,latLng.longitude);
      placeMarkBetweenLocations.addAll(place);
    }
    emit(GetPlaceMarkMapState());
    print(placeMarkBetweenLocations);
    print(placeMarkBetweenLocations.length);
  }

  Future<void> getCurrentLocation() async {
    emit(LoadingMapState());
    try {
      bool service = await _getStatusPermission();
      if (service == true) {
        Position location = await Geolocator.getCurrentPosition();
        currentLocation = LatLng(location.latitude, location.longitude);
        _addMarker(currentLocation, "origin",BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
        placeMark = await placemarkFromCoordinates(location.latitude, location.longitude);
        currentTitle="${placeMark[0].street} , ${placeMark[0].administrativeArea}";
        print("$currentTitle***************************************************************");
        print("$currentLocation*******************current********************************************");
        emit(SuccessCurrentLocationMapState());
      } else {

        emit(ErrorStatusMapState());
      }
    } catch (e) {
      emit(ErrorMapState());
      print(e);
    }
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position,);
    markers[markerId] = marker;
  }

  Future<void> getSearchLocation(String address) async {
    try {
      bool service = await _getStatusPermission();
      if (service == true) {
        List<Location> locations = await locationFromAddress(address);
        searchLocation = LatLng(locations[0].latitude, locations[0].longitude);
        _addMarker(searchLocation, "destination",BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
        print("$searchLocation***********************search****************************************");
        emit(SuccessSearchMapState());
      } else {
        emit(ErrorStatusMapState());
      }
    } catch (e) {
      emit(ErrorMapState());

      print(e);
    }
  }

  getDistance() {
    print("${currentLocation.latitude}, ${currentLocation.longitude},${searchLocation.latitude}, ${searchLocation.longitude}");
     time=Geolocator.bearingBetween(
        currentLocation.latitude, currentLocation.longitude,
        searchLocation.latitude, searchLocation.longitude);
     print(time);
     totalDistance = Geolocator.distanceBetween(
        currentLocation.latitude, currentLocation.longitude,
        searchLocation.latitude, searchLocation.longitude);
     print("$totalDistance/*/*/*/*/*/*///////////////////////*/*/*/**//**/*/*/*/*/");
     return totalDistance;
  }

  Future<bool> _getStatusPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        return true;
      } else {
        return false;
      }
    }
     bool locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService == false) {
      return false;
    } else {
      return true;
    }
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
     polyline = Polyline(polylineId: id, color: ColorsManager.darkBlueColor, points: polylineCoordinates);
    polyLines.add(polyline!);
    print(polyLines);
   // emit(AddPolyLineMapState());
  }

  getPolyline() async {
    polyLines.clear();
    emit(LoadingPolyLineState());
    try{
     await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(currentLocation.latitude, currentLocation.longitude),
          PointLatLng(searchLocation.latitude, searchLocation.longitude),
          travelMode: TravelMode.driving,
     );
    //  if (result.points.isNotEmpty) {
    //    result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(currentLocation.latitude, currentLocation.longitude));
          polylineCoordinates.add(LatLng(searchLocation.latitude, searchLocation.longitude));

      //  });
      //}

      _addPolyLine();
      emit(GetPolyLineMapState());


    }catch(e){
      emit(ErrorPolyLineMapState());
      print(e);
    }

  }

}

