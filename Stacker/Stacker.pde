Board theBoard;

int[] mouseCoords;

boolean spacePressed = false;
boolean cPressed = false;

void setup() {
  size(800,600);
  theBoard = new Board((width/2)-140,20,15,7,32);
}

void draw() {
  background(120);
  theBoard.show();
}

void mousePressed() {
  
}

void keyPressed() {
  if (key == ' ' && !spacePressed) {
    if (theBoard.status() == 1) {
      theBoard.placeBlocks();
    } else if (theBoard.status() == 0) {
      setup();
    }
    spacePressed = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    spacePressed = false;
  } else if (key == 'r') {
    //rPressed = false;
  }
}
