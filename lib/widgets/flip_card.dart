import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_list.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_model.dart';

class FlipCardAndButton extends StatefulWidget {
  final int point;
  final Function(int) onCheck;
  FlipCardAndButton({
    super.key,
    required this.point,
    required this.onCheck,
  });

  @override
  State<FlipCardAndButton> createState() => _FlipCardAndButtonState();
}

class _FlipCardAndButtonState extends State<FlipCardAndButton> {
  List<String> guessNumber = ['Smaller Number', 'Greater Number', 'Equal'];
  List<CardModel> card1 = [];
  List<CardModel> card2 = [];
  @override
  void initState() {
    card1.addAll(CardList().cardlist);
    card2.addAll(CardList().cardlist);
    card1.shuffle();
    card2.shuffle();
    super.initState();
  }

  void onCheck(String s) {
    switch (s) {
      case 'Smaller Number':
        if (card1[0].number < card2[0].number) {
          widget.onCheck(1);
        } else {
          widget.onCheck(-1);
        }
        break;
      case 'Greater Number':
        if (card1[0].number > card2[0].number) {
          widget.onCheck(1);
        } else {
          widget.onCheck(-1);
        }
        break;
      case 'Equal':
        if (card1[0].number == card2[0].number) {
          widget.onCheck(1);
        } else {
          widget.onCheck(-1);
        }
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double high = size.height;
    double width = size.width;
    return Center(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width * 0.4,
              height: high * 0.3,
              child: Image.asset(
                card1[0].image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: width * 0.4,
              height: high * 0.3,
              child: Image.asset(
                card2[0].image,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        SizedBox(
          height: high * 0.15,
          child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: guessNumber.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 175, 12, 0),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    onCheck(guessNumber[index]);
                    setState(() {});
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    guessNumber[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }),
        )
      ],
    ));
  }
}
