import processing.sound.*;

SoundFile jumpsound;
PImage koopaleft, koopaleftwalk, kooparight, kooparightwalk;
PImage block1;
PImage block2;
PImage leftmario;
PImage rightmario;
PImage downrightmario;
PImage downleftmario;
PImage forest_back;

int blockSizeX = 32;
int blockSizeY = 32;
int[] XposList = {};
int[] YposList = {};
int[] en_startXposList = {};
int[] en_YposList = {};
int[] en_endXposList = {};
int[] en_XposList = {};
int[] en_spriteList = {};
String[] en_facingList = {};
String[] en_List = {};
int en_speed = 1;

int blockNum = 0;
int marioX = 0;
int marioY = 0;
int marioSizeX = 32;
int marioSizeY = 40;
float marioGravitySpeed = 0;
boolean isLeft, isRight, isUp, isDown;
boolean jumping = true;
int mario_XSpeed = 4;
String marioFacing = "right"; // where mario is looking, left or right
float GravityAcceleration = 1;
float JumpSpeed = -24;
boolean walkedleft = false;
boolean walkedright = true;
void setup() {
  size(512, 512); //16 kuber = linje genom skärmnen( 16 * 32 = 512)
  frameRate(60);
  jumpsound = new SoundFile(this, "mario_jump.wav");
  jumpsound.play(0.5);
  block1 = loadImage("block1.png");
  block2 = loadImage("block2.png");
  leftmario = loadImage("leftmario.png");
  rightmario = loadImage("rightmario.png");
  downrightmario = loadImage("downrightmario.png");
  downleftmario = loadImage("downleftmario.png");
  koopaleft = loadImage("koopaleft.png");
  koopaleftwalk = loadImage("koopaleftwalk.png");
  kooparight = loadImage("kooparight.png");
  kooparightwalk = loadImage("kooparightwalk.png");
  
  forest_back = loadImage("forest_back.png");
  
  
  create_enemy("koopa", 10, 0, 8);
  create_enemy("koopa", 8, 0,6);
}
void draw() {
  background(255);
  pushMatrix();
  
  
  XposList = new int[0];
  YposList = new int[0];
  //en_XposList = new int[0];
  //en_YposList = new int[0];
  if (isLeft) {
    walkedleft = true;
    if (marioFacing != "downleft" && marioFacing != "downright") {
      marioX+=mario_XSpeed * -1; 
      marioFacing = "left";
    } else { 
      marioFacing = "downleft";
      if (jumping)marioX+=mario_XSpeed * -1;
    }
  } else walkedleft = false;
  if (isRight) {
    walkedright = true;
    if (marioFacing != "downleft" && marioFacing != "downright") {
      marioX+=mario_XSpeed;
      marioFacing = "right";
    } else { 
      marioFacing = "downright";
      if (jumping)marioX+=mario_XSpeed;
    }
  } else walkedright = false;
  if (isDown) { 
    if (marioFacing == "right" || marioFacing == "downright") {
      marioFacing = "downright";
    } else marioFacing = "downleft";
  }
  if (isUp)if (!jumping) {
    marioGravitySpeed = JumpSpeed;
    jumpsound.play(0.5);
  }

  translate(marioX * -1 + width/2, marioY * -1 + height/2);
  draw_background("forest");
  
  blocklineX(block1, 15, -16, 16);
  blocklineX(block2, 14, 4, 6);
  blocklineY(block2, 4, 8, 108);
  blocklineY(block2, 0, 10, 20);
  draw_enemy();

  marioGravitySpeed += GravityAcceleration;
  if (marioGravitySpeed > GravityAcceleration*16) {
    marioGravitySpeed = GravityAcceleration*16;
  }
  marioY += marioGravitySpeed;
  touchingDownBlocks();

  if (walkedleft)touchingLeftBlocks();
  if (walkedright)touchingRightBlocks();
  if (marioFacing == "left")image(leftmario, marioX, marioY + -8, marioSizeX, marioSizeY);
  else if (marioFacing == "right")image(rightmario, marioX, marioY -8, marioSizeX, marioSizeY);
  else if (marioFacing == "downright")image(downrightmario, marioX, marioY +10 -8, marioSizeX, marioSizeY -10);
  else image(downleftmario, marioX, marioY +10 -8, marioSizeX, marioSizeY -10);
  popMatrix();
  move_en();
  //text(marioFacing, 100,100); //draws what way you're looking
  //String str = String.valueOf(jumping);
  //text(str, 100, 100);
  //text(en_XposList[0], 100, 100);
  //fill(0);
}
void draw_background(String back) {
  if (back == "forest") {
    imageMode(CENTER);
    image(forest_back, 0, 0, width * 4, height * 4);
    imageMode(CORNER);
    
    
  }
  
}
void keyPressed() {
  setMove(keyCode, true);
}
void keyReleased() {
  if (marioGravitySpeed < JumpSpeed/2)marioGravitySpeed=+JumpSpeed/2;
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
void move_en() {
  int index = 0;
  for (String i : en_List) {
    index +=1;
    en_spriteList[index-1] += 1;
    if (en_spriteList[index-1] > 24)en_spriteList[index-1] = 0;
    
    if (en_startXposList[index-1] == en_XposList[index-1] || en_endXposList[index-1] == en_XposList[index-1]) {
      if (en_facingList[index-1] == "left")en_facingList[index-1] = "right";
      else en_facingList[index-1] = "left";
      //move time
    }
    if (en_facingList[index-1] == "left") {
      en_XposList[index-1] -= en_speed;
    } else {
      en_XposList[index-1] += en_speed;
    }
  }
}
void draw_enemy() {
  int index = 0;
  for (String i : en_List) {
    index +=1;
    if (en_facingList[index-1] == "left") {
      if (en_spriteList[index-1] > 12) {
        image(koopaleft, en_XposList[index -1], en_YposList[index -1], marioSizeX, marioSizeY + 10);
      } else {
        image(koopaleftwalk, en_XposList[index -1], en_YposList[index -1], marioSizeX, marioSizeY + 10);
      }
    } else {
      if (en_spriteList[index-1] > 12) {
        image(kooparight, en_XposList[index -1], en_YposList[index -1], marioSizeX, marioSizeY + 10);
      } else {
        image(kooparightwalk, en_XposList[index -1], en_YposList[index -1], marioSizeX, marioSizeY + 10);
      }
    }
  }
}
void create_enemy(String enemy, int y, int x, int x2) {
  //goes from x to x2 and then to x again...
  en_List = append(en_List, enemy);
  en_startXposList = append(en_startXposList, x * blockSizeX);
  en_YposList = append(en_YposList, y * blockSizeY);
  en_endXposList = append(en_endXposList, x2 * blockSizeX);
  en_spriteList = append(en_spriteList, 1);
  en_XposList = append(en_XposList, x * blockSizeX);
  if (x2 > x)en_facingList = append(en_facingList, "left");
  else en_facingList = append(en_facingList, "right");

  //en_facingList = append(en_facingList, facing);
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
void blocklineX(PImage block, int y, int x, int x2) {
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