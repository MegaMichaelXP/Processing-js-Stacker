Board theBoard;

int[] mouseCoords;

boolean spacePressed;

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
    theBoard.placeBlocks();
    spacePressed = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    spacePressed = false;
  }
}
