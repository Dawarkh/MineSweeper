import 'package:flutter/material.dart';
import 'package:minesweeper/numbersbox.dart';

import 'bomb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables::
  int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;

// status of each state:: // [no. of bombs around, revealed or not => True/false]
  var squareStatus = [];
// status[indx][0] -> value and status[indx][1] -> revealed or not

// bomb Locations
  final List<int> bombLocations = [2, 4, 8, 15, 64, 39, 47, 56, 75, 80];

  bool bombRevealed = false;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

//restart Function
  void restartGame() {
    setState(() {
      bombRevealed = false;
      for (int i = 0; i < numberOfSquares; i++) {
        squareStatus[i][1] = false;
      }
    });
  }

//reveal function
  void revealBoxNumber(int index) {
    //reveal current box if number : 1 2 3 etc
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    }
    // if number =0 reveal the block
    else if (squareStatus[index][0] == 0) {
// reveal the curr bbox and surrounding boxes i.e 8 boxes
      setState(() {
        // curr box reveal
        squareStatus[index][1] = true;

        //1 left box unless not on left wall
        if (index % numberInEachRow != 0) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumber(index - 1);
          }
          squareStatus[index - 1][1] = true;
        }

        //2 top left box unless not on top row /left wall
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumber(index - 1 - numberInEachRow);
          }
          squareStatus[index - 1][1] = true;
        }
//3 top box unless not on top row
        if (index >= numberInEachRow) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumber(index - numberInEachRow);
          }
          squareStatus[index - numberInEachRow][1] = true;
        }
        //4 top right box unless not on top row or right wall
        if (index >= numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index + 1 - numberInEachRow][0] == 0 &&
              squareStatus[index + 1 - numberInEachRow][1] == false) {
            revealBoxNumber(index + 1 - numberInEachRow);
          }
          squareStatus[index + 1 - numberInEachRow][1] = true;
        }
//5 right box unless not on right wall
        if (index % numberInEachRow != numberInEachRow - 1) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumber(index + 1);
          }
          squareStatus[index + 1][1] = true;
        }
        // 6 bottom right box unless not on bottom row or right wall
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumber(index + 1 + numberInEachRow);
          }
          squareStatus[index + 1 + numberInEachRow][1] = true;
        }
        //7  bottom box unless not on bottom row
        if (index < numberOfSquares - numberInEachRow) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumber(index + numberInEachRow);
          }
          squareStatus[index + numberInEachRow][1] = true;
        }
        // 8 bottom left box unless not on bottom row or left wall
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != 0) {
          //if next box isnt reveled nad its a 0
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumber(index - 1 + numberInEachRow);
          }
          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

// number of bombs around a bomb
  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      int numberOfBombs = 0; // initially no bomb

      // check squares left, unless in first col
      if (bombLocations.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombs++;
      }

      // check squares top left, unless in the first row/col
      if (bombLocations.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombs++;
      }

      // check squares top, unless in the first row
      if (bombLocations.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombs++;
      }

      // check squares top right, unless in the first row/col
      if (bombLocations.contains(i + 1 - numberInEachRow) &&
          i >= numberInEachRow &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombs++;
      }

      // check squares right, unless in the last col
      if (bombLocations.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombs++;
      }

      // check squares bottom right, unless in the last col or row
      if (bombLocations.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombs++;
      }

      // check squares bottom left, unless in the last col
      if (bombLocations.contains(i - 1 + numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombs++;
      }
      // check squares bottom , unless in the last col
      if (bombLocations.contains(i + numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombs++;
      }

      // add total number of bombs:: squrae status
      setState(() {
        squareStatus[i][0] = numberOfBombs;
      });
    }
  }

// dialog for losing
  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: const Center(
                child: Text(
              "YOU LOST!",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              MaterialButton(
                color: Colors.grey[700],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Restart",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

// dialog for winning
  void playerWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: const Center(
                child: Text(
              "YOU WON!",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              MaterialButton(
                color: Colors.grey[700],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: const Center(
                    child: Icon(
                      Icons.refresh_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void checkWinner() {
    int unrevealed = 0;
    for (int i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealed++;
      }
    }
    if (unrevealed == bombLocations.length) {
      playerWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            //game stats and menu.
            Container(
              height: 150,
              //color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Denotes the number of Bombs
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bombLocations.length.toString(),
                        style: const TextStyle(fontSize: 40),
                      ),
                      const Text('B O M B'),
                    ],
                  ),
                  //Button to Reset the game:
                  IconButton(
                    onPressed: restartGame,
                    icon: const Icon(Icons.refresh),
                    splashColor: Colors.red,
                    splashRadius: 20,
                  ),
                  // Denotes Time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '0',
                        style: TextStyle(fontSize: 40),
                      ),
                      const Text('T I M E'),
                    ],
                  )
                ],
              ),
            ),

            // grid 9*9

            Expanded(
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numberInEachRow),
                  itemBuilder: (context, index) {
                    if (bombLocations.contains(index)) {
                      return Bomb(
                        reveal: bombRevealed,
                        function: () {
                          //user tapped on bomb , player losses
                          setState(() {
                            bombRevealed = true;
                          });
                          playerLost();
                        },
                      );
                    } else {
                      return NumberBox(
                        child: squareStatus[index][0],
                        reveal: squareStatus[index][1],
                        function: () {
                          //;user tapped on the box, reveal
                          revealBoxNumber(index);
                          checkWinner();
                        },
                      );
                    }
                  }),
            ),

            //branding
            const Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text(
                "C R E A T E D B Y D A W A R",
              ),
            ),
          ],
        ));
  }
}
