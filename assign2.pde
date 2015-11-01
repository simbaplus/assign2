final int GAME_START = 0; //<>//
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_OVER = 3;

int gameState;

PImage startUnHover,startHover;
PImage endUnHover,endHover;


PImage shipImage,treasureImage,enemyImage,hp;
PImage backgroundImage,backgroundImage2;

int enemyPosX,enemyPosY;
int treasurePosX,treasurePosY;
int shipCurrentPosX,shipCurrentPosY;
int blood;

int backgroundPos1=width;//存放背景當前位置
int backgroundPos2=0;
void setup () {
  
  size(640,480);
  
  //開始圖片切換
  startHover=loadImage("img/start1.png");
  startUnHover=loadImage("img/start2.png");
  
  //結束圖片切換
  endUnHover=loadImage("img/end1.png");
  endHover=loadImage("img/end2.png");
  
  
  //載入物品
  treasureImage= loadImage("img/treasure.png");
  shipImage = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  enemyImage=loadImage("img/enemy.png");
  //載入背景
  backgroundImage = loadImage("img/bg1.png");
  backgroundImage2 = loadImage("img/bg2.png");
  
  //寶物隨機位置
  treasurePosX=floor(random(width-61));
  treasurePosY=floor(random(height-61));
  
  //敵機初始位置
  enemyPosX = 0;
  enemyPosY = 350;
  //主角初始位置
  shipCurrentPosX=width-65;
  shipCurrentPosY=height/2;
  blood=40;//initialize blood 先假定100
  
  gameState= GAME_START;//預設讀取開始畫面
   
   
}

void draw() {
 
  switch (gameState){
      case GAME_START:
      image(startUnHover,0,0);
       
      // mouse action
      if (mouseY > 370 && mouseY < 410 && mouseX > 200 && mouseX < 460){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
        }else{
          // hover
          image(startHover,0,0);
          
        }
      }
      break;
    

      case GAME_RUN:
  
        //背景移動效果
        image(backgroundImage,backgroundPos1%(width*2)-width,0);
        image(backgroundImage2,backgroundPos2%(width*2)-width,0);
        
        //紅色血條
        rect(15,15,blood,25);
        fill(255,30,0);
        //物品位置
        image(hp,10,10);
        image(enemyImage,enemyPosX%width,enemyPosY);
        image(treasureImage,treasurePosX,treasurePosY);
        image(shipImage,shipCurrentPosX, shipCurrentPosY);
        
        //背景,敵機自動移動
        backgroundPos1++;
        backgroundPos2++;
        enemyPosX++;
        
        
        //敵機朝戰機飛
        if(enemyPosY-shipCurrentPosY>0){
          enemyPosY--;
        }
        if(enemyPosY-shipCurrentPosY<0){
          enemyPosY++;

        }
       // println(enemyPosY);
      
      //顯示戰機,寶物當前座標
        //println(shipCurrentPosX+","+shipCurrentPosY);
        //println(treasurePosX+","+treasurePosY);
        //println(enemyPosX%width+","+enemyPosY);
        
      //吃寶物效果
        if( abs(shipCurrentPosX-treasurePosX)<30 && abs(shipCurrentPosY-treasurePosY) <30 ){//要'=='不然判斷式不成立
         if(blood+20<=200){//血量加20(10%)不破表才執行
             blood+=20;//加血10%           
            
            }
      //移動寶物位置
             treasurePosX=floor(random(width-61));
             treasurePosY=floor(random(height-61));
        }
      //撞到戰機效果
        if( abs(shipCurrentPosX-enemyPosX%width)<30  && abs(shipCurrentPosY-enemyPosY) <30){
         if(blood>0){//血量減40(20%)還有生命才執行
             blood-=40;//扣血20%
           if(blood<=0){
           gameState = GAME_OVER;
           }
           else{  
       //移動敵機位置
             enemyPosX=0;
             enemyPosY=floor(random(height-61));
           }
         }

        }
        break;
        
        case GAME_OVER:
          image(endUnHover,0,0);
          if (mouseY > 300 && mouseY < 340 && mouseX > 200 && mouseX < 430){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
          
            //寶物隨機位置
            treasurePosX=floor(random(width-61));
            treasurePosY=floor(random(height-61));
            
            //敵機初始位置
            enemyPosX = 0;
            enemyPosY = 350;
            //主角初始位置
            shipCurrentPosX=width-65;
            shipCurrentPosY=height/2;
            blood=100;//initialize blood 先假定100
          
          
          
        }else{
          // hover
          image(endHover,0,0);
          
        }
      }
      break;

 }// end of switch 
}
void keyPressed(){
 // To make ship move faster,I adjust the dispacement to +-3
  //上下左右 及 加減圖片尺寸
  if (keyCode == UP&shipCurrentPosY>=0) {
    shipCurrentPosY-=3;

  }
   if (keyCode == DOWN&shipCurrentPosY<=height-61) {
    shipCurrentPosY+=3;
  }
   if (keyCode == LEFT&shipCurrentPosX>=0) {
    shipCurrentPosX-=3;
  }
   if (keyCode == RIGHT&shipCurrentPosX<=width-61) {
    shipCurrentPosX+=3;
  }  
}
void keyReleased(){

}
