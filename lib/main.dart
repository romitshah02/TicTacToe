import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TicTacToe(),
  ));
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  var xplayer = 0;
  var oplayer = 0;
  List<String> boxContent = ["", "", "", "", "", "", "", "", ""];
  var xTurn = true;
  var filledCount = 0;
  var interval = false;

  var scoreStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);

  onTap(int index) {
    if (xTurn && boxContent[index] == "" && filledCount < 9) {
      setState(() {
        boxContent[index] = "X";
        filledCount++;
      });
    } else if (!xTurn && boxContent[index] == "" && filledCount < 9) {
      setState(() {
        boxContent[index] = "O";
        filledCount++;
      });
    }

    xTurn = !xTurn;

    checkBox();
  }

  checkBox() {
    if (filledCount > 0) {
      //check Rows
      if (boxContent[0] == boxContent[1] &&
          boxContent[0] == boxContent[2] &&
          boxContent[0] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[0]} Won'),
          ),
        );
        clearBox(boxContent[0]);
      }

      if (boxContent[3] == boxContent[4] &&
          boxContent[3] == boxContent[5] &&
          boxContent[3] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[3]} Won'),
          ),
        );
        clearBox(boxContent[3]);
      }

      if (boxContent[6] == boxContent[7] &&
          boxContent[6] == boxContent[8] &&
          boxContent[6] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[6]} Won'),
          ),
        );
        clearBox(boxContent[6]);
      }

      //check Columns
      if (boxContent[0] == boxContent[3] &&
          boxContent[0] == boxContent[6] &&
          boxContent[0] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[0]} Won'),
          ),
        );
        clearBox(boxContent[0]);
      }

      if (boxContent[1] == boxContent[4] &&
          boxContent[1] == boxContent[7] &&
          boxContent[1] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[1]} Won'),
          ),
        );
        clearBox(boxContent[1]);
      }

      if (boxContent[2] == boxContent[5] &&
          boxContent[2] == boxContent[8] &&
          boxContent[2] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[2]} Won'),
          ),
        );
        clearBox(boxContent[2]);
      }

      //check Diagonal

      if (boxContent[0] == boxContent[4] &&
          boxContent[0] == boxContent[8] &&
          boxContent[0] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[0]} Won'),
          ),
        );
        clearBox(boxContent[0]);
      }

      if (boxContent[2] == boxContent[4] &&
          boxContent[2] == boxContent[6] &&
          boxContent[2] != "") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Player ${boxContent[2]} Won'),
          ),
        );
        clearBox(boxContent[2]);
      }
    }
  }

  clearBox(String winner) async {
    setState(() {
      interval = true;
    });
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      boxContent = ["", "", "", "", "", "", "", "", ""];
      filledCount = 0;
      xTurn = true;
      interval = false;
    });
    if (winner == "X") {
      setState(() {
        xplayer++;
      });
    } else if (winner == "O") {
      setState(() {
        oplayer++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 77, 75, 75),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Player X   :   $xplayer',
                    style: xTurn
                        ? scoreStyle.copyWith(
                            color: const Color.fromARGB(255, 255, 195, 14))
                        : scoreStyle),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Player O   :   $oplayer',
                  style: xTurn
                      ? scoreStyle
                      : scoreStyle.copyWith(
                          color: const Color.fromARGB(255, 255, 195, 14)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: interval
                        ? () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Wait')));
                          }
                        : () {
                            onTap(index);
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                          child: Text(
                        boxContent[index],
                        style: scoreStyle.copyWith(fontSize: 30),
                      )),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ElevatedButton(
              onPressed: () {
                clearBox('');
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(10)),
              child: const Text(
                'Clear Board',
              ),
            ),
          )
        ],
      ),
    );
  }
}
