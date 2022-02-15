part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .read<PageBloc>()
              .add(GoToRegistrationPage(widget.registrationData));
          return;
        },
        child: GeneralPage(
            title: 'Confirm New Account',
            subtitle: 'Cheers',
            onBackButtonPressed: () {
              context
                  .read<PageBloc>()
                  .add(GoToRegistrationPage(widget.registrationData));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                (widget.registrationData.profileImage == null)
                                    ? AssetImage("assets/add_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Welcome",
                    style: blackFontStyle3.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    widget.registrationData.name,
                    textAlign: TextAlign.center,
                    style: blackFontStyle3.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  (isSigningUp)
                      ? LoadingIndicator()
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: CustomElevatedButton(
                              title: 'Create My Account',
                              colorButton: mainColor,
                              onPressed: () async {
                                setState(() {
                                  isSigningUp = true;
                                });
                                imageFileToUpload =
                                    widget.registrationData.profileImage;

                                SignInSignUpResult result =
                                    await AuthServices.signUp(
                                  widget.registrationData.email,
                                  widget.registrationData.password,
                                  widget.registrationData.name,
                                );

                                if (result.user == null) {
                                  setState(() {
                                    isSigningUp = false;
                                  });

                                  Flushbar(
                                    duration: Duration(milliseconds: 1500),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: redColor,
                                    message: result.message,
                                  )..show(context);
                                }
                              }),
                        )
                ],
              ),
            )));
  }
}
