public class Block extends BoardItem {
  
  Block(int rowAt, int colAt) {
    super(rowAt, colAt);
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    pushMatrix();
    fill(0,200,0);
    translate(xAt,yAt);
    rectMode(CORNER);
    rect(0,0,cellSize,cellSize);
    popMatrix();
  }

}
