import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bcoffee/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage(initialPage: event.initialPage);
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToCoffeeDetailPage) {
      yield OnCoffeeDetailPage();
    } else if (event is GoToProfilePage) {
      yield OnProfilePage();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } else if (event is GoToOrderHistoryPage){
      yield OnOrderHistoryPage();
    }
  }
}