public class Board {
  
  MovingBlocks moving;
  Block finalBlock;
  Block collapseBlock;
  BlockText minor;
  BlockText major;
  
  protected int x_pos, y_pos;
  protected int xAt, yAt;
  protected int cellSize;
  protected int rows, cols;
  protected int blockCount;
  protected int gameStatus;
  protected int fallInterval;
  protected int flashInterval;
  protected int collapseInterval;
  protected int collapseTime;
  protected int flashes;
  protected int startFlash;
  protected int missed;
  protected int fallTime;
  protected int[][] layer;
  protected boolean blocksMoving;
  protected boolean flash;
  protected boolean fallAnimation;
  protected boolean flashingAnimation;
  protected boolean finalFlash;
  protected boolean resetReady;
  protected boolean collapse;
  protected boolean perfect1;
  protected boolean perfect2;
  protected ArrayList<Block> blocks;
  protected ArrayList<Block> finalBlocks;
  protected ArrayList<Block> falling;
  
  public Board(int x, int y, int numRows, int numCols, int cellSize) {
    x_pos = x;
    y_pos = y;
    rows = numRows;
    cols = numCols;
    this.cellSize = cellSize;
    layer = null;
    blocks = new ArrayList<Block>();
    finalBlocks = new ArrayList<Block>();
    falling = new ArrayList<Block>();
    blocksMoving = true;
    fallAnimation = false;
    flashingAnimation = false;
    collapse = false;
    perfect1 = false;
    perfect2 = false;
    flash = true;
    resetReady = false;
    fallInterval = 200;
    flashInterval = 200;
    collapseInterval = 30;
    gameStatus = -1;
    blockCount = 3;
    flashes = 0;
    missed = 0;
    moving = new MovingBlocks(14, 3, blockCount, blockCount, 1, 100, 0, 6);
    minor = new BlockText(4,3,"MINOR PRIZE");
    major = new BlockText(0,3,"MAJOR PRIZE");
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
    if (finalFlash && !collapse) {
      //finalBlock = blocks.get(blocks.size() - 1);
      if (millis() - startFlash >= flashInterval) {
        for (Block f: finalBlocks) {
          f.toggle();
        }
        startFlash = millis();
        flashes++;
        //finalBlock.toggle();
      }
      if (flashes == 7) {
        flashes = 0;
        finalFlash = false;
        collapseTime = millis();
        collapse = true;
      }
    }
    if (collapse) {
      gameStatus = 0;
      collapseBlock = blocks.get(0);
      if (millis() - collapseTime >= collapseInterval) {
        if (collapseBlock.row() == rows - 1) {
          blocks.remove(0);
          if (blocks.size() == 0) {
            collapse = false;
            resetReady = true;
          }
        } else {
          collapseBlock.moveRow(1);
        }
        collapseTime = millis();
      }
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
          if (falling.size() > 0) {
            Block f = falling.get(i);
            if ((blockAt((f.row() + 1), f.col())) || f.row() == rows - 1) {
              if (!flashingAnimation) {
                startFlash = millis();
                flashingAnimation = true;
              } else {
                if (millis() - startFlash >= flashInterval) {
                  for (Block g: falling) {
                    g.toggle();
                  }
                  startFlash = millis();
                  flashes++;
                }
                if (flashes == 7) {
                  falling.clear();
                  flashingAnimation = false;
                  flashes = 0;
                }
              }
            } else {
              f.moveRow(1);
            }
          }
        }
        fallTime = millis();
      }
    }
    if (fallAnimation && falling.size() == 0) {
      moving.startBlocks();
      fallAnimation = false;
    }
    xAt = moving.col() * cellSize;
    yAt = moving.row() * cellSize;
    moving.show(xAt,yAt,cellSize);
    xAt = (minor.col() * cellSize) + cellSize/2;
    yAt = (minor.row() * cellSize) + cellSize/2;
    minor.show(xAt,yAt,cellSize);
    xAt = (major.col() * cellSize) + cellSize/2;
    yAt = (major.row() * cellSize) + cellSize/2;
    major.show(xAt,yAt,cellSize);
    popMatrix();
    if (perfect1 && gameStatus == 1) {
      if (perfect2) {
        sleep(500);
        moving.startBlocks();
        perfect1 = false;
        perfect2 = false;
      } else {
        perfect2 = true;
      }
    }
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
  
  public void startGame() {
    gameStatus = 1;
    moving.startBlocks();
  }
  
  public void prizeClaim() {
    resetReady = true;
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
    blockCount = moving.getBlockCount();
    int[][] newBlocks = moving.getCoordinates();
    for (int i = 0; i < newBlocks.length; i++) {
      blocks.add(new Block(newBlocks[i][0], newBlocks[i][1]));
    }
    checkBlocks();
    if (gameStatus == 1) {
      moving.setBlockCount(blockCount);
      moving.next();
      if (falling.size() == 0 && !perfect1) {
        moving.startBlocks();
      }
    }
  }
  
  public void checkBlocks() {
    perfect1 = true;
    int[][] newBlocks = moving.getCoordinates();
    for (Block b: blocks) {
      if (!((blockAt((b.row() + 1), b.col())) || b.row() == rows - 1)) {
        blockCount--;
        missed++;
        perfect1 = false;
        if (blockCount == 0) {
          gameStatus = 0;
          startFlash = millis();
          for (int i = 0; i < missed; i++) {
            finalBlocks.add(blocks.get(blocks.size() - i - 1));
          }
          finalFlash = true;
        }
      } else {
        if (newBlocks[0][0] == 4) {
          gameStatus = 2;
        }
        if (newBlocks[0][0] == 0) {
          gameStatus = 3;
        }
      }
    }
    if (gameStatus == 1) {
      dropBlocks();
      missed = 0;
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
    moving.next();
    moving.startBlocks();
    perfect1 = false;
    gameStatus = 1;
  }
  
  public int status() {
    return gameStatus;
  }
  
  public boolean readyToReset() {
    return resetReady;
  }
  
  public int getRows() {return rows;}
  public int getCols() {return cols;}
}
