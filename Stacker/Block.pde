public class Block extends BoardItem {
  
  protected boolean active;
  
  Block(int rowAt, int colAt) {
    super(rowAt, colAt);
    active = true;
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    if (active) {
      pushMatrix();
      fill(0,200,0);
      translate(xAt,yAt);
      rectMode(CORNER);
      rect(0,0,cellSize,cellSize);
      popMatrix();
    }
  }
  
  public void toggle() {
    if (active) {
      active = false;
    } else {
      active = true;
    }
  }

}
