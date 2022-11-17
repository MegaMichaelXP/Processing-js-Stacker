public class BlockText extends BoardItem {
  
  protected String message;
  
  BlockText(int rowAt, int colAt, String message) {
    super(rowAt, colAt);
    this.message = message;
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    pushMatrix();
    fill(255);
    translate(xAt,yAt);
    textSize(20);
    //rectMode(CENTER);
    textAlign(CENTER,CENTER);
    text(message,0,0);
    popMatrix();
  }
  
}
