import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../viewpage.dart';

class Myblock extends StatefulWidget {
  final Map<String, dynamic> bodydata;
  const Myblock({super.key, required this.bodydata});
  @override
  State<Myblock> createState() => _MyblockState();
  //格式驗證
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

class _MyblockState extends State<Myblock> {
  Map<String, dynamic> formattedMap = {};
  @override
  void initState() {
    super.initState();
    formattedMap = Myblock.validateAndFormatMap(widget.bodydata);
  }

  @override
  Widget build(BuildContext context) {
    final totalMinutesAsleep = formattedMap['totalMinutesAsleep'];
    final totalMinutesAsleepDouble =
        totalMinutesAsleep is num ? totalMinutesAsleep.toDouble() : 0.0;
    final hoursAsleep = (totalMinutesAsleepDouble / 60).toStringAsFixed(1);

    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ViewPage(myMap: formattedMap);
          }));
        },
        child: Container(
          alignment: Alignment.topLeft,
          height: 220,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // 水平和垂直偏移量
              ),
            ],
            color: const Color.fromARGB(231, 191, 234, 245),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 將子元素左對齊
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 100,
                  ),
                  SvgPicture.asset(
                    'assets/images/heart.svg',
                    width: 40.0,
                    height: 40.0,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${formattedMap['restingHeartRate']}/min",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 43, 39, 48),
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(width: 50),
                  const Icon(
                    Icons.water_drop,
                    size: 40,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 5),
                  Text("${formattedMap['sop2']}%",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 43, 39, 48),
                        fontSize: 30,
                      ))
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 70,
                  ),
                  SvgPicture.asset(
                    'assets/images/sleep.svg',
                    width: 40.0,
                    height: 40.0,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$hoursAsleep Hr',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 43, 39, 48),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 230,
                    height: 50,
                  ),
                  Text(
                    formattedMap['dateTime'],
                    style: const TextStyle(
                      color: Color.fromARGB(225, 101, 84, 175),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
