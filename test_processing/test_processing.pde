import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int NUM_ROBOTS = 4;
Robot[] robots;

int stato = 0;
boolean bCrociera = false;
boolean bMedia = false;

// SETUP //////////////////////////////////////////////////////////////////////////////
void setup() {
  smooth();
  size(400,400);
  background(0);
  frameRate(30);
  strokeWeight(4);
  strokeJoin(ROUND);
  
  /* start oscP5, listening for incoming messages at port 11000 */
  oscP5 = new OscP5(this, 11000);
  
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  robots = new Robot[NUM_ROBOTS];
  for(int i = 0; i < NUM_ROBOTS; i++) {
    robots[i]= new Robot(i);
  }
}


// DRAW ///////////////////////////////////////////////////////////////////////////////
void draw() {
  
  pushStyle();
  fill(0, 50);
  stroke(0, 50);
  rect(0, 0, width, height);
  popStyle();
//  noStroke();
//  fill(0,5);
//  rect(0,0,width,height);
  
  for(int i = 0; i < NUM_ROBOTS; i++) {
    robots[i].update();
  }
  
  for(int i = 0; i < NUM_ROBOTS; i++) {
    switch(stato) {
      case 1:
        robots[0].draw();
        break;
      case 2:
        robots[1].draw();
        break;
      case 3:
        robots[2].draw();
        break;
      case 4:
        robots[3].draw();
        break;
      default:
        robots[i].draw();
    }
    
    if ((frameCount % 10) == 0) { // mando messaggi ogni 10 frame
      OscMessage msgPos = new OscMessage("/robots/robot" + i + "/pos");
      OscMessage msgVel = new OscMessage("/robots/robot" + i + "/vel");
      OscMessage msgDir = new OscMessage("/robots/robot" + i + "/dir");
      
      int posx = (int)robots[i].position.x;
      int posy = (int)robots[i].position.y;
      msgPos.add(new int[] {posx, posy});
      oscP5.send(msgPos, myRemoteLocation);
      
      int velx = (int)robots[i].velocity.x;
      int vely = (int)robots[i].velocity.y;
      msgVel.add(new int[] {velx, vely});
      oscP5.send(msgVel, myRemoteLocation);
      
      msgDir.add(robots[i].dir);
      oscP5.send(msgDir, myRemoteLocation);
    }
  }
  
  if( bCrociera) {
    pushStyle();
    stroke(255, 0, 0);
    strokeWeight(1);
    line(width/2, 0, width/2, height);
    line(0, height/2, width, height/2);
    popStyle();
  }
  
  if(bMedia) {
    float xtot = 0;
    float ytot = 0;
    for(int i = 0; i < NUM_ROBOTS; i++) {
      xtot += robots[i].position.x;
      ytot += robots[i].position.y;
    }
    xtot /= 4;
    ytot /= 4;
    pushStyle();
    stroke(255, 255, 0);
    noFill();
    strokeWeight(3);
    //ellipse(xtot, ytot, 25, 25);
    line(xtot - 10, ytot, xtot + 10, ytot);
    line(xtot, ytot - 10, xtot, ytot + 10);
    popStyle();    
  }
  
}

// KEY PRESSED ////////////////////////////////////////////////////////////////////////
void keyPressed() {
  switch( key ) {
    case '1':
      stato = 1;
      break;
    case '2':
      stato = 2;
      break;
    case '3':
      stato = 3;
      break;
    case '4':
      stato = 4;
      break;
    case 'c':
      // mostra la crociera
      bCrociera = !bCrociera;
      break;
    case 'm':
      // mostra la media dell posizioni
      bMedia = !bMedia;
      break;
    default:
      bMedia = false;
      bCrociera = false;
      stato = 0;
    
  }
}

