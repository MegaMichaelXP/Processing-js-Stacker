public class Board {
  
  MovingBlocks moving;
  
  protected int x_pos, y_pos;
  protected int xAt, yAt;
  protected int cellSize;
  protected int rows, cols;
  protected int blockCount;
  protected int gameStatus;
  protected int fallInterval;
  protected int fallTime;
  protected int[][] layer;
  protected boolean blocksMoving;
  protected boolean fallAnimation;
  protected ArrayList<Block> blocks;
  protected ArrayList<Block> falling;
  
  public Board(int x, int y, int numRows, int numCols, int cellSize) {
    x_pos = x;
    y_pos = y;
    rows = numRows;
    cols = numCols;
    this.cellSize = cellSize;
    layer = null;
    blocks = new ArrayList<Block>();
    falling = new ArrayList<Block>();
    blocksMoving = true;
    fallAnimation = false;
    fallInterval = 100;
    gameStatus = 1;
    blockCount = 3;
    moving = new MovingBlocks(14, 3, blockCount, blockCount, 1, 100, 0, 6);
  }
  
  public void show() {
    pushMatrix();
    translate(x_pos,y_pos);
    for (int j=0; j<rows; j++) {
      for (int i=0; i<cols; i++) {
        xAt = i*cellSize;
        yAt = j*cellSize;
        strokeWeight(2);
        stroke(0);
        fill(0,60,0);
        rectMode(CORNER);
        rect(xAt,yAt,cellSize,cellSize);
        drawLayerCell(j,i,xAt,yAt);
      }
    }
    for (Block b: blocks) {
      xAt = b.col() * cellSize;
      yAt = b.row() * cellSize;
      b.show(xAt,yAt,cellSize);
    }
    if (falling.size() > 0 && !fallAnimation) {
      fallTime = millis();
      fallAnimation = true;
    }
    for (Block f: falling) {
      xAt = f.col() * cellSize;
      yAt = f.row() * cellSize;
      f.show(xAt,yAt,cellSize);
    }
    if (fallAnimation) {
      if (millis() - fallTime >= fallInterval) {
        for (int i = falling.size() - 1; i >= 0; i--) {
          Block f = falling.get(i);
          if ((blockAt((f.row() + 1), f.col())) || f.row() == rows - 1) {
            
          }
        }
      }
    }
    xAt = moving.col() * cellSize;
    yAt = moving.row() * cellSize;
    moving.show(xAt,yAt,cellSize);
    popMatrix();
  }
  
  protected void drawLayerCell(int rowId, int colId, int xPos, int yPos) {
    if (layer != null) {
      if (layer.length > rowId) {
        if (layer[rowId].length > colId) {
          int cellColor = layer[rowId][colId];
          fill(cellColor);
          rect(xPos,yPos,cellSize,cellSize);
        }
      }
    }
  }
  
  public void addLayer(int[][] theLayer) {
    this.layer = theLayer;
  }
  
  public Cell getCell(int xClicked, int yClicked) {
    xClicked -= x_pos;
    yClicked -= y_pos;
    int xAt = xClicked/cellSize;
    int yAt = yClicked/cellSize;
    
    return new Cell(yAt,xAt);
  }
  
  public int[] getCoords(int xClicked, int yClicked) {
    int[] coords = new int[2];
    xClicked -= x_pos;
    yClicked -= y_pos;
    coords[0] = yClicked/cellSize;
    coords[1] = xClicked/cellSize;
    return coords;
  }
  
  public int getRowId(int yClicked) {
    yClicked -= y_pos;
    int theRow = yClicked/cellSize;
    return theRow;
  }
  
  public int getColId(int xClicked) {
    xClicked -= x_pos;
    int theCol = xClicked/cellSize;
    return theCol;
  }
  
  public boolean blockAt(int row, int col) {
    for (Block b: blocks) {
      if (b.row() == row && b.col() == col) {
        return true;
      }
    }
    return false;
  }
  
  public void sleep(int wait) {
    int time = millis();
    boolean waiting = true;
    while (waiting) {
      if(millis() - time >= wait) {
        waiting = false;
      }
    }
  }
  
  public void toggle() {
    if (blocksMoving) {
      moving.stopBlocks();
      blocksMoving = false;
    } else {
      moving.startBlocks();
      blocksMoving = true;
    }
  }
  
  public void placeBlocks() {
    moving.stopBlocks();
    int[][] newBlocks = moving.getCoordinates();
    for (int i = 0; i < newBlocks.length; i++) {
      blocks.add(new Block(newBlocks[i][0], newBlocks[i][1]));
    }
    checkBlocks();
    if (gameStatus == 1) {
      moving.setBlockCount(blockCount);
      moving.next();
      moving.startBlocks();
    }
  }
  
  public void checkBlocks() {
    for (Block b: blocks) {
      if (!((blockAt((b.row() + 1), b.col())) || b.row() == rows - 1)) {
        blockCount--;
        if (blockCount == 0) {
          gameStatus = 0;
        }
      }
    }
    if (gameStatus == 1) {
      dropBlocks();
    }
  }
  
  public void dropBlocks() {
    for (int i = blocks.size() - 1; i >= 0; i--) {
      Block b = blocks.get(i);
      if (!((blockAt((b.row() + 1), b.col())) || b.row() == rows - 1)) {
        falling.add(b);
        blocks.remove(i);
      }
    }
  }
  
  public void continueGame() {
    
  }
  
  public int getRows() {return rows;}
  public int getCols() {return cols;}
}
