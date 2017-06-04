PImage block1;
PImage block2;
PImage leftmario;
PImage rightmario;
PImage downrightmario;
PImage downleftmario;
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
String marioFacing = "right"; // where mario is looking, left or right
void setup() {
  size(1350,700); //16 kuber = linje genom skärmnen( 16 * 32 = 512)
  block1 = loadImage("block1.png");
  block2 = loadImage("block2.png");
  leftmario = loadImage("leftmario.png");
  rightmario = loadImage("rightmario.png");
  downrightmario = loadImage("downrightmario.png");
  downleftmario = loadImage("downleftmario.png");
  
}
void draw() {
  pushMatrix();
  background(255);
  XposList = new int[0];
  YposList = new int[0];
  if (isLeft) {
    if (marioFacing != "downleft" && marioFacing != "downright") {
      marioX+=mario_XSpeed * -1; 
      marioFacing = "left";
    } else { 
        marioFacing = "downleft";
        if (jumping)marioX+=mario_XSpeed * -1;
    }
  }
  if (isRight) {
    if (marioFacing != "downleft" && marioFacing != "downright") {
      marioX+=mario_XSpeed;
      marioFacing = "right";
    } else { 
        marioFacing = "downright";
        if (jumping)marioX+=mario_XSpeed;
    }
  }
  if (isDown) { 
    if (marioFacing == "right" || marioFacing == "downright") {
      marioFacing = "downright";
    } else marioFacing = "downleft";
    
  }
  if (isUp)if(!jumping)marioGravitySpeed = -24;
  
  
  translate(marioX * -1 + width/2,marioY * -1 + height/2);
  //image(block1,0,0,blockSizeX,blockSizeY);
  blocklineX(block1, 15, -16, 16);
  blocklineX(block2, 14, 4, 6);
  blocklineY(block2, 4, 8, 108);
  blocklineY(block2, 0, 10,20);
  marioGravitySpeed += 1;
  if (marioGravitySpeed > 16) {
    marioGravitySpeed = 16;
  }
  marioY += marioGravitySpeed;
  touchingDownBlocks();
  touchingLeftBlocks();
  touchingRightBlocks();
  if (marioFacing == "left")image(leftmario,marioX,marioY,marioSizeX,marioSizeY);
  else if(marioFacing == "right")image(rightmario,marioX,marioY,marioSizeX,marioSizeY);
  else if (marioFacing == "downright")image(downrightmario,marioX,marioY +10,marioSizeX,marioSizeY -10);
  else image(downleftmario,marioX,marioY +10,marioSizeX,marioSizeY -10);
  popMatrix();
  //text(marioFacing, 100,100); //draws what way you're looking
  fill(0);
}

void keyPressed() {
  setMove(keyCode, true);
}
void keyReleased() {
  if (marioGravitySpeed < -12)marioGravitySpeed=-12;
  if (marioFacing == "downright" || marioFacing == "downleft") {
    if (marioFacing == "downright")marioFacing = "right";
    else marioFacing = "left";
  }
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