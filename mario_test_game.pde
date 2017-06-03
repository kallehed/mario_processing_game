PImage block1;
PImage block2;
PImage mario;
int worldX = 0;
int worldY = 0;
int blockSizeX = 32;
int blockSizeY = 32;
int[] XposList = {};
int[] YposList = {};
int blockNum = 0;
int marioX = 0;
int marioY = 0;
int marioSizeX = 32;
int marioSizeY = 32;
int marioGravitySpeed = 0;
boolean isLeft, isRight, isUp, isDown;
boolean jumping = true;
int mario_XSpeed = 4;
void setup() {
  size(1024,512); //16 kuber = linje genom skärmnen( 16 * 32 = 512)
  block1 = loadImage("block1.png");
  block2 = loadImage("block2.png");
  mario = loadImage("mario.png");
}
void draw() {
  background(255);
  XposList = new int[0];
  YposList = new int[0];
  if (isLeft) {
    marioX+=mario_XSpeed * -1; 
    
  }
  if (isRight) {
    marioX+=mario_XSpeed; 
    
  }
  if (isDown)marioY+=2;
  if (isUp)if(!jumping)marioY+=-400;
  
  
  translate(marioX * -1 + width/2,(marioY * -1) + height/2);
  //image(block1,0,0,blockSizeX,blockSizeY);
  blocklineX(block1, 15, -16, 16);
  blocklineX(block2, 14, 4, 6);
  blocklineY(block2, 4, 8, 108);
  marioGravitySpeed += 1;
  if (marioGravitySpeed > 16) {
    marioGravitySpeed = 16;
  }
  marioY += marioGravitySpeed;
  touchingDownBlocks();
  touchingLeftBlocks();
  touchingRightBlocks();
  image(mario,marioX,marioY,marioSizeX,marioSizeY);
  
}

void keyPressed() {
  setMove(keyCode, true);
}
void keyReleased() {
  setMove(keyCode, false);
}
boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
  case DOWN:
    return isDown = b;
  case LEFT:
    return isLeft = b;
  case RIGHT:
    return isRight = b;
  default:
    return b;
  }
}
void touchingRightBlocks() {
  
  int index = 0;
  for (int i : XposList) {
    
    index += 1;
    if (marioX + blockSizeX>= i && i + blockSizeX >= marioX + blockSizeX) { //
      
      if (YposList[index-1] <= marioY + blockSizeY - 1 && YposList[index-1] + blockSizeY >= marioY) {
        marioX += mario_XSpeed * -1;
        //print("los")
        
      }
    }
  }
}
void touchingLeftBlocks() {
  
  int index = 0;
  for (int i : XposList) {
    
    index += 1;
    if (marioX >= i && i + blockSizeX >= marioX) { // works
      
      if (YposList[index-1] <= marioY + blockSizeY - 1 && YposList[index-1] + blockSizeY >= marioY) {
        marioX += mario_XSpeed;
        //print("das");
        
      }
    }
  }
}
void touchingDownBlocks() { //Detects gravity, if touch block, go up
 int index = 0;
  for (int i : XposList) {
    index += 1;
    if (marioX + blockSizeX -1 >= i && i + blockSizeX -1 >= marioX) {
      if (YposList[index -1] + 1 <= marioY + blockSizeY && marioY + blockSizeY < YposList[index -1] + blockSizeY * 2) {
        marioY += marioGravitySpeed * -1;
        marioGravitySpeed = 0;
        jumping = false;
        break;
      } else jumping = true;
    } else jumping = true;
  }
}
void blocklineX(PImage block,int y,int x,int x2) {
  int time = 0;
  while (x2 - x != time) {
    
    XposList = append(XposList, (x + time) * blockSizeX);
    YposList = append(YposList, (y * blockSizeY));
    image(block, (x + time) * blockSizeX, y * blockSizeY, blockSizeX, blockSizeY);
    time += 1;
  }
}
void blocklineY(PImage block, int x, int y, int y2) {
  int time = 0;
  while (y2 - y != time) {
    
    YposList = append(YposList, (y + time) * blockSizeY);
    XposList = append(XposList, (x * blockSizeX));
    image(block, x * blockSizeX, (y + time) * blockSizeY, blockSizeX, blockSizeY);
    time += 1;
  }
}