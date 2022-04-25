import 'package:audio_player/player.dart';
import 'package:flutter/material.dart';

Widget musicFunc({required String title, required String age, onTap}) {
  return Column(
    children: [Text(title), Text(age)],
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPlaying = false;
  var plybtn = Icons.play_arrow;
  String range = '';
  String start = 'hi';
  Duration begin = const Duration();
  Duration musicLength = const Duration();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Card(
                          shape: const CircleBorder(),
                          elevation: 5,
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pink.shade100,
                                        blurRadius: 20)
                                  ]),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black38,
                              )),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Player()));
                        },
                      ),
                      const Text(
                        'Now Playing',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38),
                      ),
                      InkWell(
                        child: Card(
                          shape: const CircleBorder(),
                          elevation: 5,
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pink.shade100,
                                        blurRadius: 20)
                                  ]),
                              child: const Icon(
                                Icons.menu_outlined,
                                color: Colors.black38,
                              )),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Container(
                    height: 250,
                    width: 280,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.pink.shade200)
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage('asset/cute.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Awesome',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A Skyline',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                  ),
                  const SizedBox(height: 50),
                  Slider(
                      activeColor: Colors.pink[200],
                      inactiveColor: Colors.pink[200],
                      value: begin.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          range = '$begin';
                        });
                      },
                      min: 0,
                      max: musicLength.inSeconds.toDouble(),
                      onChangeStart: (state) => setState(() {
                            state = 5;
                          })),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Card(
                          shape: const CircleBorder(),
                          elevation: 5,
                          child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pink.shade100,
                                        blurRadius: 20)
                                  ]),
                              child: const Icon(Icons.fast_rewind,
                                  color: Colors.black38, size: 32)),
                        ),
                        onTap: () {},
                      ),
                      InkWell(
                        child: Card(
                          shape: const CircleBorder(),
                          elevation: 5,
                          child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pink.shade100,
                                        blurRadius: 20)
                                  ]),
                              child: Icon(plybtn,
                                  color: Colors.black38, size: 32)),
                        ),
                        onTap: () {
                          if (!isPlaying) {
                            setState(() {
                              plybtn = Icons.pause;
                              isPlaying = true;
                            });
                          } else {
                            setState(() {
                              plybtn = Icons.play_arrow;
                              isPlaying = false;
                            });
                          }
                        },
                      ),
                      InkWell(
                        child: Card(
                          shape: const CircleBorder(),
                          elevation: 5,
                          child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.pink[50],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pink.shade100,
                                        blurRadius: 20)
                                  ]),
                              child: const Icon(Icons.fast_forward,
                                  color: Colors.black38, size: 32)),
                        ),
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
