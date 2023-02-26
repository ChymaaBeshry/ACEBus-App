class TicketModel{
  String ticketId;
  String uid;
  String userName;
  String userPhone;
  num    tripPrice;
  num    numOfTravellers;
  String companyName;
  String companyLocationFrom;
  String companyLocationTo;
  DateTime companyStartTimeTrip;
  DateTime companyEndTimeTrip;
  TicketModel({
    required this.ticketId,
    required this.uid,
    required this.userName,
    required this.userPhone,
    required this.tripPrice,
    required this.companyName,
    required this.companyLocationFrom,
    required this.companyLocationTo,
    required this.companyStartTimeTrip,
    required this.companyEndTimeTrip,
    required this.numOfTravellers,
  });
 factory TicketModel.fromJson(key,Map data){
    return TicketModel(
      ticketId:key,
      uid: data["uid"],
      userName:data["userName"],
      userPhone:data["userPhone"] ,
      tripPrice:data["tripPrice"],
      companyName:data["companyName"],
      companyLocationFrom:data["companyLocationFrom"],
      companyLocationTo:data["companyLocationTo"],
      companyStartTimeTrip:DateTime.parse(data["companyStartTimeTrip"] ),
      companyEndTimeTrip:DateTime.parse(data["companyEndTimeTrip"]) ,
      numOfTravellers:data["numOfTravellers"]
    );
}


}