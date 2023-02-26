import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/View/SharedWidget/companyDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CheapestScreen extends StatefulWidget {
   const CheapestScreen({Key? key}) : super(key: key);

  @override
  State<CheapestScreen> createState() => _CheapestScreenState();
}

class _CheapestScreenState extends State<CheapestScreen> {

  @override
  Widget build(BuildContext context) {
    CompanyController companyController=BlocProvider.of<CompanyController>(context);
    companyController.getCheapestCompany();
        return Scaffold(
            body: ListView.builder(
              itemBuilder: (context, index) =>
                  CompanyDetailsWidget(
                    companyModel: companyController.cheapest[index],
                    isDetail: false,),
              itemCount: companyController.cheapest.length,)

    );
  }
}
