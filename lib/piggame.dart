import 'dart:math';

class PigGame {

  int maxTurns = 12;
  int turnCount = 0;
  int dice1 = 0;
  int dice2 = 0;

  int firstRoll = 0;
  int runningTotal = 0;

  int playerOneBank = 0;
  int playerTwoBank = 0;

  int currentPlayer = 0;
  Random generator;

  PigGame() {
    generator = new Random();
    currentPlayer = 1;
  }

  /*
	 * Roll those piggies.
	 */
  void rollDice() {
    dice1 = generator.nextInt(6) + 1;
    dice2 = generator.nextInt(6) + 1;
  }

  /*
	 * Play the game Droid.
	 */
  void playTurnDroid() {
    int gap = playerOneBank - playerTwoBank;
    // IF AVOID=0 THEN Roll :RETURN
    if (firstRoll == 0) {
      playTurn();
    }
    else if (runningTotal > 100) {
      bank();
    }
    else if (gap > 50 && runningTotal > 24 && firstRoll > 4 && firstRoll < 9) {
      bank();
    }
    // IF Android score=0 AND Running Score>15 THEN BANK:RETURN
    else if (playerTwoBank == 0 && runningTotal > 25) {
      bank();
    }
    // IF Turn=MaxTurn AND (Android score+Running Score)>Player score THEN
    else if (turnCount == maxTurns &&
        (playerTwoBank + runningTotal) > playerOneBank) {
      bank();
    }
    // BANK:RETURN
    // IF Turn=MaxTurn AND Android score<=Player score THEN Roll :RETURN
    else if (turnCount <= maxTurns &&
        (playerTwoBank + runningTotal) <= playerOneBank) {
      playTurn();
    }
    // IF Running Score>(40+RND(30)) THEN BANK:RETURN
    else if (runningTotal > (45 + generator.nextInt(10))) {
      bank();
    }
    // IF AVOID<10 THEN Roll :RETURN
    else if (firstRoll > 9 || firstRoll < 5) {
      playTurn();
    }
    // IF AVOID>4 AND AVOID<10 THEN RT=RND(2):RETURN ELSE Roll :RETURN
    else if (firstRoll > 3 && firstRoll < 10) {
      if (generator.nextInt(3) == 2 || runningTotal < 20)
        playTurn();
      else
        bank();
    } else
      playTurn();
  }

  /*
	 * Play the game.
	 */
  void playTurn() {
    int diceTotal = -1;

    rollDice();
    diceTotal = dice1 + dice2;

    if (firstRoll == 0) {
      firstRoll = diceTotal;
    } else {
      if (firstRoll == diceTotal) {
        resetTurn();
        return;
      }
    }

    runningTotal += diceTotal;
  }

  void resetTurn() {
    // Set up for next play.
    runningTotal = 0;
    firstRoll = 0;

    // Switch Players.
    if (currentPlayer == 1)
      currentPlayer = 2;
    else
      currentPlayer = 1;

    // Count turns.
    turnCount++;
  }

  String info() {
    String outtemp = ""; // new Integer(Dice1).toString();
    // outtemp = "Turn : " + new Integer(TurnCount).toString() + "\n";
    // outtemp += "Roll : [";
    // outtemp += new Integer(Dice1).toString() + "] [";
    // outtemp += new Integer(Dice2).toString() + "]\n";
    // outtemp = "Avoid : " + new Integer(FirstRoll).toString() + "\n";
    // outtemp += "Total : " + new Integer(RunningTotal).toString() +
    // "\n";
    // outtemp += "Player One Bank : " + new
    // Integer(PlayerOneBank).toString() + "\n";
    // outtemp += "Player Two Bank : " + new
    // Integer(PlayerTwoBank).toString() + "\n";
    // outtemp += "Current Player : " + new
    // Integer(CurrentPlayer).toString() + "\n";

    return outtemp;
  }

  void bank() {
    if (currentPlayer == 1) {
      playerOneBank += runningTotal;
    } else {
      playerTwoBank += runningTotal;
    }

    resetTurn();
  }

}