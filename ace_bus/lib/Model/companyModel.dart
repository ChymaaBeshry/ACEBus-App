class CompanyModel{
  String companyId;
  String companyName;
  num companyPriceK;
  num companyPriceT;
  String companyImg;
  String companyAvailableTime;
  String companyHotline;
  String companyEmail;
  String companyWebsite;
  int companyNumberOfTravelers;
  bool companyRecommended;
  String companyDescribe;
  String companyLocationFrom;
  String companyLocationTo;
  DateTime companyStartTime;
  DateTime companyEndTime;
  String companyTripTime;
  num companyTripPrice;
  num companyTotalPrice;
  num    numOfTravellers;
  num    totalBooked;


  CompanyModel({
    required this.companyId,
    required this.companyName,
    required this.companyDescribe,
    required this.companyNumberOfTravelers,
    required this.companyRecommended,
    required this.companyPriceK,
    required this.companyPriceT,
    required this.companyLocationFrom,
    required this.companyLocationTo,
    required this.companyTripPrice,
    required this.companyStartTime,
    required this.companyEndTime,
    required this.companyTripTime,
    required this.companyAvailableTime,
    required this.companyEmail,
    required this.companyHotline,
    required this.companyImg,
    required this.companyWebsite,
    required this.companyTotalPrice,
    required this.numOfTravellers,
    required this.totalBooked,



  });
factory CompanyModel.fromJson( String key,Map data){
  return CompanyModel(
      companyId: key,
      companyName:data["companyName"],
      companyAvailableTime:data["companyAvailableTime"] ,
      companyEmail:data["companyEmail"] ,
      companyHotline:data["companyHotline"] ,
      companyImg:data["companyImg"] ,
      companyWebsite:data["companyWebsite"] ,
      companyDescribe:"",
      companyNumberOfTravelers:data["companyNumberOfTravelers"],
      companyRecommended:data["companyRecommended"],
      companyPriceK:data["companyPriceK"],
      companyPriceT:data["companyPriceT"],
      companyLocationFrom:"",
      companyLocationTo: "",
      companyTripPrice: 0,
      companyStartTime:DateTime.parse(data["companyStartTime"]) ,
      companyEndTime: DateTime.now(),
      companyTripTime:"",
      companyTotalPrice:0,
      numOfTravellers: 1,
      totalBooked: 0


  );
}
@override
String toString() {
    // TODO: implement toString
    return """(
    companyId: $companyId,
    companyName: $companyName,
    companyDescribe: $companyDescribe,
    companyNumberOfTravelers: $companyNumberOfTravelers,
    companyRecommended: $companyRecommended,
    companyPriceK: $companyPriceK,
    companyPriceT: $companyPriceT,
    companyLocationFrom: $companyLocationFrom,
    companyLocationTo: $companyLocationTo,
    companyTripPrice: $companyTripPrice,
    companyStartTime: $companyStartTime,
    companyEndTime: $companyTripTime,
    companyTripTime: $companyTripTime,
    companyLocationFrom: $companyLocationFrom,
    )""";

  }
}