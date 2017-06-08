import processing.sound.*;

SoundFile coinsound;
SoundFile kicksound;
SoundFile jumpsound;
SoundFile deathsound;
PImage koopaleft, koopaleftwalk, kooparight, kooparightwalk;
PImage block1;
PImage block2;
PImage luckyblock;
PImage coin;
PImage faceblock;
PImage noneblock;
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
PImage mariodead;

int[] luckyY = {};
int[] luckyX = {};
int[] luckGotItem = {};
int marioDieY = 0; // what Y is the lava? // chosen in setup, sorry!
int marioDeadFail = 0;
int marioDeadX = 0;
int marioDeadY = 0;
int blockSizeX = 32;
int blockSizeY = 32;
int[] DcoinX = {};
int[] DcoinY = {};
int[] DcoinTime = {};
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

int coinSizeX = 24;
int coinSizeY = 32;
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
int shakeBlockX = 5245224;
int shakeBlockY = 5264673;

float JumpSpeed = -18;
boolean jumped = false;
boolean walkedleft = false;
boolean walkedright = true;
boolean marioDead = false;

int blackoutAlpha = 0;
void setup() {
  size(512, 512); //16 kuber = linje genom skärmnen( 16 * 32 = 512)
  frameRate(60);
  jumpsound = new SoundFile(this, "mario_jump.wav");
  deathsound = new SoundFile(this, "mario_death.wav");
  kicksound = new SoundFile(this, "mario_kick.wav");
  coinsound = new SoundFile(this, "get_coin.wav");
  
  block1 = loadImage("block1.png");
  block2 = loadImage("block2.png");
  luckyblock = loadImage("lucky_block.png");
  noneblock = loadImage("none_block.png");
  coin = loadImage("coin.png");
  faceblock = loadImage("face_block.png");
  
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
  mariodead = loadImage("mariodead.png");
  
  marioDieY = height;
  
  forest_back = loadImage("forest_back.png");
  
  createLucky(4,9);
  createLucky(0,9);
  create_enemy("koopa", 13, -4, -1);
  create_enemy("koopa", 13, 1,4);
 
}
void draw() {
  

  background(255);
  pushMatrix();
  
  
  XposList = new int[0];
  YposList = new int[0];
  if (!marioDead)checktheway();
  
  
  if (!marioDead)translate(marioX * -1 + width/2, marioY * -1 + height/2);
  if (marioDead)translate(marioDeadX * -1 + width/2, marioDeadY * -1 + height/2);
  draw_background("forest");
  //DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS
  blocklineX(faceblock, 15, -16, 16);

  //DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS
  
  drawLucky();
  drawDCoins();
  draw_enemy();

  
  if (marioDead) {
    if (marioDeadFail == 1333777777) {
      popMatrix();
      blackScreen();
    } else {

      image(mariodead, marioX, marioY + -8, marioSizeX, marioSizeY);
  
      if (marioDeadFail > 10)marioDeadFail = 0;
      if (marioDeadFail > 1) {
        marioDeadFail += 1;
      } else {
        if (marioY < marioDeadY + -100) {
          marioDeadFail = 1;
        }
        if (marioDeadFail == 1) {
          marioY += 9;
          if (marioY > marioDeadY + height/3 * 2) { 
            
            marioDeadFail = 1333777777;
          }
        } else {
          marioY += -8;
        }
      }
      popMatrix();
    }
  } else {
    touchEnemy(); // checks if you touch an enemy
    /////////////////////////////////////////////// does all the gravity jump stuff
    marioGravitySpeed += GravityAcceleration;
    if (marioGravitySpeed > GravityAcceleration*16) {
      marioGravitySpeed = GravityAcceleration*16;
    }
    marioY += marioGravitySpeed; // moves mario up or down
    DieOfYLimit(); // checks if under limit
    ////////////////////////////////////////////////////////////////////////////
    touchingDownBlocks();
    
  
    if (walkedleft)touchingLeftBlocks();
    if (walkedright)touchingRightBlocks();
    
    drawMario();
    
    popMatrix();
    move_en();
    //text(marioFacing, 100,100); //draws what way you're looking
    //String str = String.valueOf(jumping);
    //text(str, 100, 100);
    //text(mario_XSpeed, 100, 100);
    //fill(0);

    if (!jumping) {
      
      if (marioFacing == "jumpingleft" || marioFacing == "jumpingright" || marioFacing == "fallingleft" || marioFacing == "fallingright") {
        
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
}
void enemyDIE(int enemy) {
  marioGravitySpeed = JumpSpeed;
  en_List[enemy] = "dead";
  kicksound.play(0.5);
  
}
void DieOfYLimit() {
  if (marioY > marioDieY) {
    DIE();
  }
}
void DIE() {
  deathsound.play(0.5);
  
  marioDead = true;
  marioDeadY = marioY;
  marioDeadX = marioX;
  marioDeadFail = 2;
}
  
void touchEnemy() {
  
  int index = 0;
  for (int i : en_XposList) {
    index +=1;
    if(en_List[index-1] == "dead") {
    } else {
      if(i == 3); // remove the "local variable i isnt used" thing
      
      
      if (marioX  + marioSizeX> en_XposList[index-1] && marioX < en_XposList[index-1] + marioSizeX) {
         //  marios feet   under koopa top  and   mario top over koopafeet
        if (marioY + marioSizeY > en_YposList[index-1] && marioY < en_YposList[index-1] + marioSizeY) {
          if (marioY + marioSizeY < en_YposList[index-1] + 17) {
            enemyDIE(index-1);
          } else {
            DIE();
          }
        }
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
    if (!marioDead) {
      imageMode(CENTER);
      image(forest_back, marioX * 0.8, marioY * 0.8, width * 2, height * 2);
      image(forest_back, marioX * 0.8 + width*2, marioY * 0.8, width * 2, height * 2);
      image(forest_back, marioX * 0.8 - width*2, marioY * 0.8, width * 2, height * 2);
      imageMode(CORNER);
    } else {
      imageMode(CENTER);
      image(forest_back, marioDeadX * 0.8, marioDeadY * 0.8, width * 2, height * 2);
      image(forest_back, marioDeadX * 0.8 + width*2, marioDeadY * 0.8, width * 2, height * 2);
      image(forest_back, marioDeadX * 0.8 - width*2, marioDeadY * 0.8, width * 2, height * 2);
      imageMode(CORNER);
    }
  } 
}
void keyPressed() {
  setMove(keyCode, true);
}
void keyReleased() {
  if (keyCode == UP) {
    jumped = false;
  }
  if (keyCode == UP) {
    if (marioGravitySpeed < JumpSpeed/2)marioGravitySpeed=+JumpSpeed/2;
  }
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
    if(i == "hejsan"); //remove i isnt used error
    index +=1;
    if(en_List[index-1] == "dead") {
      en_YposList[index-1] += 5;
      en_XposList[index-1] += random(-5,5);
    } else {
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
}
void draw_enemy() {
  imageMode(CORNER);
  int index = 0;
  for (String i : en_List) {
    //print(i);
    index +=1;
    if (en_List[index-1] == "deads") {
    } else {
      if(i == "hefaijd"); //removes error with i 
      
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
        //println("los");
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
        //println("das");
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
        if (marioY > YposList[index-1] + 0) { // hit a roof
          jumping = true;
          marioY += marioGravitySpeed * -1;
          checkiflucky(XposList[index-1], YposList[index-1]);
          marioGravitySpeed = 0;
        } else { // hit rock bottom(ground)
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
void checktheway() {
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
  if (isUp)if (marioFacing != "downleft" && marioFacing != "downright")if (!jumping)if (marioGravitySpeed > -10)if (!jumped) {
    marioGravitySpeed = JumpSpeed;
    jumped = true;
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
  

}
void blackScreen() {
  if (blackoutAlpha > 255)noLoop();
  imageMode(CORNER);

  fill(0,blackoutAlpha);
    
  rect(0,0,width,height);
    
  blackoutAlpha += 8;
  //println(blackoutAlpha);
  
}
void createLucky(int X,int Y) {
  luckyX = append(luckyX, X * blockSizeX);
  luckyY = append(luckyY, Y * blockSizeY);
  luckGotItem = append(luckGotItem, 1);
  DcoinX = append(DcoinX, X * blockSizeX);
  DcoinY = append(DcoinY, Y * blockSizeY);
  DcoinTime = append(DcoinTime, 0);
}
void drawLucky() {
  int index = 0;
  for (int i : luckyX) {
    XposList = append(XposList, i);
    YposList = append(YposList, luckyY[index]);
    if (i == shakeBlockX && luckyY[index] == shakeBlockY) { //shakes the block when hit
      //print("lora!");
      if (luckGotItem[index] == 1) { // block has items
          image(luckyblock, i, luckyY[index] + -10, blockSizeX, blockSizeY);
      } else { // block does not have items
          image(noneblock, i, luckyY[index] + -10, blockSizeX, blockSizeY);
      }
      shakeBlockY = 2374293;
      shakeBlockX = 2425882;
      
    } else {
      if (luckGotItem[index] == 1) { // block has items
        image(luckyblock, i, luckyY[index], blockSizeX, blockSizeY);
      } else { // block does not have items
        image(noneblock, i, luckyY[index], blockSizeX, blockSizeY);
      }
    }
    index+=1;
  }
}
void checkiflucky(int X, int Y) {
  int index = 0;
  for (int i : luckyX) {
    if (i == X && luckyY[index] == Y) { // the roof Mo hit is a actually lucky block!!
      shakeBlockX = X;
      shakeBlockY = Y;
      if (luckGotItem[index] == 1) { // the block has items in it!!
        DcoinTime[index] = 1;
        luckGotItem[index] = 0;
        coinsound.play(0.5);
      }
      
    }
    index += 1;
  }
}
void drawDCoins() {
  int index = 0;
  //print("pala");
  for (int i : DcoinX) {
    //print("sala");
    if (DcoinTime[index] > 0) { // a coin!
      //print("hejsan!");
      image(coin, i + 4, DcoinY[index] - blockSizeY, coinSizeX, coinSizeY);
      DcoinY[index] += -2;
      DcoinTime[index] += 1;
    }
    if (DcoinTime[index] > 20) {
      DcoinTime[index] = 0;
    }
    index +=1;
  }
}