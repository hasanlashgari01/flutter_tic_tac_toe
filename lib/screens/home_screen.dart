import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurn0 = true;
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreO = 0;
  int scoreX = 0;
  String winnerTitle = '';
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text('TicTacToe'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              resetGame();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          getScoreBoard(),
          gameHasResult ? getResultButton() : SizedBox(height: 20),
          SizedBox(height: 20),
          getGridView(),
          SizedBox(height: 20),
          getTurn(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player 0',
                  style: TextStyle(
                    color: isTurn0 ? Colors.green : Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${scoreO}',
                  style: TextStyle(
                    color: isTurn0 ? Colors.green : Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(
                    color: !isTurn0 ? Colors.green : Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${scoreX}',
                  style: TextStyle(
                    color: !isTurn0 ? Colors.green : Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Text(
                xOrOList[index],
                style: TextStyle(
                  fontSize: 40,
                  color: xOrOList[index] == 'O' ? Colors.red : Colors.blue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getResultButton() {
    return Column(
      children: [
        Text(
          winnerTitle,
          style: TextStyle(
            color: filledBoxes == 9 ? Colors.white : Colors.green,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: filledBoxes == 9 ? Colors.white : Colors.green,
            foregroundColor: filledBoxes == 9 ? Colors.black : Colors.white,
            side: BorderSide(
              color: filledBoxes == 9 ? Colors.white : Colors.green,
              width: 2,
            ),
          ),
          onPressed: () => nextLevel(),
          child: Text(
            'Go next',
          ),
        ),
      ],
    );
  }

  Widget getTurn() {
    return Text(
      isTurn0 ? 'Turn 0' : 'Turn X',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    
    if (xOrOList[index] != '') {
      return;
    }

    setState(() {
      if (isTurn0) {
        xOrOList[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        xOrOList[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }

      isTurn0 = !isTurn0;

      checkWinner();
    });
  }

  void checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[0]}');
      return;
    }

    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[3], 'Winner is ${xOrOList[3]}');
      return;
    }

    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[6], 'Winner is ${xOrOList[6]}');
      return;
    }

    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[0]}');
      return;
    }

    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[1], 'Winner is ${xOrOList[1]}');
      return;
    }

    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'Winner is ${xOrOList[2]}');
      return;
    }

    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ${xOrOList[0]}');
      return;
    }

    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'Winner is ${xOrOList[2]}');
      return;
    }

    if (filledBoxes == 9) {
      setResult('', 'Game is Draw');
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;

      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == 'O') {
        scoreO = scoreO + 1;
      } else {
        scoreX = scoreX;
        scoreO = scoreO;
      }

      winnerTitle = title;
    });
  }

  void nextLevel() {
    setState(() {
      isTurn0 = true;
      filledBoxes = 0;
      gameHasResult = false;
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
  }

  void resetGame() {
    setState(() {
      isTurn0 = true;
      filledBoxes = 0;
      gameHasResult = false;
      scoreX = 0;
      scoreO = 0;
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
  }
}
