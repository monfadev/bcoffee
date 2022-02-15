part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final int initialPage;

  GoToMainPage({this.initialPage = 0});
  @override
  List<Object> get props => [initialPage];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToCoffeeDetailPage extends PageEvent {
  @override
  List<Object> get props => [];
}


class GoToProfilePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToEditProfilePage extends PageEvent {
  final UserModel user;

  GoToEditProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

class GoToOrderHistoryPage extends PageEvent {
  @override
  List<Object> get props => [];
}
