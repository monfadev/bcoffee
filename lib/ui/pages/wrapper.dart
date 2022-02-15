part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToLoginPage)) {
        prevPageEvent = GoToLoginPage();
        context.read<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.read<UserBloc>().add(LoadUser(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.read<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnLoginPage)
            ? SignInPage()
            : (pageState is OnRegistrationPage)
                ? SignUpPage(pageState.registrationData)
                : (pageState is OnAccountConfirmationPage)
                    ? AccountConfirmationPage(pageState.registrationData)
                    : (pageState is OnProfilePage)
                        ? ProfilePage()
                        : (pageState is OnEditProfilePage)
                            ? EditProfilePage(pageState.user)
                            : (pageState is OnOrderHistoryPage)
                                ? OrderHistoryPage()
                                : (pageState is OnMainPage)
                                    ? MainPage(
                                        initialPage: pageState.initialPage)
                                    : SizedBox());
  }
}
