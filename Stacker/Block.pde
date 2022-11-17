public class Block extends BoardItem {
  
  protected boolean active;
  
  Block(int rowAt, int colAt, boolean active) {
    super(rowAt, colAt);
    this.active = active;
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    pushMatrix();
    if (active) {
      fill(0,200,0);
    } else {
      fill(0,60,0);
    }
    translate(xAt,yAt);
    rectMode(CORNER);
    rect(0,0,cellSize,cellSize);
    popMatrix();
  }
  
  public void toggle() {
    if (active) {
      active = false;
    } else {
      active = true;
    }
  }

}
