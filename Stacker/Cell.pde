public class Cell {
  int row, col;
  
  public Cell(int row, int col) {
    this.row = row;
    this.col = col;
  }
  
  public int rowId() {return row;}
  
  public int colId() {return col;}
  
  public String toString() {
    return "row = " + row + ", col = " + col;
  }
  
}
