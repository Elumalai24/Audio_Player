import 'package:flutter/material.dart';

import 'mainScreen.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// // This Widget is the main application widget.
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MySliderApp(),
//     );
//   }
// }

// class MySliderApp extends StatefulWidget {
//   @override
//   _MySliderAppState createState() => _MySliderAppState();
// }

// class _MySliderAppState extends State<MySliderApp> {
//   int _value = 6;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Slider Demo'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Center(
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                 Icon(
//                   Icons.volume_up,
//                   size: 40,
//                 ),
//                 new Expanded(
//                     child: Slider(
//                         value: _value.toDouble(),
//                         min: 1.0,
//                         max: 20.0,
//                         divisions: 10,
//                         activeColor: Colors.green,
//                         inactiveColor: Colors.orange,
//                         label: 'Set volume value',
//                         onChanged: (double newValue) {
//                           setState(() {
//                             _value = newValue.round();
//                           });
//                         },
//                         semanticFormatterCallback: (double newValue) {
//                           return '${newValue.round()} dollars';
//                         })),
//               ])),
//         ));
//   }
// }

// import 'dart:typed_data';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Home());
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int maxduration = 100;
//   int currentpos = 0;
//   String currentpostlabel = "00:00";
//   String audioasset = "asset/song.mp3";
//   bool isplaying = false;
//   bool audioplayed = false;
//   late Uint8List audiobytes;

//   AudioPlayer player = AudioPlayer();

//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       ByteData bytes =
//           await rootBundle.load(audioasset); //load audio from assets
//       audiobytes =
//           bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//       //convert ByteData to Uint8List

//       player.onDurationChanged.listen((Duration d) {
//         //get the duration of audio
//         maxduration = d.inMilliseconds;
//         setState(() {});
//       });

//       player.onAudioPositionChanged.listen((Duration p) {
//         currentpos =
//             p.inMilliseconds; //get the current position of playing audio

//         //generating the duration label
//         int shours = Duration(milliseconds: currentpos).inHours;
//         int sminutes = Duration(milliseconds: currentpos).inMinutes;
//         int sseconds = Duration(milliseconds: currentpos).inSeconds;

//         int rhours = shours;
//         int rminutes = sminutes - (shours * 60);
//         int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

//         currentpostlabel = "$rhours:$rminutes:$rseconds";

//         setState(() {
//           //refresh the UI
//         });
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text("Play Audio in Flutter App"),
//             backgroundColor: Colors.redAccent),
//         body: Container(
//             margin: EdgeInsets.only(top: 50),
//             child: Column(
//               children: [
//                 Container(
//                   child: Text(
//                     currentpostlabel,
//                     style: TextStyle(fontSize: 25),
//                   ),
//                 ),
//                 Container(
//                     child: Slider(
//                   value: double.parse(currentpos.toString()),
//                   min: 0,
//                   max: double.parse(maxduration.toString()),
//                   divisions: maxduration,
//                   label: currentpostlabel,
//                   onChanged: (double value) async {
//                     int seekval = value.round();
//                     int result =
//                         await player.seek(Duration(milliseconds: seekval));
//                     print(result);
//                     if (result == 1) {
//                       //seek successful
//                       currentpos = seekval;
//                     } else {
//                       print("Seek unsuccessful.");
//                     }
//                   },
//                 )),
//                 Container(
//                   child: Wrap(
//                     spacing: 10,
//                     children: [
//                       ElevatedButton.icon(
//                           onPressed: () async {
//                             if (!isplaying && !audioplayed) {
//                               int result = await player.playBytes(audiobytes);
//                               if (result == 1) {
//                                 //play success
//                                 setState(() {
//                                   isplaying = true;
//                                   audioplayed = true;
//                                 });
//                                 print('1');
//                               } else {
//                                 print("Error while playing audio.");
//                               }
//                             } else if (audioplayed && !isplaying) {
//                               int result = await player.resume();
//                               if (result == 1) {
//                                 //resume success
//                                 setState(() {
//                                   isplaying = true;
//                                   audioplayed = true;
//                                   print('2');
//                                 });
//                               } else {
//                                 print("Error on resume audio.");
//                               }
//                             } else {
//                               int result = await player.pause();
//                               if (result == 1) {
//                                 //pause success
//                                 setState(() {
//                                   isplaying = false;
//                                   print('3');
//                                 });
//                               } else {
//                                 print("Error on pause audio.");
//                               }
//                             }
//                           },
//                           icon:
//                               Icon(isplaying ? Icons.pause : Icons.play_arrow),
//                           label: Text(isplaying ? "Pause" : "Play")),
//                       ElevatedButton.icon(
//                           onPressed: () async {
//                             int result = await player.stop();
//                             if (result == 1) {
//                               //stop success
//                               setState(() {
//                                 isplaying = false;
//                                 audioplayed = false;
//                                 currentpos = 0;
//                               });
//                             } else {
//                               print("Error on stop audio.");
//                             }
//                           },
//                           icon: Icon(Icons.stop),
//                           label: Text("Stop")),
//                     ],
//                   ),
//                 )
//               ],
//             )));
//   }
// }
