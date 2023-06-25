import 'dart:convert';

import 'package:flutter_yoga_app/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YogaDataBase {
  //To set YogaSum data
  static void setYogaSum() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // Map<String, dynamic> toMap (YogaSummary yogaSum ) => {
    //   'id': yogaSum.id,
    //   'YogaWorkOutName': yogaSum.YogaWorkOutName,
    //   'BackImg': yogaSum.BackImg,
    //   'TimeTaken': yogaSum.TimeTaken,
    //   'TotalNoOfWorkout': yogaSum.TotalNoOfWorkout,
    // };

    // String encodeYogaSum(List<YogaSummary> yogaSumS) => json.encode(
    //   yogaSumS.map<Map<String, dynamic>>((yogaS) => YogaSummary.toMap(yogaS)).toList(),
    // );

    final String encodeYogaSumData = YogaSummary.encodeYogaSum([
      YogaSummary(
          id: 1,
          YogaWorkOutName: YogaModel.YogaTable1,
          BackImg: "BackImg",
          TimeTaken: "TimeTaken",
          TotalNoOfWorkout: "TotalNoOfWorkout"),
      YogaSummary(
          id: 2,
          YogaWorkOutName: YogaModel.YogaTable2,
          BackImg: "BackImg",
          TimeTaken: "TimeTaken",
          TotalNoOfWorkout: "TotalNoOfWorkout"),
      YogaSummary(
          id: 3,
          YogaWorkOutName: YogaModel.YogaTable3,
          BackImg: "BackImg",
          TimeTaken: "TimeTaken",
          TotalNoOfWorkout: "TotalNoOfWorkout"),
    ]);

    await pref.setString(YogaModel.YogaSummary, encodeYogaSumData);

    print("Data Saved");

    // YogaSummary yogaSum = YogaSummary(
    //     YogaWorkOutName: YogaWorkOutName,
    //     BackImg: BackImg,
    //     TimeTaken: TimeTaken,
    //     TotalNoOfWorkout: TotalNoOfWorkout);
    //
    // String yogaSumData = jsonEncode(yogaSum);
    //
    // await pref.setString(YogaModel.YogaSummary, yogaSumData);
    // pref.setStringList(YogaModel.YogaSummary, yogaSumData);
  }

  // To get YogaSum data
  static void getYogaSum() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? yogaSumString = pref.getString(YogaModel.YogaSummary);

    final List<YogaSummary> yogas = YogaSummary.decodeYogaSum(yogaSumString!);

    print(yogas[0].id);
    print(yogas[0].YogaWorkOutName);
    print(yogas[1].id);
    print(yogas[1].YogaWorkOutName);
    print(yogas[1].BackImg);
    print(yogas[1].TimeTaken);
    print(yogas[1].TotalNoOfWorkout);
    print(yogas[2].id);
    print(yogas[2].YogaWorkOutName);

    // Map<String, Object?> jsonDetails =
    //     jsonDecode(pref.getString(YogaModel.YogaSummary)!);

    // YogaSummary yogaSumDetails = YogaSummary.fromJson(jsonDetails);
  }

  static void setYoga (List<Yoga> yogaSetList) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String encodeYogaData = Yoga.encodeYoga(yogaSetList);

    await pref.setString('YogaList', encodeYogaData);

    print("Yoga Data Saved");
  }

  static Future<List<Yoga>> getYoga () async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? yogaString = pref.getString('YogaList');

    final List<Yoga> getYogaList = Yoga.decodeYoga(yogaString!);

    return getYogaList;
  }
}
