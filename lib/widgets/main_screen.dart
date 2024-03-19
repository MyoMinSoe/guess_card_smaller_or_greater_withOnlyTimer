import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_list.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_model.dart';
import 'package:guess_card_smaller_or_greater/constants/assets.dart';

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

  late final myController =
      AnimationController(duration: Duration(milliseconds: 800), vsync: this);
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
    // TODO: implement initState
    myController.forward();
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.withOpacity(0.2),
      child: Column(
        children: [
          Text('Point : $point'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedBuilder(
                animation: myAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-myAnimation.value * 250, 0),
                    child: SizedBox(
                      width: 180,
                      height: 400,
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
                      height: 400,
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
          ElevatedButton(
            onPressed: () {
              cardkey.currentState!.filpCard();
            },
            child: Text('check'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!cardkey.currentState!.isFront) {
                cardkey.currentState!.filpCard();
              }
              if (myAnimation.status == AnimationStatus.completed) {
                myController.reset();
              }
              index++;
              myController.forward();
              setState(() {});
            },
            child: Text('Next Round'),
          ),
        ],
      ),
    );
  }
}
