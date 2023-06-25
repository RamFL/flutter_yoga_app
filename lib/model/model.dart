import 'dart:convert';

class YogaModel {
  static String YogaTable1 = "Yoga For Beginner";
  static String YogaTable2 = "Weight Loss Yoga";
  static String YogaTable3 = "Suryanamaskaram";
  static String YogaSummary = "YogaSummary";
  static String YogaWorkOutName = "YogaWorkOutName";
  static String BackImg = "BackImg";
  static String TimeTaken = "TimeTaken";
  static String TotalNoOfWorkout = "TotalNoOfWorkout";
  static String IDName = "ID";
  static String YogaName = "YogaName";
  static String SecondsOrNot = "SecondsOrNot";
  static String SecondsOrTimes = "SecondsOrTimes";
  static String ImageName = "ImageName";

  static List<String>? YogaTable1ColumnName = [
    YogaModel.IDName,
    YogaModel.YogaName,
    YogaModel.ImageName,
    YogaModel.SecondsOrNot,
    YogaModel.SecondsOrTimes
  ];
}

class Yoga {
  final int? id;
  final bool seconds;
  final String YogaTitle;
  final String YogaImgUrl;
  final String SecondsOrTimes;

  const Yoga(
      {
        required this.id,
      required this.seconds,
      required this.YogaTitle,
      required this.YogaImgUrl,
      required this.SecondsOrTimes});

  Yoga copy(
      {int? id,
      bool? seconds,
      String? YogaTitle,
      String? YogaImgUrl,
      String? SecondsOrTimes}) {
    return Yoga(
        id: id ?? this.id,
        seconds: seconds ?? this.seconds,
        YogaTitle: YogaTitle ?? this.YogaTitle,
        YogaImgUrl: YogaImgUrl ?? this.YogaImgUrl,
        SecondsOrTimes: SecondsOrTimes ?? this.SecondsOrTimes);
  }

  //json to object/class
  static Yoga fromJson(Map<String, dynamic> json) {
    return Yoga(
        id: json[YogaModel.IDName],
        seconds: json['seconds'] == 1,
        YogaTitle: json['YogaTitle'] as String,
        YogaImgUrl: json['YogaImgUrl'] as String,
        SecondsOrTimes: json['SecondsOrTimes'] as String);
  }

  //class/object to json
  Map<String, Object?> toJson() {
    return {
      YogaModel.IDName: id,
      YogaModel.SecondsOrNot: seconds ? 1 : 0,
      YogaModel.YogaName: YogaTitle,
      YogaModel.ImageName: YogaImgUrl,
      YogaModel.SecondsOrTimes: SecondsOrTimes,
    };
  }

  // convert class/object to a map
  static Map<String, dynamic> toMap(Yoga yogaM) {
    return {
      'id': yogaM.id,
      'seconds': yogaM.seconds,
      'YogaTitle': yogaM.YogaTitle,
      'YogaImgUrl': yogaM.YogaImgUrl,
      'SecondsOrTimes': yogaM.SecondsOrTimes,
    };
  }

  // This is a String type function which Encode the dataModel as a List
  static String encodeYoga(List<Yoga> yogaL) => json.encode(
        yogaL.map<Map<String, dynamic>>((yogal) => Yoga.toMap(yogal)).toList(),
      );

  //This is a List type function to decode the encoded String
  static List<Yoga> decodeYoga(String yogaG) =>
      (json.decode(yogaG) as List<dynamic>)
          .map<Yoga>((yogag) => Yoga.fromJson(yogag))
          .toList();
}

class YogaSummary {
  final int id;
  final String YogaWorkOutName;
  final String BackImg;
  final String TimeTaken;
  final String TotalNoOfWorkout;

  const YogaSummary({
    required this.id,
    required this.YogaWorkOutName,
    required this.BackImg,
    required this.TimeTaken,
    required this.TotalNoOfWorkout,
  });

  YogaSummary copy(
      {int? id,
      String? YogaWorkOutName,
      String? BackImg,
      String? TimeTaken,
      String? TotalNoOfWorkout}) {
    return YogaSummary(
        id: id ?? this.id,
        YogaWorkOutName: YogaWorkOutName ?? this.YogaWorkOutName,
        BackImg: BackImg ?? this.BackImg,
        TimeTaken: TimeTaken ?? this.TimeTaken,
        TotalNoOfWorkout: TotalNoOfWorkout ?? this.TotalNoOfWorkout);
  }

  //json to object/class
  static YogaSummary fromJson(Map<String, dynamic> json) {
    return YogaSummary(
        id: json['id'],
        YogaWorkOutName: json[YogaModel.YogaWorkOutName] as String,
        BackImg: json[YogaModel.BackImg] as String,
        TimeTaken: json[YogaModel.TimeTaken] as String,
        TotalNoOfWorkout: json[YogaModel.TotalNoOfWorkout] as String);
  }

  //class/object to json
  Map<String, Object?> toJson() {
    return {
      YogaModel.IDName: id,
      YogaModel.YogaWorkOutName: YogaWorkOutName,
      YogaModel.BackImg: BackImg,
      YogaModel.TimeTaken: TimeTaken,
      YogaModel.TotalNoOfWorkout: TotalNoOfWorkout,
    };
  }

  // convert class/object to a map
  static Map<String, dynamic> toMap(YogaSummary yogaSum) {
    return {
      'id': yogaSum.id,
      'YogaWorkOutName': yogaSum.YogaWorkOutName,
      'BackImg': yogaSum.BackImg,
      'TimeTaken': yogaSum.TimeTaken,
      'TotalNoOfWorkout': yogaSum.TotalNoOfWorkout,
    };
  }

  // This is a String type function which Encode the dataModel as a List
  static String encodeYogaSum(List<YogaSummary> yogaSumS) => json.encode(
        yogaSumS
            .map<Map<String, dynamic>>((yogaS) => YogaSummary.toMap(yogaS))
            .toList(),
      );

  //This is a List type function to decode the encoded String
  static List<YogaSummary> decodeYogaSum(String yogaSums) =>
      (json.decode(yogaSums) as List<dynamic>)
          .map<YogaSummary>((yogas) => YogaSummary.fromJson(yogas))
          .toList();
}
