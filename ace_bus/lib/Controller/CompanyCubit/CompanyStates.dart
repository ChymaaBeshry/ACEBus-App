import 'package:flutter/material.dart';

abstract class CompanyStates{}
class InitialCompanyState extends CompanyStates{}

class LoadingCompanyState extends CompanyStates{}
class SuccessCompanyState extends CompanyStates{}
class ErrorCompanyState extends CompanyStates{}

class SuccessCalculateState extends CompanyStates{}

class GetRecommendedCompanyState extends CompanyStates{}
class GetCheapestCompanyState extends CompanyStates{}
class GetFastestCompanyState extends CompanyStates{}

class GetLoadingTicketState extends CompanyStates{}
class GetSuccessTicketState extends CompanyStates{}
class GetErrorTicketState extends CompanyStates{}

class AddLoadingTicketState extends CompanyStates{}
class AddSuccessTicketState extends CompanyStates{}
class AddErrorTicketState extends CompanyStates{}

class DeleteSuccessTicketState extends CompanyStates{}
class DeleteErrorTicketState extends CompanyStates{}

class ChangeSeatState extends CompanyStates{}

class ChangeTabBarState extends CompanyStates{
  int currentIndex;
  Widget screen;
  ChangeTabBarState({
    required this.currentIndex,
    required this.screen
});
}
