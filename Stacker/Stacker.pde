Board theBoard;

int[] mouseCoords;

int points = 0;
int wager = 1;

boolean spacePressed = false;
boolean zPressed = false;

String statusText;

void setup() {
  size(800,600);
  theBoard = new Board((width/2)-200,20,15,7,32);
}

void draw() {
  background(120);
  theBoard.show();
  if (theBoard.readyToReset()) {
    setup();
  }
  switch (theBoard.status()) {
    case -1:
      statusText = "Press space to play";
      break;
    case 0:
      statusText = "Game over";
      break;
    case 2:
      statusText = "Minor prize";
      break;
    case 3:
      statusText = "Major prize";
      break;
    default:
      statusText = "";
      break;
  }
  textSize(48);
  textAlign(CENTER);
  fill(0);
  text(statusText, (width/2), 550);
  text("$" + points, 600, 200);
}

void mousePressed() {
  
}

void keyPressed() {
  if (key == ' ' && !spacePressed) {
    if (theBoard.status() == 1) {
      theBoard.placeBlocks();
    } else if (theBoard.status() == -1) {
      points -= wager;
      theBoard.startGame();
    } else if (theBoard.status() == 2) {
      theBoard.continueGame();
    } else if (theBoard.status() == 0) {
      setup();
    }
    spacePressed = true;
  } else if (key == 'z' && !zPressed) {
    if (theBoard.status() == 2) {
      points += (wager * 2);
      setup();
    } else if (theBoard.status() == 3) {
      points += (wager * 5);
      setup();
    }
  }
}

void keyReleased() {
  if (key == ' ') {
    spacePressed = false;
  } else if (key == 'z') {
    zPressed = false;
  }
}
