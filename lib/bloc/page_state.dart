part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  final int initialPage;

  OnMainPage({this.initialPage = 0});
  @override
  List<Object> get props => [initialPage];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  //Untuk OnAccountConfirmationPage needs RegistrationData
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnCoffeeDetailPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnProfilePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditProfilePage extends PageState {
  final UserModel user;

  OnEditProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

class OnOrderHistoryPage extends PageState {
  @override
  List<Object> get props => [];
}
