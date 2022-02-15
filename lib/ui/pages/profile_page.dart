part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
        if (userState is UserLoaded) {
          if (imageFileToUpload != null) {
            uploadImage(imageFileToUpload).then((downloadURL) {
              imageFileToUpload = null;
              context
                  .read<UserBloc>()
                  .add(UpdateData(profileImage: downloadURL));
            });
          }
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                width: double.infinity,
                height: 360,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      margin: EdgeInsets.only(
                        bottom: 16,
                      ),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/photo_border.png',
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: (userState.user.profilePicture != null &&
                                    userState.user.profilePicture != "")
                                ? NetworkImage(userState.user.profilePicture)
                                : AssetImage("assets/add_pic.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(userState.user.name, style: blackFontStyle2),
                    Text(userState.user.email, style: greyFontStyle),
                  ],
                ),
              ),
              SizedBox(height: defaultMargin),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    CustomTabBar(
                      title: ['Account', 'BibirKopi'],
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Column(
                      children: ((selectedIndex == 0)
                              ? ['Edit Profile', 'Logout']
                              : [
                                  'Rate App',
                                  'Help Center',
                                  'Privacy & Policy',
                                  'Term & Condition'
                                ])
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                if (element == 'Logout') {
                                  context.read<UserBloc>().add(SignOut());
                                  AuthServices.signOut();
                                  print('logout');
                                } else if (element == 'Edit Profile') {
                                  context.read<PageBloc>().add(
                                      GoToEditProfilePage((userState).user));
                                  print('gotoprofilepage');
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 16,
                                  left: defaultMargin,
                                  right: defaultMargin,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(element),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        'assets/right_arrow.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return LoadingIndicator();
        }
      }),
    );
  }
}
