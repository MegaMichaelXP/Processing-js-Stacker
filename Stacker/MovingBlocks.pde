public class MovingBlocks extends BoardItem {
  
  protected int blockCount;
  protected int fullBlockCount;
  protected int leftBounds;
  protected int rightBounds;
  protected int direction;
  protected int speed;
  protected int time;
  protected boolean moving;
  
  MovingBlocks(int rowAt, int colAt, int blockCount, int fullBlockCount, int direction, int speed, int leftBounds, int rightBounds) {
    super(rowAt, colAt);
    this.blockCount = blockCount;
    this.fullBlockCount = fullBlockCount;
    this.direction = direction;
    this.speed = speed;
    this.leftBounds = leftBounds;
    this.rightBounds = rightBounds;
    moving = true;
    time = millis();
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    if (moving) {
      for (int i = 0; i < blockCount; i++) {
        pushMatrix();
        fill(0,200,0);
        translate(xAt + (cellSize * -direction * i),yAt);
        rectMode(CORNER);
        rect(0,0,cellSize,cellSize);
        popMatrix();
      }
    }
    if (millis() - time >= speed && moving) {
      if (direction == 1) {
        if (col() == rightBounds) {
          if (blockCount > 1) {
            blockCount--;
          } else {
            direction = -1;
            moveCol(-1);
            if (blockCount < fullBlockCount) {
              blockCount++;
            }
          }
        } else {
          moveCol(1);
          if (blockCount < fullBlockCount) {
            blockCount++;
          }
        }
      } else if (direction == -1) {
        if (col() == leftBounds) {
          if (blockCount > 1) {
            blockCount--;
          } else {
            direction = 1;
            moveCol(1);
            if (blockCount < fullBlockCount) {
              blockCount++;
            }
          }
        } else {
          moveCol(-1);
          if (blockCount < fullBlockCount) {
            blockCount++;
          }
        }
      }
      time = millis();
    }
  }
  
  public void stopBlocks() {
    moving = false;
  }
  
  public void startBlocks() {
    time = millis();
    moving = true;
  }
  
  public void next() {
    int newDirection = int(random(0,2));
    moveRow(-1);
    fullBlockCount = blockCount;
    updateCol(int(random(leftBounds, rightBounds + 1)));
    if (newDirection == 0) {
      direction = 1;
    } else {
      direction = -1;
    }
    if (direction == 1) {
      if ((col() - leftBounds) + 1 < fullBlockCount) {
        blockCount = (col() - leftBounds) + 1;
      }
      if (col() == rightBounds) {
        blockCount = int(random(1,(fullBlockCount + 1)));
      }
    } else if (direction == -1) {
      if ((rightBounds - col()) + 1 < fullBlockCount) {
        blockCount = (rightBounds - col()) + 1;
      }
      if (col() == leftBounds) {
        blockCount = int(random(1,(fullBlockCount + 1)));
      }
    }
  }
  
  public int[][] getCoordinates() {
    int[][] coords = new int[blockCount][2];
    for (int i = 0; i < blockCount; i++) {
      coords[i][0] = row();
      coords[i][1] = col() - (direction * i);
    }
    return coords;
  }
  
  public int getBlockCount() {
    return fullBlockCount;
  }
  
  public void setBlockCount(int newBlockCount) {
    fullBlockCount = newBlockCount;
    blockCount = newBlockCount;
  }

}
