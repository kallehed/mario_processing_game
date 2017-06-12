import processing.sound.*;

SoundFile pipesound;
SoundFile winsound;
SoundFile gatesound;
SoundFile overworldsong;
SoundFile coinsound;
SoundFile kicksound;
SoundFile jumpsound;
SoundFile deathsound;
PImage pipe1, pipe2;
PImage pipeB, pipeG, pipeR, pipeY; //blue,green,red,yellow
PImage pipeBtop,pipeGtop,pipeRtop,pipeYtop;
PImage goal, line;
PImage bush, bigbush, bushsmall;
PImage checkP1, checkP2, checkP3, checkP4;
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

PImage backforest;
PImage backmountains;
PImage backrock;

PImage marioleftwalk;
PImage mariorightwalk;
PImage mariojumpleft;
PImage mariojumpright;
PImage mariofallleft;
PImage mariofallright;
PImage mariodead;
PImage mariowin;

PImage background;

PImage[] warpBack = new PImage[0];
PImage[] warpBack2 = new PImage[0];
int[] warpListX = {};
int[] warpListY = {};
int[] warpListX2 = {};
int[] warpListY2 = {};
int lineTime = 0;
float checkTime = 0;
int[] en_Ospeed = {};
int musicTime = 0;
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

int backindex = 0;
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
boolean gateopened = false;
boolean WIN = false;
boolean warp = false;
int warpX = 0;
int warpY = 0;
int blackoutAlpha = 0;
int GoalY = 15;
int winTime = 0;
int warpTime = 0;
void setup() {
  size(512, 512); //16 kuber = linje genom skärmnen( 16 * 32 = 512)
  frameRate(60);
  jumpsound = new SoundFile(this, "mario_jump.wav");
  deathsound = new SoundFile(this, "mario_death.wav");
  kicksound = new SoundFile(this, "mario_kick.wav");
  coinsound = new SoundFile(this, "get_coin.wav");
  overworldsong = new SoundFile(this, "overworldsong.wav");
  gatesound = new SoundFile(this, "gatesound.wav");
  winsound = new SoundFile(this, "win.wav");
  pipesound = new SoundFile(this, "pipesound.wav");
  
  pipeB = loadImage("pipeB.png");
  pipeBtop = loadImage("pipeBtop.png");

  pipeG = loadImage("pipeG.png");
  pipeGtop = loadImage("pipeGtop.png");
  pipeR = loadImage("pipeR.png");
  pipeRtop = loadImage("pipeRtop.png");
  pipeY = loadImage("pipeY.png");
  pipeYtop = loadImage("pipeYtop.png");
  
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
  mariowin = loadImage("mariowin.png");
  
  bush = loadImage("bush.png");
  bigbush = loadImage("bigbush.png");
  bushsmall = loadImage("bushsmall.png");
  
  checkP1 = loadImage("flag1.png");
  checkP2 = loadImage("flag2.png");
  checkP3 = loadImage("flag3.png");
  checkP4 = loadImage("flag4.png");
  goal = loadImage("goal.png");
  line = loadImage("line.png");
  
  backforest = loadImage("backforest.png");
  backmountains = loadImage("backmountains.png");
  backrock = loadImage("backrock.png");
  
  createLucky(35,9);
  createLucky(37,9);
  createLucky(39,9);
  createLucky(50,11);
  createLucky(52,11);
  createLucky(155, 11);
  createLucky(157, 11);
  createLucky(159, 11);
  
  createLucky(189, -8);
  createLucky(191, -8);
  createLucky(193, -8);
  createLucky(208,10);
  //create_enemy("koopa", 13, -4, -1);
  

  create_enemy("koopa", 10, 31,20,1);
  create_enemy("koopa", 10, 20,31,1);
  create_enemy("koopa", 10, 25,31,1);
  create_enemy("koopa", 10, 31,25,1);
  create_enemy("koopa", 10, 20,26,1);
  create_enemy("koopa", 10, 26,20,1);
  create_enemy("koopa", 10, 23,31,1);
  create_enemy("koopa", 10, 31,23,1);
  create_enemy("koopa", 10, 23,29,1);
  create_enemy("koopa", 10, 29,23,1);
  create_enemy("koopa", 13, 70, 75,1);
  create_enemy("koopa", 13, 85, 90,1);
  create_enemy("koopa", 9, 110, 119,6);
  create_enemy("koopa", 14, 228, 240, 6);
  create_enemy("koopa", 14, 166, 182, 3);
  create_enemy("koopa",9,200,204, 2);
  create_enemy("koopa", 14, 218, 223, 1);
  
  
  
  overworldsong.loop(0.5);
  musicTime = 0;
  marioDieY = height * 3;
  setBack(backmountains);
 
}
void draw() {
  
 
  background(255);
  pushMatrix();
  
    
  
  XposList = new int[0];
  YposList = new int[0];
  warpListX = new int[0];
  warpListX2 = new int[0];
  warpListY = new int[0];
  warpListY2 = new int[0];
  if (!marioDead && !WIN && !warp)checktheway();
  
  
  if (!marioDead)translate(marioX * -1 + width/2, (marioY * -1 + height/2) + 50);
  if (marioDead)translate(marioDeadX * -1 + width/2, (marioDeadY * -1 + height/2) + 50);
  draw_background(background);
  scenery(bush,-1,14);
  scenery(bigbush,7,14);
  scenery(bushsmall,39,14);
  scenery(bush,64,14);
  scenery(bigbush,58,14);
  scenery(bushsmall,72,14);
  scenery(bushsmall,74,14);
  scenery(bigbush, 90, 14);
  scenery(bigbush,82,14);
  scenery(bush, 78,14);
  scenery(bushsmall,101,13);
  scenery(bigbush, 112,10);
  scenery(bush, 110, 10);
  scenery(bigbush,123,15);
  scenery(bigbush,157,15);
  scenery(bush,190,15);
  scenery(bigbush,219,15);
  scenery(bush,218,15);
  scenery(bigbush,235,15);
  scenery(bigbush, 228,15);
  scenery(bigbush,247,15);
  scenery(bush,245,15);
  
  drawGoal(253,GoalY);
  
  drawCheckP(134,13);
  //DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS
  
  blocklineX(block2, 15, -1, 100);

  blocklineX(block2, 12, 20, 32);
  blocklineX(block2, 11, 43, 48);
  blocklineX(block1, 12, 60, 61);
  
  blocklineX(block1, 14, 100, 104);
  blocklineX(block1, 13, 104, 108);
  blocklineX(block1, 12, 108, 110);
  blocklineX(block1, 11, 110, 120);
  blocklineY(block1, 120, 11, 16);
  blocklineX(block2, 16, 120, 204);
  blocklineX(block1, 13, 130, 131);
  //blocklineY(block1, 140, 13, 16);
  //blocklineY(block1, 141, 13, 16);
  //blocklineY(block1, 144, 12, 16);
  //blocklineY(block1, 145, 12, 16);
  blocklineX(block2, 12, 170, 174);
  blocklineX(block2, 12, 177, 182);
  blocklineX(block2, 9, 172, 179);
  blocklineX(faceblock, 7, 182,184);
  blocklineX(faceblock, 3, 187, 189);
  blocklineX(faceblock, -1, 183, 186); 
  blocklineX(faceblock, -5, 187, 196);
  blocklineX(block2, 11, 200, 206);
  blocklineY(block2, 204, 14, 17); 
  blocklineX(block2, 14,205, 215);
  blocklineY(block2, 215, 14, 18);
  blocklineY(block1, 218, 16,18);
  blocklineX(block1, 16, 219, 260);
  //blocklineY(block2, 226, 13, 16);
  //blocklineY(block2, 227, 13, 16);
  //blocklineY(block2, 241, 12, 16);
  //blocklineY(block2, 242, 12, 16);
  blocklineX(faceblock,35,63,80);
  //pipe(0,14,"green",6) X, Y, Color, Len, 
  if (warp)drawMario();
  pipe(64,14,"blue", 2);
  pipe(64,34,"blue",3);
  warphole(64,11,64,30, backforest, backmountains);
  pipe(78,34, "green", 3);
  pipe(96,14, "green",2);
  warphole(78,30,96,11, backmountains, backforest);
  pipe(140, 15, "red",2);
  pipe(144, 15, "yellow",3);
  pipe(226, 15, "yellow",3);
  pipe(241, 15, "green",3);
  
  
  //DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS//DRAW BLOCKS
  
  drawLucky();
  drawDCoins();
  draw_enemy();
  //println(mario_XSpeed);
  if (warp) {
    println(warpTime);
    if (warpTime == 90) {
      warp = false;
      warpTime = 0;
    } else if (warpTime > 60) {
      marioY+=-1;
      warpTime+=1;
    }
    else if (warpTime == 60) {
      marioX = warpX;
      marioY = warpY-30;
      warpTime += 1;
      setBack(warpBack[backindex]);
      pipesound.play(0.5);
    } else {
      marioY += 1;
      warpTime+=1;
    }
    popMatrix();
  } else if (WIN) {
    if (musicTime == 0) {
      overworldsong.stop();
      musicTime = 1;
    }
    
    if(marioFacing != "right"||marioFacing != "win")marioFacing = "right";
    if (winTime < 200)marioX +=1;
    if (marioY < GoalY * 32)marioY += 4;
    if (marioY > GoalY * 32)marioY += -4;
    if (winTime > 200)marioFacing = "win";
    drawMario();
    popMatrix();
    if(winTime > 250)blackScreen();
    winTime+=1;
    println(winTime);
  } else if (marioDead) {
    
    if (musicTime == 0) {
      overworldsong.stop();
      musicTime = 1;
    }
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
    checkWarp();
    
    
  
    if (walkedleft)touchingLeftBlocks();
    if (walkedright)touchingRightBlocks();
    
    drawMario();
    
    popMatrix();
    move_en();
    text("X " + marioX / 32 + "    Y " + marioY/32 , 100,100);
    
    //String str = String.valueOf(jumping);
    //text(str, 100, 100);
    //text(mario_XSpeed, 100, 100);
    //fill(0);
    
    if (mario_XSpeed > 4)mario_XSpeed = 4;
    if (mario_XSpeed <-4)mario_XSpeed = -4;
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
void setBack(PImage back) {
  background = back;
}
void checkWarp() {
  int X, Y, X2, Y2, index = 0;
  
  for (int i : warpListX) {
    
    
    X = warpListX[index];
    X2 = warpListX2[index];
    Y = warpListY[index];
    Y2 = warpListY2[index];
    i = i * 2; // blablablalblalb
//      pipe < marioX  | marioX < pipeend
    if (marioX >  X && X+blockSizeX*1 - 5> marioX&& isDown) { // marioX inside pipeX
      //print("alaldS!");
//       mario feet over warppoint// mariofeet under point+5    
      if (marioY + blockSizeY <= Y +32&& marioY+blockSizeY>Y-1) {
        print("sdjais");
        //WARP
        pipesound.play(0.5);
        warp = true;
        warpX = X2 + 10;
        warpY = Y2 + -5 + 32;
        backindex = index;
       
        
      }
    }
    if (marioX >  X2 && X2+blockSizeX*1 - 5> marioX&& isDown) { // marioX inside pipeX
      //print("alaldS!");
//       mario feet over warppoint// mariofeet under point+5    
      if (marioY + blockSizeY <= Y2 +32&& marioY+blockSizeY>Y2-1) {
        //print("sdjais");
        //WARP
        pipesound.play(0.5);
        warp = true;
        warpX = X + 10;
        warpY = Y + -5 +32;
        backindex = index;

      }
    }
    index+=1;
  }
  
}
void warphole(int X,int Y,int X2,int Y2, PImage back, PImage back2) {
  Y = 1+Y;
  Y2 +=1;
  warpBack = (PImage[])expand(warpBack,warpBack.length + 1);
  warpBack[warpBack.length-1] = back;
  warpBack2 = (PImage[])expand(warpBack2,warpBack2.length + 1);
  warpBack2[warpBack.length-1] = back2;
  warpListX = append(warpListX, X*blockSizeX);
  warpListY = append(warpListY, Y*blockSizeY);
  warpListX2 = append(warpListX2, X2*blockSizeX);
  warpListY2 = append(warpListY2, Y2*blockSizeY);
}
void pipe(int X,int Y,String Color, int len) {
  X = X * blockSizeX;
  Y = Y * blockSizeY;
  Y += 32;
  len = len-1;
  int index = 0;
  if (Color == "blue") {
    pipe1 = pipeB;
    pipe2 = pipeBtop;
  }
  if (Color == "green") {
    pipe1 = pipeG;
    pipe2 = pipeGtop;
  }
  if (Color == "red") {
    pipe1 = pipeR;
    pipe2 = pipeRtop;
  }
  if (Color == "yellow") {
    pipe1 = pipeY;
    pipe2 = pipeYtop;
  }
  while (index <= len) {
    index+=1;
    XposList = append(XposList, X);
    YposList = append(YposList, Y - index * blockSizeY);
    XposList = append(XposList, X + 28);
    YposList = append(YposList, Y - index*blockSizeY);
    image(pipe1, X,Y + index * -1 * blockSizeY,30 * 2,16 * 2);

      
      
  }
  index+=1;
  XposList = append(XposList, X);
  YposList = append(YposList, Y - index * blockSizeY);
  XposList = append(XposList, X + 28);
  YposList = append(YposList, Y - index*blockSizeY);
  image(pipe2,X -2,Y + index * -1 * blockSizeY,32*2,16*2);
}
void drawGoal(int X,int Y) {
  X = X * blockSizeX;
  Y = Y * blockSizeY;
  image(goal,X,Y - blockSizeY * 8);
  if (!WIN) {
    if (lineTime > blockSizeY*8)image(line, X + 17,15+Y + ((blockSizeY*8)-lineTime));
    else image(line, X + 17,15+Y + lineTime - blockSizeY * 8);
    lineTime += 2;
  }
  
  if (lineTime > blockSizeY * 16)lineTime = 0;
  if (marioX + blockSizeX > X && !WIN) { // YOU WIN!!
    winsound.play(0.5);
    WIN = true;
  }
}
void scenery(PImage img, int X,int Y) {

  X = X * blockSizeX;
  Y = Y * blockSizeY;
  if (img == bigbush)image(img, X,Y - blockSizeY * 4, 144 * 2,80 * 2);
  if (img == bush)image(img,X,Y - blockSizeY * 2, 95 * 2, 56 * 2);
  if (img == bushsmall)image(img,X,Y,32*2,16*2);
  //image(img, X,Y, *2, *2);
  
}
void drawCheckP(int X,int Y) {
  X = X * blockSizeX;
  Y = Y * blockSizeY;
  Y = Y - 20;
  if (checkTime < 1) {
    image(checkP1,X,Y, 64,128);
    checkTime += 0.2;
  } else if (checkTime < 2) {
    image(checkP2, X, Y, 64, 128);
    checkTime+=0.2;
  } else if (checkTime < 3) {
    image(checkP3, X, Y, 64, 128);
    checkTime+=0.2;
  } else if (checkTime < 4) {
    image(checkP4, X, Y, 64, 128);
    checkTime = 0;
  }
  //check if touch
  if (!gateopened) {
    if (marioX + marioSizeX > X && marioX < X + 64) { // mario X inside
      if (marioY + marioSizeY> Y && marioY < Y + 128) { // mario Y inside
        gatesound.play(0.5);
        gateopened = true;
      }
    }
  }
}
void enemyDIE(int enemy) {
  marioGravitySpeed = -10; // JUMP ON ENEMY
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
  if (marioFacing == "win") {
    image(mariowin, marioX, marioY + -10, 32, 44);
  } else if (marioFacing == "fallingright") {
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
void draw_background(PImage back) {
  
  if (!marioDead) {
    imageMode(CENTER);
    image(back, marioX * 0.8, (marioY + -150) * 0.8, width * 2, height * 2);
    image(back, marioX * 0.8 + 1024, (marioY+-150) * 0.8, width * 2, height * 2);
    image(back, marioX * 0.8 + 1024*2, (marioY+-150) * 0.8, width * 2, height * 2);
    imageMode(CORNER);
  } else {
    imageMode(CENTER);
    image(back, marioDeadX * 0.8, (marioDeadY+-150) * 0.8, width * 2, height * 2);
    image(back, marioDeadX * 0.8 + 1024, (marioDeadY+-150) * 0.8, width * 2, height * 2);
    image(back, marioDeadX * 0.8 + 1024*2, (marioDeadY+-150) * 0.8, width * 2, height * 2);
    imageMode(CORNER);
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
      if (en_spriteList[index-1] > 24)en_spriteList[index-1] = 0;//switches sprite
      
      if (en_startXposList[index-1] > en_endXposList[index-1]) { // makes it so the ones that start left dont crash
        if (en_startXposList[index-1] <= en_XposList[index-1] || en_endXposList[index-1] >= en_XposList[index-1]) {
          if (en_facingList[index-1] == "left")en_facingList[index-1] = "right";
          else en_facingList[index-1] = "left";
          //move time
        }
      } else {
        if (en_startXposList[index-1] >= en_XposList[index-1] || en_endXposList[index-1] <= en_XposList[index-1]) {
          if (en_facingList[index-1] == "left")en_facingList[index-1] = "right";
          else en_facingList[index-1] = "left";
          //move time
        }
      }
      
      
      if (en_facingList[index-1] == "left") {
        en_XposList[index-1] -= en_Ospeed[index-1];
      } else {
        en_XposList[index-1] += en_Ospeed[index-1];
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
void create_enemy(String enemy, int y, int x, int x2, int speed) {
  //goes from x to x2 and then to x again...


  en_Ospeed = append(en_Ospeed, speed);
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
        marioX += (mario_XSpeed * -1);
        mario_XSpeed = 0;
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
        mario_XSpeed = 0;
        //println("das");
      }
    }
  }
}
void touchingDownBlocks() { //Detects gravity, if touch block, go up
  int index = 0;
  for (int i : XposList) {
    index += 1;
    if (marioX + blockSizeX -5 >= i && i + blockSizeX -5 >= marioX) {
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
      mario_XSpeed+=-1;
    
    } else if (marioFacing == "jumpingleft" || marioFacing == "jumpingright") {
      marioFacing = "jumpingleft";
      mario_XSpeed+=-1;
    
    } else if (marioFacing != "downleft" && marioFacing != "downright") {
      mario_XSpeed+=-1; 
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
      mario_XSpeed+=1;
    } else if (marioFacing == "jumpingleft" || marioFacing == "jumpingright") {
      marioFacing = "jumpingright";
      mario_XSpeed+=1;
      
    } else if (marioFacing != "downleft" && marioFacing != "downright") {
      mario_XSpeed+=1;
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
    } else if (marioFacing == "left" || marioFacing == "downleft") {
      marioFacing = "downleft";
    } else if (marioFacing == "jumpingright") {
      marioFacing = "downright";
    } else if (marioFacing == "jumpingleft") {
      marioFacing = "downleft";
    } else if (marioFacing == "fallingright") {
      marioFacing = "downright";
    } else if (marioFacing == "fallingleft") {
      marioFacing = "downleft";
    }
    
    
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
  if (!walkedleft)if(mario_XSpeed < 0)mario_XSpeed += 1;
  if (!walkedright)if(mario_XSpeed > 0)mario_XSpeed += -1;

  if (marioFacing == "downleft" || marioFacing == "downright") {
    if(jumping)marioX += mario_XSpeed; // MOVES MARIO IF FLYING AND DOWN
  
  } else if (marioFacing != "downleft" && marioFacing != "downright")marioX += mario_XSpeed; // MOVES MARIO
  

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