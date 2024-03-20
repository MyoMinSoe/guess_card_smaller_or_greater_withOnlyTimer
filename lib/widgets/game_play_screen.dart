import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_list.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_model.dart';
import 'package:guess_card_smaller_or_greater/constants/assets.dart';
import 'package:lottie/lottie.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen>
    with TickerProviderStateMixin {
  List<CardModel> card1 = [];
  List<CardModel> card2 = [];
  int index = 0;
  int point = 0;
  int winPoint = 0;

  List<String> preditButton = ['Smaller', 'Bigger', 'Equal'];
  bool enableButton = true;
  bool enableNextRound = false;

  late final myController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this);
  late final myAnimation =
      Tween<double>(begin: 1, end: 0).animate(myController);

  final flipcardController = FlipCardController();
  GlobalKey<FlipCardState> cardkey = GlobalKey();

  Timer? time;
  int timeCount = 5;
  //*********** Predit Time Counter Function ***************** */
  void startTimeCount() {
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeCount == 0) {
        --point;
        time?.cancel();
        enableButton = false;
        roundCount = 5;
        roundCounter();

        setState(() {});
      } else {
        timeCount--;
      }
      setState(() {});
    });
  }

  late Timer roundTime;
  int roundCount = 5;
  //****** Round Counter Timer Function************ */
  void roundCounter() {
    roundTime = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (roundCount == 0) {
          roundTime.cancel();
          enableButton = true;
          timeCount = 5;
          nextRound();
          startTimeCount();
          setState(() {});
        } else {
          roundCount--;
        }
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    card1.addAll(CardList().cardlist);
    card2.addAll(CardList().cardlist);
    card1.shuffle();
    card2.shuffle();

    enableButton = false;

    myController.forward();

    roundCounter();

    super.initState();
  }

  @override
  void dispose() {
    time?.cancel();
    roundTime.cancel();
    myController.dispose();
    super.dispose();
  }

//*********** Flip Card Check Function**************************** */
  void checkCard(String s) {
    switch (s) {
      case 'Smaller':
        if (card1[index].number < card2[index].number) {
          point++;
        } else {
          point--;
        }
        break;
      case 'Bigger':
        if (card1[index].number > card2[index].number) {
          point++;
        } else {
          point--;
        }
        break;
      case 'Equal':
        if (card1[index].number == card2[index].number) {
          point++;
        } else {
          point--;
        }
        break;
      default:
    }
    if (point == winPoint) {
      roundCount = 0;
      timeCount = 0;
      time?.cancel();
      roundTime.cancel();
      setState(() {});
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            alignment: Alignment.center,
            content: SizedBox(
              width: 400,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'You Won',
                    style: TextStyle(
                      color: Color.fromARGB(255, 249, 150, 2),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Lottie.asset(
                    'images/won_cup.json',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'You got $point point !',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 2, 127, 229),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: const Color.fromARGB(255, 36, 1, 95),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  point = 0;
                  setState(() {});
                },
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: const Color.fromARGB(255, 36, 1, 95),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  exit(0);
                },
                child: const Text(
                  'Quit',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
    setState(() {});
  }

//************** Round Begin function *********************** */
  void nextRound() {
    if (!cardkey.currentState!.isFront) {
      cardkey.currentState!.filpCard();
    }
    if (myAnimation.status == AnimationStatus.completed) {
      myController.reset();
    }

    myController.forward();
    enableButton = true;
    setState(() {});
    card1.shuffle();
    card2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    String text = ModalRoute.of(context)!.settings.arguments as String;
    winPoint = int.parse(text);
    Size size = MediaQuery.of(context).size;
    double high = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 0, 67),
        foregroundColor: Colors.white,
        title: const Text('Game Screen'),
      ),
      body: Container(
        color: Colors.pink.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //********** Win Point ************************** */
                  Text(
                    'Win Point  $winPoint |',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 151, 113, 0),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //**************** Point ************************ */
                  Text(
                    '| Point  $point',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 12, 0, 67),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //***************** Countdown Timer ****************** */
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 20, 1, 105),
                  width: 5,
                ),
              ),
              width: width * 0.9,
              height: high * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.4,
                    height: high * 0.1,
                    color: Color.fromARGB(255, 20, 1, 105),
                    child: const Text(
                      'Time Left',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.4,
                    height: high * 0.1,
                    child: Row(
                      children: [
                        const Icon(
                          color: Color.fromARGB(255, 180, 12, 0),
                          Icons.timelapse,
                          size: 50,
                        ),
                        Text(
                          '00:0$timeCount',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 180, 12, 0),
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //************* Show Card image ****************** */
                AnimatedBuilder(
                  animation: myAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -myAnimation.value * 1,
                      origin: Offset(-200, 200),
                      // offset: Offset(-myAnimation.value * 250, 0),
                      child: SizedBox(
                        width: 180,
                        height: 300,
                        child: Image.asset(card1[index].image),
                      ),
                    );
                  },
                ),
                //*************** Flip Card image ******************/
                AnimatedBuilder(
                  animation: myAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(myAnimation.value * 400, 0),
                      child: SizedBox(
                        width: 180,
                        height: 300,
                        child: FlipCard(
                          key: cardkey,
                          backWidget: Image.asset(card2[index].image),
                          frontWidget: Image.asset(Assets.assetsBack),
                          controller: flipcardController,
                          rotateSide: RotateSide.bottom,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            //**********Smaller Bigger Equal - Buttons *************/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 3; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: enableButton
                        ? () {
                            timeCount = 0;
                            time?.cancel();
                            checkCard(preditButton[i]);
                            cardkey.currentState!.filpCard();
                            enableButton = false;
                            roundCount = 5;
                            roundCounter();

                            setState(() {});
                          }
                        : null,
                    child: Text(
                      preditButton[i],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
              ],
            ),
            //******************* Round Begin 0 ****************** */
            SizedBox(
              width: width * 0.9,
              height: high * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Round Begin',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        '$roundCount',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 90,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
