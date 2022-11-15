public class BoardItem {
  
  protected int colId, rowId;
  protected int[][] glyphData;
  protected int fillColor;
  
  public BoardItem(int rowAt, int colAt) {
    this.rowId = rowAt;
    this.colId = colAt;
  }
  
  public void show(int xAt, int yAt, int cellSize) {
    strokeWeight(1);
    for(int row=0; row<glyphData.length; row++) {
      for(int col=0; col<glyphData[row].length; col++) {
        fillColor = glyphData[row][col];
        fill(fillColor);
        int x = xAt + col*cellSize;
        int y = yAt + row*cellSize;
        rect(x,y,cellSize,cellSize);
      }
    }
  }
  
  public void moveCol(int colShift) {
    colId += colShift;
  }
  
  public void moveRow(int rowShift) {
    rowId += rowShift;
  }
  
  public void updateCol(int newCol) {
    colId = newCol;
  }
  
  public void updateRow(int newRow) {
    rowId = newRow;
  }
  
  public void setData(int[][] data) {
    glyphData = data;
  }

  public int row() {return rowId;}
  public int col() {return colId;}
  
  
}
