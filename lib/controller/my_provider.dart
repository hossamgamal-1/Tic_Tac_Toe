import 'package:flutter/material.dart';
import '../view/game_screen.dart';
import 'dart:math';

class MyProvider with ChangeNotifier {
  /////////////////////////////////////////
  bool twoPlayerSwitch = false;
  twoPlayerSwitchLogic(bool newValue) {
    twoPlayerSwitch = newValue;
    notifyListeners();
  }

  /////////////////////////////////////////
  String currentPlayer = 'X';
  List<int> playerXIndex = [];
  List<int> playerOIndex = [];
  bool gameOver = false;
  ////////////////////////////////////////
  List<String> gridValues = [for (int i = 0; i < 9; i++) ''];
  gridClicked(index, context) {
    if (playerXIndex.contains(index) || playerOIndex.contains(index)) {
      return;
    }
    if (currentPlayer == 'X') {
      playerXIndex.add(index);
      gridValues[index] = 'X';
    } else {
      playerOIndex.add(index);
      gridValues[index] = 'O';
    }
    /*  print(playerXIndex);
    print(playerOIndex);
    print(gridValues); */
    checkWinner(context);
    if (!gameOver) currentPlayer = currentPlayer == 'X' ? 'O' : 'X';

    if (!twoPlayerSwitch && !gameOver) autoPlay(context);

    notifyListeners();
  }

/////////////////////////////////////
  checkWinner(context) {
    List x = [0, 3, 6];
    List y = [0, 1, 2];
    for (var i in x) {
      if (playerXIndex.containsThree(i, i + 1, i + 2)) {
        dialogMaker(context, 'X');
        gameOver = true;
        break;
      } else if (playerOIndex.containsThree(i, i + 1, i + 2)) {
        dialogMaker(context, 'O');
        gameOver = true;

        break;
      }
    }
    for (var i in y) {
      if (playerXIndex.containsThree(i, i + 3, i + 6)) {
        dialogMaker(context, 'X');
        gameOver = true;

        break;
      } else if (playerOIndex.containsThree(i, i + 3, i + 6)) {
        dialogMaker(context, 'O');
        gameOver = true;

        break;
      }
    }
    if (playerXIndex.containsThree(0, 4, 8) ||
        playerXIndex.containsThree(2, 4, 6)) {
      dialogMaker(context, 'X');
      gameOver = true;
    }
    if (playerOIndex.containsThree(0, 4, 8) ||
        playerOIndex.containsThree(2, 4, 6)) {
      dialogMaker(context, 'O');
      gameOver = true;
    }

    if (playerXIndex.length + playerOIndex.length == 9 && !gameOver) {
      dialogMaker(context, '');
      gameOver = true;
    }
    notifyListeners();
  }

////////////////////////////////////////////
  void repeat() {
    playerXIndex = [];
    playerOIndex = [];
    gridValues = [for (int i = 0; i < 9; i++) ''];
    currentPlayer = 'X';
    gameOver = false;
    notifyListeners();
  }

  autoPlay(context) {
    int autoIndex;
    for (;;) {
      autoIndex = Random().nextInt(9);
      if (playerXIndex.contains(autoIndex) ||
          playerOIndex.contains(autoIndex)) {
        continue;
      }
      currentPlayer == 'X'
          ? playerXIndex.add(autoIndex)
          : playerOIndex.add(autoIndex);
      break;
    }

    if (currentPlayer == 'X') {
      //playerXIndex.add(autoIndex);
      gridValues[autoIndex] = 'X';
    } else {
      //playerOIndex.add(autoIndex);
      gridValues[autoIndex] = 'O';
    }
    checkWinner(context);
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

extension ContainsThree on List {
  bool containsThree(x, y, z) {
    return (contains(x) && contains(y) && contains(z));
  }
}
