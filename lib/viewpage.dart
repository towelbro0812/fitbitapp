import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './widget/gauge.dart';
import './widget/piechart.dart';

class ViewPage extends StatefulWidget {
  final Map<String, dynamic> myMap;
  const ViewPage({super.key, required this.myMap});
  @override
  State<ViewPage> createState() => _ViewPageState();
  static Map<String, dynamic> validateAndFormatMap(
      Map<String, dynamic> inputMap) {
    Map<String, dynamic> formattedMap = {
      'dateTime': "",
      'startTime': "",
      'endTime': "",
      'duration': "",
      'deep': "",
      'light': "",
      'rem': "",
      'wake': "",
      'totalMinutesAsleep': "",
      'totalTimeInBed': "",
      'nightlyRelative': "",
      'restingHeartRate': "",
      'sop2': "",
      'score': ""
    };

    // 格式驗證和轉換邏輯
    formattedMap['dateTime'] = inputMap['dateTime'] ?? "";
    formattedMap['startTime'] = inputMap['startTime'] ?? "";
    formattedMap['endTime'] = inputMap['endTime'] ?? "";
    formattedMap['duration'] = inputMap['duration'] ?? "";
    formattedMap['deep'] = inputMap['deep'] ?? "";
    formattedMap['light'] = inputMap['light'] ?? "";
    formattedMap['rem'] = inputMap['rem'] ?? "";
    formattedMap['wake'] = inputMap['wake'] ?? "";
    formattedMap['totalMinutesAsleep'] = inputMap['totalMinutesAsleep'] ?? "";
    formattedMap['totalTimeInBed'] = inputMap['totalTimeInBed'] ?? "";
    formattedMap['nightlyRelative'] = inputMap['nightlyRelative'] ?? "";
    formattedMap['restingHeartRate'] = inputMap['restingHeartRate'] ?? "";
    formattedMap['sop2'] = inputMap['sop2'] ?? "";
    formattedMap['score'] = inputMap['score'] ?? "";

    return formattedMap;
  }
}

class _ViewPageState extends State<ViewPage> {
  Map<String, dynamic> formattedMap = {};
  Map<String, double> dataMap = {};
  @override
  void initState() {
    super.initState();
    formattedMap = ViewPage.validateAndFormatMap(widget.myMap);
    dataMap = {
      "deep": double.parse(formattedMap['deep'].toString()),
      "light": double.parse(formattedMap['light'].toString()),
      "rem": double.parse(formattedMap['rem'].toString()),
      "wake": double.parse(formattedMap['wake'].toString()),
    };
  }

  @override
  Widget build(BuildContext context) {
    final totalMinutesAsleep = formattedMap['totalMinutesAsleep'];
    final totalMinutesAsleepDouble =
        totalMinutesAsleep is num ? totalMinutesAsleep.toDouble() : 0.0;
    final hoursAsleep = (totalMinutesAsleepDouble / 60).toStringAsFixed(1);
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Spacer(),
              Container(
                width: 500,
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // 水平和垂直偏移量
                    ),
                  ],
                  color: Color.fromARGB(255, 249, 251, 231),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      formattedMap['dateTime'].toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 43, 39, 48),
                        fontSize: 40,
                      ),
                    ),
                    Gague(
                        score: double.parse(formattedMap['score'].toString())),
                  ],
                ),
              ),
              Spacer(),
              Container(
                  height: 150,
                  color: Colors.white,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // 水平和垂直偏移量
                        ),
                      ],
                      color: Color.fromARGB(255, 249, 251, 231),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            const Icon(
                              Icons.water_drop,
                              size: 60,
                              color: Colors.red,
                            ),
                            Text(
                              "${formattedMap['sop2']}%",
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(width: 30),
                            SvgPicture.asset(
                              "assets/images/heart.svg",
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${formattedMap['restingHeartRate']}/min",
                              style: const TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            SvgPicture.asset(
                              "assets/images/sleep.svg",
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '$hoursAsleep Hr',
                              style: const TextStyle(fontSize: 30),
                            )
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  )),
              Spacer(),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // 水平和垂直偏移量
                    ),
                  ],
                  color: Color.fromARGB(255, 249, 251, 231),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "睡眠階段分析圖",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 5),
                    PieChartWidget(dataMap: dataMap)
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      )),
    );
  }
}
