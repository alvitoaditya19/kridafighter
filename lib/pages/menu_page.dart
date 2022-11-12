part of 'pages.dart';

class MenuPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final String? title;
  final url;

  const MenuPage({super.key, this.bottomNavBarIndex = 0, this.title, this.url});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final fb = FirebaseDatabase.instance;
  TextEditingController _textFieldControllerTanggal = TextEditingController();
  TextEditingController _textFieldControllerWaktu = TextEditingController();

  bool select = false;
  bool select1 = false;
  bool select2 = false;
  bool select3 = false;
  bool select4 = false;
  bool select5 = false;
  String name = "1";
  String name1 = "0";
  double _volumeValue = 50;

  var jam = '';

  @override
  void initState() {
    super.initState();
  }

  void onVolumeChanged(double value) {
    setState(() {
      _volumeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
   final DatabaseReference posts = FirebaseDatabase.instance.ref().child("keruhAir");
    Widget header() {
      return Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload!).then((downloadURL) {
                    imageFileToUpload = null;
                    context
                        .read<UserBloc>()
                        .add(UpdateData(profileImage: downloadURL));
                  });
                }

                return Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Howdy,\n${userState.user.name!}',
                              style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 24),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Be Smart for your Smart Garden',
                              style: greyTextStyle.copyWith(
                                  fontSize: 16, fontWeight: light),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToEditProfilePage(
                              (userState as UserLoaded).user));
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: kWhiteColor,
                              width: 4,
                            ),
                            image: DecorationImage(
                                // image: DecorationImage( image: true ? NetworkImage('someNetWorkLocation.com') : AssetImage('assets/images/noImageAvailable.png') as ImageProvider ),
                                image: (userState.user.profilePicture == ""
                                    ? AssetImage("assets/img-profile.png")
                                        as ImageProvider
                                    : NetworkImage(
                                        userState.user.profilePicture ??
                                            "No Data")),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SpinKitFadingCircle(
                  color: kGreenColor,
                  size: 50,
                );
              }
            }),
          ),
        ]),
      );
    }

    Widget monitorFeature(snapshotData) {
      return Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 14, defaultMargin, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [MonitoringCard(onValueChanged: onVolumeChanged,dataSensor:snapshotData, nameSensor: "Kekeruhan Air",nameParameter: "NTUs",),],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<DatabaseEvent>(
            builder: (BuildContext context,AsyncSnapshot<DatabaseEvent>  snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(),
                    monitorFeature(snapshot.data!.snapshot.value!),
                      SizedBox(
                      height: 80,
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: kGreenColor,
                  size: 50,
                );
              }
            },
            stream: posts.onValue,
          ),
        ),
      ),
    );
  }

  Future<void> readData() async {
    fb.reference().child("Node1").child("ldr").once().then((snapshot) {
      print(snapshot);
    });
  }
}
