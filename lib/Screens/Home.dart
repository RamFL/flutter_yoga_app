// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_yoga_app/Screens/StartUp.dart';
import 'package:flutter_yoga_app/model/model.dart';
import 'package:flutter_yoga_app/services/s_f.dart';
// import 'package:flutter_yoga_app/services/s_f.dart';
// import 'package:flutter_yoga_app/services/yogadb.dart';
import 'package:flutter_yoga_app/widgets/CustomAppBar.dart';
import 'package:flutter_yoga_app/widgets/CustomDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorsTween, _homeTween, _yogaTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;



  // Save the yogasummary data model as a List in sharePreference
  void setYogaSum() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final String encodeYogaSumData = YogaSummary.encodeYogaSum([
      YogaSummary(
          id: 1,
          YogaWorkOutName: YogaModel.YogaTable1,
          BackImg:
              "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80",
          TimeTaken: "Time: 45 min",
          TotalNoOfWorkout: "22 WorkOuts"),
      YogaSummary(
          id: 2,
          YogaWorkOutName: YogaModel.YogaTable2,
          BackImg:
              "https://www.healthifyme.com/blog/wp-content/uploads/2019/08/Yoga-Poses-for-Weight-Loss-1.jpg",
          TimeTaken: "Time: 45 min",
          TotalNoOfWorkout: "30 WorkOuts"),
      YogaSummary(
          id: 3,
          YogaWorkOutName: YogaModel.YogaTable3,
          BackImg:
              "https://www.kreedon.com/wp-content/uploads/2022/06/654501.webp",
          TimeTaken: "Time: 7 min",
          TotalNoOfWorkout: "8 positions"),
    ]);

    await pref.setString(YogaModel.YogaSummary, encodeYogaSumData);

    print("Data Saved");
  }

  List<YogaSummary> yogaSumList = [];

  // To get YogaSum data as List from sharePreference
  void getYogaSum() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? yogaSumString = pref.getString(YogaModel.YogaSummary);

    final List<YogaSummary> getYogaSumList =
        YogaSummary.decodeYogaSum(yogaSumString!);

    if (getYogaSumList.isNotEmpty) {
      yogaSumList = getYogaSumList;

      print(yogaSumList[0].id);
      print(yogaSumList[0].YogaWorkOutName);
      print(yogaSumList[1].id);
      print(yogaSumList[1].YogaWorkOutName);
      print(yogaSumList[0].BackImg);
      print(yogaSumList[0].TimeTaken);
      print(yogaSumList[1].TotalNoOfWorkout);
      print(yogaSumList[2].id);
      print(yogaSumList[2].YogaWorkOutName);
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorsTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue)
        .animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_animationController);
    _yogaTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _textAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    super.initState();

    // setYogaSum(YogaModel.YogaTable1, "BackImgUrl", "36 min", "12 workouts");
    // setYogaSum(YogaModel.YogaTable2, "BackImgUrl", "36 min", "12 workouts");
    // getYogaSum();

    // CREATING ONE TYPE OF YOGA WORKOUT PACK
    // makeYogaSumEntry(YogaSummary(YogaWorkOutName: YogaModel.YogaTable1, BackImg: "BackImgUrl", TimeTaken: "45 minutes", TotalNoOfWorkout: "9"));
    // makeYogaEntry(Yoga(seconds: true, YogaTitle: "Anulom Vilom", YogaImgUrl: "DummyUrl", SecondsOrTimes: '16'), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(seconds: true, YogaTitle: "Kapal vati", YogaImgUrl: "DummyUrl1", SecondsOrTimes: '16'), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(seconds: true, YogaTitle: "Hanuman PPushups", YogaImgUrl: "DummyUrl2", SecondsOrTimes: 'x20'), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(seconds: true, YogaTitle: "Squats", YogaImgUrl: "DummyUrl3", SecondsOrTimes: 'x20'), YogaModel.YogaTable1);
    // makeYogaEntry(Yoga(seconds: true, YogaTitle: "Sirsha san", YogaImgUrl: "DummyUrl4", SecondsOrTimes: '20'), YogaModel.YogaTable1);

    // readYogaSumEntry();
    setYogaSum();
    getYogaSum();
  }

  bool scrollListner(ScrollNotification scrollNotification) {
    bool scroll = false;

    if (scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels / 80);
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);

      return scroll = true;
    }
    return scroll;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text("Home Yoga"),
        // ),
        body: NotificationListener(
          onNotification: scrollListner,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 100, 50, 30),
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: const [
                                        Text(
                                          "1",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23),
                                        ),
                                        Text(
                                          "Streak",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text(
                                          "120",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23),
                                        ),
                                        Text(
                                          "KCal",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text(
                                          "26",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23),
                                        ),
                                        Text(
                                          "Minutes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Yoga For All",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () async {

                                        List<Yoga> getYogaList = await YogaDataBase.getYoga();

                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StartUp(yogasList: getYogaList, imgUrl: yogaSumList[0].BackImg, title: yogaSumList[0].YogaWorkOutName, totalTime: yogaSumList[0].TimeTaken, totalWorkouts: yogaSumList[0].TotalNoOfWorkout),
                                          ),
                                        );
                                        YogaDataBase.setYoga([
                                          Yoga(id: 1, seconds: true, YogaTitle: "Anulom Vilom", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 2,seconds: true, YogaTitle: "Kapal Vati", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 3,seconds: true, YogaTitle: "Sirsha San", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 4,seconds: true, YogaTitle: "Tadra San", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 5,seconds: true, YogaTitle: "van San", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),

                                        ]);
                                        // void getYogas () async {}

                                        print(getYogaList[0].YogaTitle);
                                        print(getYogaList[1].YogaTitle);
                                        print(getYogaList[2].YogaTitle);
                                        print(getYogaList[3].YogaTitle);
                                        print(getYogaList[4].YogaTitle);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              image: yogaSumList.isNotEmpty
                                                  ? DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          yogaSumList[0]
                                                              .BackImg),
                                                    )
                                                  : null,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 150,
                                            decoration: const BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 120,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[0]
                                                        .YogaWorkOutName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                          Positioned(
                                            top: 100,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[0].TimeTaken,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                          Positioned(
                                            top: 80,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[0]
                                                        .TotalNoOfWorkout,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {

                                        List<Yoga> getYogaList2 = await YogaDataBase.getYoga();

                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StartUp(yogasList: getYogaList2, imgUrl: yogaSumList[1].BackImg, title: yogaSumList[1].YogaWorkOutName, totalTime: yogaSumList[1].TimeTaken, totalWorkouts: yogaSumList[1].TotalNoOfWorkout),
                                          ),
                                        );
                                        YogaDataBase.setYoga([
                                          Yoga(id: 1, seconds: true, YogaTitle: "Chaturanga Dandasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 2,seconds: true, YogaTitle: "Virabhadrasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 3,seconds: true, YogaTitle: "Trikonasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 4,seconds: true, YogaTitle: "Adho Mukha Svanasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 5,seconds: true, YogaTitle: "Sethu Bandha Sarvangasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),

                                        ]);
                                        // void getYogas () async {}

                                        print(getYogaList2[0].YogaTitle);
                                        print(getYogaList2[1].YogaTitle);
                                        print(getYogaList2[2].YogaTitle);
                                        print(getYogaList2[3].YogaTitle);
                                        print(getYogaList2[4].YogaTitle);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              image: yogaSumList.isNotEmpty
                                                  ? DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          yogaSumList[1]
                                                              .BackImg),
                                                    )
                                                  : null,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 150,
                                            decoration: const BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 120,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[1]
                                                        .YogaWorkOutName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                          Positioned(
                                            top: 100,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[1].TimeTaken,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                          Positioned(
                                            top: 80,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[1]
                                                        .TotalNoOfWorkout,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {

                                        List<Yoga> getYogaList3 = await YogaDataBase.getYoga();

                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StartUp(yogasList: getYogaList3, imgUrl: yogaSumList[2].BackImg, title: yogaSumList[2].YogaWorkOutName, totalTime: yogaSumList[2].TimeTaken, totalWorkouts: yogaSumList[2].TotalNoOfWorkout),
                                          ),
                                        );
                                        YogaDataBase.setYoga([
                                          Yoga(id: 1, seconds: true, YogaTitle: "Pranamasana ", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 2,seconds: true, YogaTitle: "Hastauttanasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 3,seconds: true, YogaTitle: "Hastapadasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 4,seconds: true, YogaTitle: "Ashwa Sanchalanasana", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 5,seconds: true, YogaTitle: "Dandasana ", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 6,seconds: true, YogaTitle: "Ashtanga Namaskara ", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 7,seconds: true, YogaTitle: "Bhujangasana ", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),
                                          Yoga(id: 8,seconds: true, YogaTitle: "Adho Mukha Svanasana  ", YogaImgUrl: 'YogaImgUrl', SecondsOrTimes: 'SecondsOrTimes'),

                                        ]);
                                        // void getYogas () async {}

                                        print(getYogaList3[0].YogaTitle);
                                        print(getYogaList3[1].YogaTitle);
                                        print(getYogaList3[2].YogaTitle);
                                        print(getYogaList3[3].YogaTitle);
                                        print(getYogaList3[4].YogaTitle);
                                        print(getYogaList3[5].YogaTitle);
                                        print(getYogaList3[6].YogaTitle);
                                        print(getYogaList3[7].YogaTitle);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              image: yogaSumList.isNotEmpty
                                                  ? DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          yogaSumList[2]
                                                              .BackImg),
                                                    )
                                                  : null,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 150,
                                            decoration: const BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 120,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[2]
                                                        .YogaWorkOutName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                          Positioned(
                                            top: 100,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[2].TimeTaken,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                          Positioned(
                                            top: 80,
                                            left: 10,
                                            child: yogaSumList.isNotEmpty
                                                ? Text(
                                                    yogaSumList[2]
                                                        .TotalNoOfWorkout,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Text(
                                                    "loading Data...."),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Choose Your Type",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://www.kreedon.com/wp-content/uploads/2021/08/oYDbf5hQAePHEBNZTQMXRA.jpg"),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 150,
                                          decoration: const BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 120,
                                          left: 10,
                                          child: Text(
                                            "Power Yoga",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 100,
                                          left: 10,
                                          child: Text(
                                            "Last Time: Yesterday",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://img.etimg.com/thumb/msid-92353321,width-640,resizemode-4,imgsize-69596/anulom-vilom.jpg"),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 150,
                                          decoration: const BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 120,
                                          left: 10,
                                          child: Text(
                                            "Breathing Yoga",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 100,
                                          left: 10,
                                          child: Text(
                                            "Last Time: 29 Jan",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://e1.pxfuel.com/desktop-wallpaper/67/523/desktop-wallpaper-girl-pose-background-flexibility-yoga-alicia-flexibility.jpg"),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 150,
                                          decoration: const BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 120,
                                          left: 10,
                                          child: Text(
                                            "Increase Flexibility",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 100,
                                          left: 10,
                                          child: Text(
                                            "Last Time: 29 Jan",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CustomAppBar(
                      animationController: _animationController,
                      colorsTween: _colorsTween,
                      homeTween: _homeTween,
                      yogaTween: _yogaTween,
                      iconTween: _iconTween,
                      drawerTween: _drawerTween,
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
