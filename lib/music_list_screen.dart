import 'dart:core';

import 'package:audio_player/circular_card_button.dart';
import 'package:flutter/material.dart';

class MusicListScreen extends StatefulWidget {
  const MusicListScreen({Key? key}) : super(key: key);

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  List<Map> listes = [
    {'title': 'Arabic Kuthu', 'singer': 'Aniruth'},
    {'title': 'Summa Surunu', 'singer': 'Imman'},
    {'title': 'Adiye', 'singer': 'G.v'},
    {'title': 'Vera Mari', 'singer': 'U1'},
    {'title': 'Arakiye', 'singer': 'hipop Adhi'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'A Skyline-Lover',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircularCardButton(
                      child: Icon(
                    Icons.star,
                    color: Colors.black38,
                  )),
                  _audioAvatar(),
                  const CircularCardButton(
                      child: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.black38,
                  )),
                ],
              ),
              const SizedBox(height: 40),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listes.length,
                  itemBuilder: (context, index) => MusicItemTile(
                        listes: listes,
                        index: index,
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Container _audioAvatar() {
    return Container(
      height: 170,
      width: 220,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.pink.shade200)],
          shape: BoxShape.circle,
          image: const DecorationImage(
              image: AssetImage('asset/cute.jpg'), fit: BoxFit.cover)),
    );
  }
}

class MusicItemTile extends StatelessWidget {
  const MusicItemTile({
    Key? key,
    required this.listes,
    required this.index,
  }) : super(key: key);

  final List<Map> listes;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(20),
          height: 90,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listes[index]['title'],
                    style: const TextStyle(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(listes[index]['singer'],
                      style:
                          const TextStyle(color: Colors.black26, fontSize: 15)),
                ],
              ),
              const CircularCardButton(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.black38,
                ),
                radius: 80,
              ),
            ],
          )),
      onTap: () {},
    );
  }
}
