import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_list.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_model.dart';
import 'package:guess_card_smaller_or_greater/constants/assets.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<CardModel> card1 = [];
  List<CardModel> card2 = [];
  int index = 0;

  int point = 0;

  List<String> preditButton = ['Smaller', 'Bigger', 'Equal'];
  bool enableButton = true;
  bool enableNextRound = false;

  late final lottieController = AnimationController(vsync: this);

  late final myController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this);
  late final myAnimation =
      Tween<double>(begin: 1, end: 0).animate(myController);

  final flipcardController = FlipCardController();
  GlobalKey<FlipCardState> cardkey = GlobalKey();

  @override
  void initState() {
    card1.addAll(CardList().cardlist);
    card2.addAll(CardList().cardlist);
    card1.shuffle();
    card2.shuffle();
    myController.forward();

    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    lottieController.dispose();
    super.dispose();
  }

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
    if (point == 2) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            icon: Lottie.asset(
              controller: lottieController,
              'images/won_cup.json',
              repeat: true,
              width: 80,
              height: 80,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('back'),
              ),
            ],
          );
        },
      );
    }
    setState(() {});
  }

  void nextRound() {
    if (!cardkey.currentState!.isFront) {
      cardkey.currentState!.filpCard();
    }
    if (myAnimation.status == AnimationStatus.completed) {
      myController.reset();
    }

    myController.forward();
    enableButton = true;
    enableNextRound = false;
    setState(() {});
    card1.shuffle();
    card2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.withOpacity(0.2),
      child: Column(
        children: [
          Text(
            'Point  -  $point',
            style: const TextStyle(
              color: Color.fromARGB(255, 12, 0, 67),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 3; i++)
                ElevatedButton(
                  onPressed: enableButton
                      ? () {
                          checkCard(preditButton[i]);
                          cardkey.currentState!.filpCard();
                          enableButton = false;
                          enableNextRound = true;
                          setState(() {});
                        }
                      : null,
                  child: Text(preditButton[i]),
                ),
            ],
          ),
          ElevatedButton(
            onPressed: enableNextRound
                ? () {
                    nextRound();
                  }
                : null,
            child: Text('Next Round'),
          ),
        ],
      ),
    );
  }
}
