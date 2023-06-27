import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'widget/block.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> csvData = [];
  List<Map<String, dynamic>> lastData = [];

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  Future<void> loadCSV() async {
    final csvFile = await rootBundle.loadString('assets/data/fitbit202303.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvFile);
    setState(() {
      csvData = csvTable;
      for (int i = 0; i < csvData.length; i++) {
        // 检查是否是空白行
        if (csvData[i].any(
            (value) => value != null && value.toString().trim().isNotEmpty)) {
          Map<String, dynamic> myMap = {
            'dateTime': csvData[i][0],
            'startTime': csvData[i][1],
            'endTime': csvData[i][2],
            'duration': csvData[i][3],
            'deep': csvData[i][4],
            'light': csvData[i][5],
            'rem': csvData[i][6],
            'wake': csvData[i][7],
            'totalMinutesAsleep': csvData[i][8],
            'totalTimeInBed': csvData[i][9],
            'nightlyRelative': csvData[i][10],
            'restingHeartRate': csvData[i][11],
            'sop2': csvData[i][12],
            'score': csvData[i][13],
          };
          lastData.add(myMap);
        }
      }
      //print(lastData);
      // 理論上應該是最後一天的資訊在最上面
      lastData = lastData.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = lastData.length;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 50,
              child: const Text(
                "  HI , USER",
                style: TextStyle(
                  color: Color.fromARGB(255, 43, 39, 48),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return Myblock(bodydata: lastData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
