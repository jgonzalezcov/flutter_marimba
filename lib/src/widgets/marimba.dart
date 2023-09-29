import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:game/src/data/key.data.dart';
import 'dart:async';

class MarimbaWidget extends StatefulWidget {
  const MarimbaWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MarimbaWidgetState createState() => _MarimbaWidgetState();
}

class _MarimbaWidgetState extends State<MarimbaWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int selectedIndex = -1;

  Future<void> playAudio(int index) async {
    if (index >= 0 && index < tarotDeck.length) {
      await audioPlayer.stop();
      await audioPlayer.play(
        AssetSource(tarotDeck[index].soundKey),
      );

      setState(() {
        selectedIndex = index;
      });
      Timer(const Duration(milliseconds: 400), () {
        setState(() {
          selectedIndex = -1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final keyWidth = screenWidth / 9;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/fondo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: OrientationBuilder(
            builder: (context, orientation) {
              final screenHeight = MediaQuery.of(context).size.height;
              final keyHeight = screenHeight * 0.7;

              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(tarotDeck.length, (index) {
                      final marimbaKey = tarotDeck[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          playAudio(index);
                        },
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 100,
                              ),
                              width: keyWidth,
                              height: selectedIndex == index
                                  ? keyHeight - 10
                                  : keyHeight,
                              margin: const EdgeInsets.only(
                                right: 8,
                              ),
                              decoration: BoxDecoration(
                                color: marimbaKey.colorKey,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  if (selectedIndex == index)
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/imgs/ovalo2.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                    Image.asset(
                                      'assets/imgs/ovalo2.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              top: selectedIndex == index ? 0 : keyHeight / 2,
                              left: keyWidth / 2 -
                                  (selectedIndex == index ? 30 : 15),
                              child: AnimatedOpacity(
                                opacity: selectedIndex == index ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: selectedIndex == index ? 60 : 30,
                                  height: selectedIndex == index ? 60 : 30,
                                  child: Image.asset(
                                    'assets/imgs/notas.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
