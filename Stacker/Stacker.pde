Board theBoard;

int[] mouseCoords;

int points = 0;
int wager = 1;

boolean spacePressed = false;
boolean zPressed = false;

String statusText;

void setup() {
  size(800,600);
  theBoard = new Board((width/2)-300,20,15,7,32);
}

void draw() {
  background(120);
  theBoard.show();
  if (theBoard.readyToReset()) {
    setup();
  }
  if (theBoard.status() == -1) {
    if (wager == 0) {
      statusText = "Place a wager";
    } else {
      statusText = "Press space to play";
    }
  } else {
    statusText = "";
  }
  textSize(48);
  textAlign(CENTER,CENTER);
  fill(0);
  text(statusText, (width/2), 550);
  textSize(56);
  if (points < 0) {
    fill(180,0,0);
  }
  text("$" + points, 560, 150);
  textSize(30);
  fill(0);
  text("Wager: $" + wager, 560, 350);
  rectMode(CENTER);
  fill(0);
  rect(450,300,100,50);
  fill(255);
  text("+1",450,300);
  fill(0);
  rect(450,400,100,50);
  fill(255);
  text("-1",450,400);
  fill(0);
  rect(560,300,100,50);
  fill(255);
  text("+10",560,300);
  fill(0);
  rect(560,400,100,50);
  fill(255);
  text("-10",560,400);
  fill(0);
  rect(670,300,100,50);
  fill(255);
  text("+100",670,300);
  fill(0);
  rect(670,400,100,50);
  fill(255);
  text("-100",670,400);
}

void mousePressed() {
  if (theBoard.status() == -1) {
    if (mouseX >= 400 && mouseX <= 500) {
      if (mouseY >= 275 && mouseY <= 325) {
        if (wager + 1 >= 1000) {
          wager = 1000;
        } else {
          wager++;
        }
      }
    }
    if (mouseX >= 400 && mouseX <= 500) {
      if (mouseY >= 375 && mouseY <= 425) {
        if (wager - 1 <= 0) {
          wager = 0;
        } else {
          wager--;
        }
      }
    }
    if (mouseX >= 510 && mouseX <= 610) {
      if (mouseY >= 275 && mouseY <= 325) {
        if (wager + 10 >= 1000) {
          wager = 1000;
        } else {
          wager += 10;
        }
      }
    }
    if (mouseX >= 510 && mouseX <= 610) {
      if (mouseY >= 375 && mouseY <= 425) {
        if (wager - 10 <= 0) {
          wager = 0;
        } else {
          wager -= 10;
        }
      }
    }
    if (mouseX >= 620 && mouseX <= 720) {
      if (mouseY >= 275 && mouseY <= 325) {
        if (wager + 100 >= 1000) {
          wager = 1000;
        } else {
          wager += 100;
        }
      }
    }
    if (mouseX >= 620 && mouseX <= 720) {
      if (mouseY >= 375 && mouseY <= 425) {
        if (wager - 100 <= 0) {
          wager = 0;
        } else {
          wager -= 100;
        }
      }
    }
  }
}

void keyPressed() {
  if (key == ' ' && !spacePressed) {
    if (theBoard.status() == 1) {
      theBoard.placeBlocks();
    } else if (theBoard.status() == -1 && wager > 0) {
      points -= wager;
      theBoard.startGame();
    } else if (theBoard.status() == 2) {
      theBoard.continueGame();
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
