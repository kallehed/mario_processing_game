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
PImage marioleftwalk;
PImage mariorightwalk;
PImage mariojumpleft;
PImage mariojumpright;
PImage mariofallleft;
PImage mariofallright;

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
int marioWalkSprite = 0;
int marioX = 0;
int marioY = 0;
int marioSizeX = 32;
int marioSizeY = 40;
float marioGravitySpeed = 0;
boolean isLeft, isRight, isUp, isDown;
boolean jumping = true;
float mario_XSpeed = 0;
float mario_XAcceleration = 4;
String marioFacing = "right"; // where mario is looking, left or right
float GravityAcceleration = 1;

float JumpSpeed = -18;
boolean walkedleft = false;
boolean walkedright = true;
void setup() {
  size(512, 512); //16 kuber = linje genom skärmnen( 16 * 32 = 512)
  frameRate(60);
  jumpsound = new SoundFile(this, "mario_jump.wav");
  
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
  marioleftwalk = loadImage("marioleftwalk.png");
  mariorightwalk = loadImage("mariorightwalk.png");
  mariojumpright = loadImage("mariojumpright.png");
  mariojumpleft = loadImage("mariojumpleft.png");
  mariofallleft = loadImage("mariofallleft.png");
  mariofallright = loadImage("mariofallright.png");
  
  forest_back = loadImage("forest_back.png");
  
  
  create_enemy("koopa", 13, -4, -1);
  create_enemy("koopa", 13, 1,2);
}
void draw() {
  background(255);
  pushMatrix();
  
  
  XposList = new int[0];
  YposList = new int[0];

  if (isLeft) {
    walkedleft = true;
    if (marioFacing == "fallingleft" || marioFacing == "fallingright") {
      marioFacing = "fallingleft";
      mario_XSpeed=mario_XAcceleration * -1;
    
    } else if (marioFacing == "jumpingleft" || marioFacing == "jumpingright") {
      marioFacing = "jumpingleft";
      mario_XSpeed=mario_XAcceleration * -1;
    
    } else if (marioFacing != "downleft" && marioFacing != "downright") {
      mario_XSpeed=mario_XAcceleration * -1; 
      marioFacing = "left";
    } else {
      if (marioFacing == "downleft") {
        marioFacing = "downleft";
      } else marioFacing = "downright";
    }
  } else walkedleft = false;
  if (isRight) {
    walkedright = true;
    if (marioFacing == "fallingleft" || marioFacing == "fallingright") {
      marioFacing = "fallingright";
      mario_XSpeed=mario_XAcceleration;
    } else if (marioFacing == "jumpingleft" || marioFacing == "jumpingright") {
      marioFacing = "jumpingright";
      mario_XSpeed=mario_XAcceleration;
      
    } else if (marioFacing != "downleft" && marioFacing != "downright") {
      mario_XSpeed=mario_XAcceleration;
      marioFacing = "right";
    } else { 
      if (marioFacing == "downleft") {
        marioFacing = "downleft";
      } else marioFacing = "downright";
      
    }
  } else walkedright = false;
  if (isDown) { 
    if (marioFacing == "right" || marioFacing == "downright") {
      marioFacing = "downright";
    } else marioFacing = "downleft";
  }
  if (isUp)if (marioFacing != "downleft" && marioFacing != "downright")if (!jumping)if (marioGravitySpeed > -10) {
    marioGravitySpeed = JumpSpeed;
    if(marioFacing == "left")marioFacing = "jumpingleft";
    if(marioFacing == "right")marioFacing = "jumpingright";
    jumpsound.play(0.5);
  }
  if (marioFacing == "jumpingleft" || marioFacing == "jumpingright") {
    if (marioGravitySpeed > 0) {
      if (marioFacing == "jumpingleft") {
        marioFacing = "fallingleft";
      } else marioFacing = "fallingright";
    }
  }
  if (!walkedleft && !walkedright)mario_XSpeed = 0;

  if (marioFacing == "downleft" || marioFacing == "downright") {
    if(jumping)marioX += mario_XSpeed;
  
  } else if (marioFacing != "downleft" && marioFacing != "downright")marioX += mario_XSpeed;
  
  translate(marioX * -1 + width/2, marioY * -1 + height/2);
  draw_background("forest");
  
  blocklineX(block1, 15, -16, 16);
  blocklineX(block2, 14, 4, 6);
  blocklineX(block2, 10, 0,7);
  blocklineY(block2, 4, 18, 108);
  blocklineY(block2, 0, 16, 20);
  draw_enemy();
  //////////////////////////// does all the gravity jump stuff
  marioGravitySpeed += GravityAcceleration;
  if (marioGravitySpeed > GravityAcceleration*16) {
    marioGravitySpeed = GravityAcceleration*16;
  }
  marioY += marioGravitySpeed; // moves mario up or down
  //////////////////////////////
  touchingDownBlocks();

  if (walkedleft)touchingLeftBlocks();
  if (walkedright)touchingRightBlocks();
  
  drawMario();
  
  popMatrix();
  move_en();
  //text(marioFacing, 100,100); //draws what way you're looking
  //String str = String.valueOf(jumping);
  //text(str, 100, 100);
  text(mario_XSpeed, 100, 100);
  //fill(0);
  //if (mario_XSpeed > 0)mario_XSpeed -=mario_XAcceleration/2;
  //if (mario_XSpeed < 0)mario_XSpeed +=mario_XAcceleration/2;
  if (!jumping) {
    print(marioFacing);
    if (marioFacing == "jumpingleft" || marioFacing == "jumpingright" || marioFacing == "fallingleft" || marioFacing == "fallingright") {
      print("da");
      if (marioFacing == "jumpingleft") {
        marioFacing = "left";
      } else if (marioFacing == "jumpingright") {
        marioFacing = "right";
      } else if (marioFacing == "fallingleft") {
        marioFacing = "left";
      } else if (marioFacing == "fallingright") {
        marioFacing = "right";
      }
    }
  }
}
void drawMario() {
  if (marioFacing == "fallingright") {
    image(mariofallright, marioX, marioY + -8, marioSizeX, marioSizeY);
  } else if (marioFacing == "fallingleft") {
    image(mariofallleft, marioX, marioY + -8, marioSizeX, marioSizeY);
  } else if (marioFacing == "jumpingright") {
    image(mariojumpright, marioX, marioY + -8, marioSizeX, marioSizeY);
  } else if (marioFacing == "jumpingleft") {
    image(mariojumpleft, marioX, marioY + -8, marioSizeX, marioSizeY);
  } else if (marioFacing == "left") {
    if (walkedleft) {
      if (marioWalkSprite < 5) {
        image(leftmario, marioX, marioY + -8, marioSizeX, marioSizeY);
        marioWalkSprite += 1;
      } else {
        image(marioleftwalk, marioX, marioY + -10, marioSizeX, marioSizeY);
        marioWalkSprite += 1;
      }
    } else {
      image(leftmario, marioX, marioY + -8, marioSizeX, marioSizeY);
    }
  } else if (marioFacing == "right") {
    if (walkedright) {
      if (marioWalkSprite < 5) {
        image(rightmario, marioX, marioY + -8, marioSizeX, marioSizeY);
        marioWalkSprite += 1;
      } else {
        image(mariorightwalk, marioX, marioY + -10, marioSizeX, marioSizeY);
        marioWalkSprite += 1;
      }
    } else {
      image(rightmario, marioX, marioY + -8, marioSizeX, marioSizeY);
    }
  }
  if (marioFacing == "downright")image(downrightmario, marioX, marioY +10 -8, marioSizeX, marioSizeY -10);
  if (marioFacing == "downleft")image(downleftmario, marioX, marioY +10 -8, marioSizeX, marioSizeY -10);
  if (marioWalkSprite > 9)marioWalkSprite = 0;
}
void draw_background(String back) {
  if (back == "forest") {
    imageMode(CENTER);
    image(forest_back, marioX * 0.8, marioY * 0.8, width * 2, height * 2);
    image(forest_back, marioX * 0.8 + width*2, marioY * 0.8, width * 2, height * 2);
    image(forest_back, marioX * 0.8 - width*2, marioY * 0.8, width * 2, height * 2);
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
  imageMode(CORNER);
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
  en_YposList = append(en_YposList, y * blockSizeY + 16);
  en_endXposList = append(en_endXposList, x2 * blockSizeX);
  en_spriteList = append(en_spriteList, 1);
  en_XposList = append(en_XposList, x * blockSizeX);
  if (x2 > x)en_facingList = append(en_facingList, "left");
  else en_facingList = append(en_facingList, "right");

  
}
void touchingRightBlocks() {

  int index = 0;
  for (int i : XposList) {

    index += 1;
    if (marioX + blockSizeX>= i && i + blockSizeX >= marioX + blockSizeX) { //

      if (YposList[index-1] <= marioY + blockSizeY - 1 && YposList[index-1] + blockSizeY >= marioY) {
        marioX += mario_XSpeed * -1;
        println("los");
      }
    }
  }
}
void touchingLeftBlocks() {

  int index = 0;
  for (int i : XposList) {

    index += 1;
    if (marioX >= i && i + blockSizeX >= marioX) { // works
       //( marios bottom is UNDER the blocks top)  (Marios top is ABOVE the blocks bottom)
      if (YposList[index-1] < marioY + blockSizeY && YposList[index-1] + blockSizeY > marioY) {
        //if () {
        marioX += mario_XSpeed * -1;
        println("das");
      }
    }
  }
}
void touchingDownBlocks() { //Detects gravity, if touch block, go up
  int index = 0;
  for (int i : XposList) {
    index += 1;
    if (marioX + blockSizeX -1 >= i && i + blockSizeX -1 >= marioX) {
      //( marios bottom is UNDER the blocks top)  (Marios bottom is ABOVE the blocks bottom)
      if (YposList[index -1] < marioY + blockSizeY && marioY + blockSizeY < YposList[index -1] + blockSizeY * 2) {
        if (marioY > YposList[index-1] + 0) {
          jumping = true;
          marioY += marioGravitySpeed * -1;
          marioGravitySpeed = 0;
        } else {
          marioY += marioGravitySpeed * -1;
          marioGravitySpeed = 0;
        
          jumping = false;
          //println("jum");
          break;
        }
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