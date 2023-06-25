import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yoga_app/Screens/WorkOutDet.dart';
import 'package:provider/provider.dart';

class AreYouReady extends StatelessWidget {
  const AreYouReady({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(context),
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                ),
                const Text(
                  "ARE YOU READY ?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<TimerModel>(
                  builder: (context, myModel, child) {
                    return Text(
                      myModel.countDown.toString(),
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.w500),
                    );
                  },
                ),
                const Spacer(),
                const Divider(
                  thickness: 2,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Next: Anulom Vilom",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerModel with ChangeNotifier {
  TimerModel(context) {
    MyTimer(context);
  }

  int countDown = 5;

  MyTimer(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown--;
      notifyListeners();

      if (countDown == 0) {
        timer.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkOutDet(),
            ));
      }
    });
  }
}
