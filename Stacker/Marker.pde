public class Marker extends BoardItem {
  
  protected int direction;
  
  Marker(int rowAt, int colAt, int direction) {
    super(rowAt, colAt);
    this.direction = direction;
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    fill(0);
    noStroke();
    pushMatrix();
    translate(xAt,yAt);
    beginShape();
    if (direction == 0) {
      vertex(0,0);
      vertex(0,cellSize);
      vertex(cellSize/3,cellSize/2);
    } else if (direction == 1) {
      vertex(cellSize,0);
      vertex(cellSize,cellSize);
      vertex(cellSize - (cellSize/3),cellSize/2);
    }
    endShape();
    popMatrix();
  }
  
}
