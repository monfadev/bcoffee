part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isHidePassword = false;
  bool isHideRetypePassword = false;

  @override
  Widget build(BuildContext context) {
    print('Page: SignUpPage');

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToLoginPage());
        return;
      },
      child: GeneralPage(
          title: 'Sign Up',
          subtitle: 'Register and get priority',
          onBackButtonPressed: () {
            context.read<PageBloc>().add(GoToLoginPage());
          },
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                margin: EdgeInsets.only(top: 26),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/photo_border.png'))),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.registrationData.profileImage == null) {
                      widget.registrationData.profileImage = await getImage();
                    } else {
                      widget.registrationData.profileImage = null;
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (widget.registrationData.profileImage == null)
                              ? AssetImage("assets/photo.png")
                              : FileImage(widget.registrationData.profileImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              CustomTextField(
                labelText: 'Full Name',
                hintText: 'Type your full name',
                hintStyle: greyFontStyle,
                marginTop: 26,
                controller: nameController,
              ),
              CustomTextField(
                labelText: 'Email Address',
                hintText: 'Type your email address',
                hintStyle: greyFontStyle,
                marginTop: 16,
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
                              color: "C6C6C6".toColor(),
                            )
                          : Icon(
                              Icons.visibility,
                              size: 20,
                              color: "C6C6C6".toColor(),
                            ),
                    )),
                onChanged: (text) {
                  setState(() {
                    isPasswordValid = text.length >= 6;
                  });
                },
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                hintText: 'Type your confirm password',
                hintStyle: greyFontStyle,
                marginTop: 16,
                controller: retypePasswordController,
                obscureText: !isHideRetypePassword,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHideRetypePassword = !isHideRetypePassword;
                      });
                    },
                    child: Theme(
                      data: Theme.of(context).copyWith(primaryColor: null),
                      child: (!isHideRetypePassword)
                          ? Icon(
                              Icons.visibility_off,
                              size: 20,
                              color: "C6C6C6".toColor(),
                            )
                          : Icon(
                              Icons.visibility,
                              size: 20,
                              color: "C6C6C6".toColor(),
                            ),
                    )),
                onChanged: (text) {
                  setState(() {
                    isPasswordValid = text.length >= 6;
                  });
                },
              ),
              CustomButton(
                child: CustomElevatedButton(
                    title: 'Continue',
                    colorButton: mainColor,
                    onPressed: () {
                      if (!(nameController.text.trim() != "" &&
                          emailController.text.trim() != "" &&
                          passwordController.text.trim() != "" &&
                          retypePasswordController.text.trim() != "")) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: redColor,
                          message: "Please fill all the fields",
                        )..show(context);
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: redColor,
                          message: "Wrong formatted email address",
                        )..show(context);
                      } else if (passwordController.text !=
                          retypePasswordController.text) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: redColor,
                          message: "Mismatch password and confirmed password",
                        )..show(context);
                      } else if (passwordController.text.length < 6) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: redColor,
                          message: "Password's length min 6 characters",
                        )..show(context);
                      } else {
                        widget.registrationData.name = nameController.text;
                        widget.registrationData.email = emailController.text;
                        widget.registrationData.password =
                            passwordController.text;

                        context.read<PageBloc>().add(
                            GoToAccountConfirmationPage(
                                widget.registrationData));
                      }
                    }),
              ),
              SizedBox(height: 5),
            ],
          )),
    );
  }
}
