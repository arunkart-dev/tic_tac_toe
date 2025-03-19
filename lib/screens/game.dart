import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/Constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oturn = true; //Firstplayer
  bool winnerfound = false;
  List<String> DisplayXO = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledboxes = 0;
  static const maxseconds = 30;
  int seconds = maxseconds;
  Timer? timer;
  String resultDeclaration = '';
  static var CustomFontwhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28),
  );

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxseconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player 0', style: CustomFontwhite),
                          Text(oScore.toString(), style: CustomFontwhite),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player X', style: CustomFontwhite),
                          Text(xScore.toString(), style: CustomFontwhite),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: MainColor.primaryColor,
                        ),
                        color: MainColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          DisplayXO[index],
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              fontSize: 64,
                              color: MainColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultDeclaration, style: CustomFontwhite),
                    SizedBox(height: 10),
                    _buildtimer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      //XandO BOARD LOGIC
      setState(() {
        if (oturn && DisplayXO[index] == '') {
          DisplayXO[index] = 'O';
          filledboxes++;
        } else if (!oturn && DisplayXO[index] == '') {
          DisplayXO[index] = 'X';
          filledboxes++;
        }
        oturn = !oturn;
        _checkwinner();
      });
    }
  }

  void _checkwinner() {
    //Winnerlogic
    //check1strow
    if (DisplayXO[0] == DisplayXO[1] &&
        DisplayXO[0] == DisplayXO[2] &&
        DisplayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[0] + ' Wins !';
        _updatescore(DisplayXO[0]);
      });
    }
    //check2ndrow
    if (DisplayXO[3] == DisplayXO[4] &&
        DisplayXO[3] == DisplayXO[5] &&
        DisplayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[3] + ' Wins !';
        _updatescore(DisplayXO[3]);
      });
    }
    //check3rdrow
    if (DisplayXO[6] == DisplayXO[7] &&
        DisplayXO[6] == DisplayXO[8] &&
        DisplayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[6] + ' Wins !';
        _updatescore(DisplayXO[6]);
      });
    }
    //check1stcolumn
    if (DisplayXO[0] == DisplayXO[3] &&
        DisplayXO[0] == DisplayXO[6] &&
        DisplayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[0] + ' Wins !';
        _updatescore(DisplayXO[0]);
      });
    }
    //check2ndcolumn
    if (DisplayXO[1] == DisplayXO[4] &&
        DisplayXO[1] == DisplayXO[7] &&
        DisplayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[1] + ' Wins !';
        _updatescore(DisplayXO[1]);
      });
    }
    //check3rdcolumn
    if (DisplayXO[2] == DisplayXO[5] &&
        DisplayXO[2] == DisplayXO[8] &&
        DisplayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[2] + ' Wins !';
        _updatescore(DisplayXO[2]);
      });
    }
    //checkleftdiagonal
    if (DisplayXO[0] == DisplayXO[4] &&
        DisplayXO[0] == DisplayXO[8] &&
        DisplayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[0] + ' Wins !';
        _updatescore(DisplayXO[0]);
      });
    }
    //checkrightdiagonal
    if (DisplayXO[6] == DisplayXO[4] &&
        DisplayXO[6] == DisplayXO[2] &&
        DisplayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + DisplayXO[6] + ' Wins !';
        _updatescore(DisplayXO[6]);
      });
    }

    if (!winnerfound && filledboxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }

  void _updatescore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerfound = true;
  }

  void _clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        DisplayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledboxes = 0;
  }

  Widget _buildtimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1 - seconds / maxseconds,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 8,
                backgroundColor: MainColor.accentColor,
              ),
              Center(
                child: Text('$seconds',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 50),),
              )
            ],
          ),
        )
        : ElevatedButton(
          onPressed: () {
            startTimer();
            _clearboard();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            'PlayAgain !',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        );
  }

  //* ElevatedButton(
  // onPressed: () {
  // _clearboard();
  //  },
  // style: ElevatedButton.styleFrom(
  // backgroundColor: Colors.white,
  // padding: EdgeInsets.symmetric(
  //  horizontal: 32,
  //   vertical: 16,
  // ),
  // ),
  //child: Text(
  //  'PlayAgain !',
  // style: TextStyle(fontSize: 20, color: Colors.black),
  //),
  // ),
}
