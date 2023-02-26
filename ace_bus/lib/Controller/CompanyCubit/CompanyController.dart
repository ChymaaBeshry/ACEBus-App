import 'dart:convert';
import 'package:ace_bus/Controller/CompanyCubit/CompanyStates.dart';
import 'package:ace_bus/Model/companyModel.dart';
import 'package:ace_bus/Model/ticketModel.dart';
import 'package:ace_bus/Model/userModel.dart';
import 'package:ace_bus/View/Screens/Company/Search/cheapest.dart';
import 'package:ace_bus/View/Screens/Company/Search/fastest.dart';
import 'package:ace_bus/View/Screens/Company/Search/recommended.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
String domain="https://acebus-edf0c-default-rtdb.firebaseio.com";
class CompanyController extends Cubit<CompanyStates>{
  CompanyController():super(InitialCompanyState()){
    getCompanies();
    //getUserTicket();
   //getRecommended();
   //getCheapestCompany();
   //getFastestCompany();

  }
int currentIndex=0;
  List<Widget> tabBarScreens =const [
     RecommendedScreen(),
    CheapestScreen(),
    FastestScreen(),
  ];
move(index){
  currentIndex=index;
  emit(ChangeTabBarState(currentIndex: index, screen: tabBarScreens[index]));
}

  List<CompanyModel> companies=[];
  List<CompanyModel> recommended=[];
  List<CompanyModel> cheapest=[];
  List<CompanyModel> fastest=[];
  List<TicketModel> userTickets=[];
  List<num> prices=[];
  num avg=0;
 // num totalPrice=0;
  //num totalBooked=0;

  Future<void>getCompanies()async{
  emit(LoadingCompanyState());
  try{
      http.Response res=await http.get(Uri.parse("$domain/companies.json"));
      if(res.statusCode==200) {
        Map data = json.decode(res.body);
        data.forEach((key, value) {
              companies.add( CompanyModel.fromJson(key, value));

          });
          print(companies);
        emit(SuccessCompanyState());
      }else{
      emit(ErrorCompanyState());
    }
  }catch(e){
    emit(ErrorCompanyState());
    print(e);
  }
  }
  getRecommended() {
  recommended.clear();
    for (int i=0; i<companies.length ;i++) {
    if(companies[i].companyRecommended==true){
      companies[i].companyDescribe="Recommended";
      recommended.add(companies[i]);
    }
  }
 //emit(GetRecommendedCompanyState());
  print(recommended);
}
  getCheapestCompany(){
  companies.sort(
          (a, b) {
        a.companyDescribe = "Cheapest";
        b.companyDescribe = "Cheapest";
        return a.companyTripPrice.compareTo(b.companyTripPrice);
      },
    );
    cheapest = companies;
    print(cheapest);

  }
  getFastestCompany(){
    companies.sort(
          (a, b) {
        a.companyDescribe = "Fastest";
        b.companyDescribe = "Fastest";
        return a.companyTripTime.compareTo(b.companyTripTime);
      },
    );
    fastest = companies;
    print(fastest);

  }

getTripTotalPrice(num dis,String locationFrom, String locationTo) {
  prices.clear();
  for (CompanyModel company in companies) {
    if(locationFrom.length>10){
      company.companyLocationFrom=locationFrom.substring(0,10);
    }else{
      company.companyLocationFrom=locationFrom;
    }

    company.companyLocationTo=locationTo;

    company.companyTripPrice =company.companyPriceK * ((dis / 1000).toInt());
    company.companyTotalPrice =company.companyTripPrice;
    prices.add(company.companyTripPrice);

    String total = ((dis * company.companyPriceT) / 60).toString();

    int hourT = int.parse(total.substring(0, 2)); //tot
    int minuteT = int.parse(total.substring(2, 4));

    if(minuteT>61){
      company.companyTripTime = "${hourT+1}${minuteT-60}";
    }else{
      company.companyTripTime = "$hourT$minuteT";

    }

  }
}

Future<void>getUserTicket()async{
  userTickets.clear();
  emit(GetLoadingTicketState());
  try{
    http.Response res=await http.get(Uri.parse("$domain/userTicket.json"));
    print(res.body);
    if(res.statusCode==200){
      Map data=json.decode(res.body);
      data.forEach((key, value) {
        userTickets.add(TicketModel.fromJson(key, value));
        print(userTickets.length);
      });
      emit(GetSuccessTicketState());
    }else {
      emit(GetErrorTicketState());
    }
  }catch(error){
    print(error);
    emit(GetErrorTicketState());

  }

}

Future<void>addUserTicket(UserModel user, CompanyModel company)async {
    emit(AddLoadingTicketState());
  try{
    Map data={
      "uid":user.uid,
      "userName":user.userName,
      "userPhone":user.userPhone,
      "tripPrice":company.companyTripPrice,
      "companyName":company.companyName,
      "companyLocationFrom":company.companyLocationFrom,
      "companyLocationTo":company.companyLocationTo,
      "companyStartTimeTrip":company.companyStartTime.toString(),
      "companyEndTimeTrip":company.companyEndTime.toString(),
      "numOfTravellers":company.numOfTravellers
    };
    http.Response res = await http.post(Uri.parse("$domain/userTicket.json"),
        body: json.encode(data));
    if (res.statusCode == 200) {
      emit(AddSuccessTicketState());
    }else{
      emit(AddErrorTicketState());
    }
  }catch(error){
    print(error);
    emit(AddErrorTicketState());

  }
}

Future<void>deleteOneTicket(TicketModel ticket )async{
try{
  http.Response res=await http.delete(Uri.parse("$domain/userTicket/${ticket.ticketId}.json"));
  print(res.statusCode);
  if(res.statusCode==200){
    for(int i=0; i<userTickets.length; i++){
      if(userTickets[i].ticketId== ticket.ticketId){
        userTickets.removeAt(i);
        break;
      }
    }
    emit(DeleteSuccessTicketState());
  }else{
    emit(DeleteErrorTicketState());
  }
}catch(error){
  print(error);
  emit(DeleteErrorTicketState());
}
}

Future<void>deleteAllTickets()async{
    try{
      http.Response res=await http.delete(Uri.parse("$domain/userTicket.json"));
      if(res.statusCode==200){
        userTickets.clear();
        emit(DeleteSuccessTicketState());
      }else{
        emit(DeleteErrorTicketState());
      }
    }catch(error){
      print(error);
      emit(DeleteErrorTicketState());
    }
  }

  void calcAvg(){
    prices.clear();
    print(prices);
  num totalPrice=0;
  for (var element in companies) {
      totalPrice =totalPrice+element.companyTripPrice;
      print(totalPrice);
      prices.add(element.companyTripPrice);
    }
  prices.sort();
    print(prices);

    avg=totalPrice/prices.length;
  }
  /*void calcAverage(){
    print(prices);
    prices.sort();
    print(prices);

    avg=totalPrice/prices.length;
  }*/


  calcSeat(CompanyModel company, int selected){
    int sum = company.companyNumberOfTravelers +selected;
    if(sum <15){
      company.numOfTravellers=selected;
      company.totalBooked= company.companyNumberOfTravelers+company.numOfTravellers;
      company.companyTotalPrice=company.companyTripPrice*company.numOfTravellers;
      emit(ChangeSeatState());
    }

  }

}
/* print(company.companyTripPrice);
    company.companyTripPrice= company.companyPriceK*((totalDistance/1000).toInt());
    print(company.companyTripPrice);
    print(company.companyTripTime);
    company.companyTripTime=(company.companyPriceT*((totalDistance/1000).toInt())).toDouble().toString();
    print(company.companyTripTime);
    print(company.companyStartTime);//string
    print(company.companyEndTime);//string
    double startDate=double.parse(company.companyStartTime);
    double totalT=double.parse(company.companyTripTime);
    company.companyEndTime=(startDate+totalT).toString();
    print(company.companyEndTime);
*/


