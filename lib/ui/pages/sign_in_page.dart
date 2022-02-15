part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;
  bool isHidePassword = false;

  @override
  Widget build(BuildContext context) {
    print('Page: SignInPage');
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: GeneralPage(
        title: 'Sign In',
        subtitle: 'Find your best ever coffee',
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Email Address',
              hintText: 'Type your email address',
              hintStyle: greyFontStyle,
              marginTop: 26,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              onChanged: (text) {
                setState(() {
                  isEmailValid = EmailValidator.validate(text);
                });
              },
            ),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Type your password',
              hintStyle: greyFontStyle,
              marginTop: 16,
              controller: passwordController,
              obscureText: !isHidePassword,
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isHidePassword = !isHidePassword;
                    });
                  },
                  child: Theme(
                    data: Theme.of(context).copyWith(primaryColor: null),
                    child: (!isHidePassword)
                        ? Icon(
                            Icons.visibility_off,
                            size: 20,
                            color: Color(0xFFC6C6C6),
                          )
                        : Icon(
                            Icons.visibility,
                            size: 20,
                            color: Color(0xFFC6C6C6),
                          ),
                  )),
              onChanged: (text) {
                setState(() {
                  isPasswordValid = text.length >= 6;
                });
              },
            ),
            CustomButton(
              child: isSignIn
                  ? LoadingIndicator()
                  : CustomElevatedButton(
                      title: 'Sign In',
                      colorButton: isEmailValid && isPasswordValid
                          ? mainColor
                          : Color(0xFFE4E4E4),
                      onPressed: isEmailValid && isPasswordValid
                          ? () async {
                              setState(() {
                                isSignIn = true;
                              });
                              SignInSignUpResult result =
                                  await AuthServices.signIn(
                                      emailController.text,
                                      passwordController.text);

                              if (result.user == null) {
                                setState(() {
                                  isSignIn = false;
                                });

                                Flushbar(
                                  duration: Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: redColor,
                                  message: result.message,
                                )..show(context);
                              }
                            }
                          : null),
            ),
            CustomButton(
              child: CustomElevatedButton(
                title: 'Create New Account',
                colorButton: greyColor,
                onPressed: () {
                  context
                      .read<PageBloc>()
                      .add(GoToRegistrationPage(RegistrationData()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
