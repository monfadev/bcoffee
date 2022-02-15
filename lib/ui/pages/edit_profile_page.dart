part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: GeneralPage(
        title: 'Edit Profile',
        subtitle: 'Change your profile the best',
        onBackButtonPressed: () {
          context.read<PageBloc>().add(GoToMainPage());
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                margin: EdgeInsets.only(top: 24, bottom: 24),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/photo_border.png'))),
                child: GestureDetector(
                  onTap: () async {
                    if (profilePath == "") {
                      profileImageFile = await getImage();

                      if (profileImageFile != null) {
                        profilePath = basename(profileImageFile.path);
                      }
                    } else {
                      profileImageFile = null;
                      profilePath = "";
                    }

                    setState(() {
                      isDataEdited =
                          (nameController.text.trim() != widget.user.name ||
                                  profilePath != widget.user.profilePicture)
                              ? true
                              : false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (profileImageFile != null)
                              ? FileImage(profileImageFile)
                              : (profilePath != "")
                                  ? NetworkImage(profilePath)
                                  : AssetImage("assets/photo.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              AbsorbPointer(
                child: CustomTextField(
                    labelText: 'Email Address',
                    hintText: 'Type your full name',
                    controller: TextEditingController(text: widget.user.email),
                    marginTop: 0),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                  child: Text(
                    'Full Name',
                    style: blackFontStyle2,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: nameController,
                    maxLines: 1,
                    style: blackFontStyle1.copyWith(fontSize: 15),
                    onChanged: (text) {
                      setState(() {
                        isDataEdited = (text.trim() != widget.user.name ||
                                profilePath != widget.user.profilePicture)
                            ? true
                            : false;
                      });
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              (isUpdating)
                  ? SizedBox(width: 50, height: 50, child: LoadingIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: CustomElevatedButton(
                        title: 'Update My Profile',
                        colorTitle:
                            (isDataEdited) ? Colors.white : Color(0xFFBEBEBE),
                        colorButton: (isDataEdited)
                            ? Color(0xFF3E9D9D)
                            : Color(0xFFE4E4E4),
                        onPressed: (isDataEdited)
                            ? () async {
                                setState(() {
                                  isUpdating = true;
                                });
                                if (profileImageFile != null) {
                                  profilePath =
                                      await uploadImage(profileImageFile);
                                }
                                Flushbar(
                                  duration: Duration(milliseconds: 2000),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFF3E9D9D),
                                  message: "Update My Profile",
                                )..show(context);

                                context.read<UserBloc>().add(
                                      UpdateData(
                                        name: nameController.text,
                                        profileImage: profilePath,
                                      ),
                                    );

                                context.read<PageBloc>().add(GoToMainPage());
                              }
                            : null,
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
