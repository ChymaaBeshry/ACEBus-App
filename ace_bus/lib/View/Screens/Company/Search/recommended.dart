import 'package:ace_bus/Controller/CompanyCubit/CompanyController.dart';
import 'package:ace_bus/View/SharedWidget/companyDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RecommendedScreen extends StatefulWidget {
   const RecommendedScreen({Key? key}) : super(key: key);

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {

  @override
  Widget build(BuildContext context) {
    CompanyController companyController=BlocProvider.of<CompanyController>(context);
    companyController.getRecommended();
            return Scaffold(
                body: ListView.builder(
                  itemBuilder: (context, index) =>
                      CompanyDetailsWidget(
                        companyModel: companyController.recommended[index],
                        isDetail: false,),
                  itemCount: companyController.recommended.length,)

      );
  }
}

