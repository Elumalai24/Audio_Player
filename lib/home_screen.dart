import 'dart:typed_data';
import 'package:audio_player/music_list_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'circular_card_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        body: const SafeArea(
            child: SingleChildScrollView(
          child: MyApp(),
        )));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPlaying = false;
  bool audioPlay = false;
  late Uint8List audioBytes;

  int maxDuration = 100;
  int curPosition = 0;
  String audioAsset = 'asset/song.mp3';
  String curpositionLabel = '00:00';

  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ByteData bytes = await rootBundle.load(audioAsset);
      audioBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      player.onDurationChanged.listen((Duration d) {
        maxDuration = d.inMilliseconds;
        setState(() {});
      });
      player.onAudioPositionChanged.listen((Duration p) {
        curPosition = p.inMilliseconds;
        int shour = Duration(milliseconds: curPosition).inHours;
        int smin = Duration(milliseconds: curPosition).inMinutes;
        int ssec = Duration(milliseconds: curPosition).inSeconds;
        int rhour = shour;
        int rmin = smin - (shour * 60);
        int rsec = ssec - (smin * 60 + shour * 60 * 60);
        curpositionLabel = '$rhour:$rmin:$rsec';
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _appbarArrow(context),
            const Text(
              'Now Playing',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38),
            ),

            // Functionality need to be added
            _menuButton(context),
          ],
        ),
        const SizedBox(height: 60),
        _songAvatar(),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Awesome',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black45),
        ),
        const SizedBox(height: 10),
        const Text(
          'A Skyline',
          style: TextStyle(fontSize: 20, color: Colors.black26),
        ),
        const SizedBox(height: 50),

        // Slider for controlling position
        Slider(
          activeColor: Colors.pink[200],
          inactiveColor: Colors.pink.shade100,
          value: double.parse(curPosition.toString()),
          divisions: maxDuration,
          min: 0,
          max: double.parse(maxDuration.toString()),
          label: curpositionLabel,
          onChanged: (double val) async {
            int seekval = val.round();
            int result = await player.seek(Duration(milliseconds: seekval));
            if (result == 1) {
              curPosition = seekval;
            } else {
              debugPrint('seek unsuccessful');
            }
          },
        ),
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Funtions need to be added
            const CircularCardButton(
              child: Icon(Icons.fast_rewind, color: Colors.black38, size: 32),
              radius: 80,
            ),
            CircularCardButton(
              child: Icon(
                !isPlaying ? Icons.play_arrow : Icons.pause,
                color: Colors.black38,
              ),
              radius: 80,
              onTap: () async {
                if (!isPlaying && !audioPlay) {
                  print('hi');
                  int result = await player.playBytes(audioBytes);
                  if (result == 1) {
                    setState(() {
                      isPlaying = true;
                      audioPlay = true;
                    });
                  } else {
                    print('Error in playing');
                  }
                } else if (!isPlaying && audioPlay) {
                  int result = await player.resume();
                  if (result == 1) {
                    setState(() {
                      isPlaying = true;
                      audioPlay = true;
                    });
                  } else {
                    print('Error in resuming');
                  }
                } else {
                  int result = await player.pause();
                  if (result == 1) {
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    print('Error in resuming');
                  }
                }
              },
            ),
            const CircularCardButton(
              child: Icon(Icons.fast_forward, color: Colors.black38, size: 32),
              radius: 80,
            ),
          ],
        )
      ],
    );
  }

  Container _songAvatar() {
    return Container(
      height: 250,
      width: 280,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.pink.shade200)],
          shape: BoxShape.circle,
          image: const DecorationImage(
              image: AssetImage('asset/cute.jpg'), fit: BoxFit.cover)),
    );
  }

  CircularCardButton _menuButton(BuildContext context) {
    return CircularCardButton(
      child: const Icon(
        Icons.menu_outlined,
        color: Colors.black38,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MusicListScreen()));
      },
    );
  }

  CircularCardButton _appbarArrow(BuildContext context) {
    return CircularCardButton(
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black38,
      ),
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );
  }
}
