class Robot {
  PVector position, velocity;
  color col;
  float Zk;
  int dir;

  // COSTRUTTORE ////////////////////////////////////////////////////////////////////////
  Robot(int index){
    position = new PVector(random(width), random(height));
    velocity = new PVector(2, 2);
    
    switch (index) {
      case 0:
        col = color(255, 0, 0);
        break;
      case 1:
        col = color(0, 255, 0);
        break;
      case 2:
        col = color(0, 0, 255);
        break;
      case 3:
        col = color(255);
        break;
      default:
        col = color(random(255), random(255), random(255));
    }
    
    Zk = random(0.2, 0.8);
    dir = (int)random(3);
  }
  
  // UPDATE /////////////////////////////////////////////////////////////////////////////
  void update() {
    
    if ((frameCount % 60) == 0) {
      Zk = random(1);
      if (Zk < 0.33) {
        dir = 1;
      } else if (Zk < 0.66) {
        dir = 0;
      } else {
        dir = 2;
      }
    }


    if (dir == 1) {
      // giro a DESTRA
      velocity.rotate( radians(2) );
    }  else if (dir == 2) {
      // giro a SINISTRA
      velocity.rotate( radians( -2) );
    } else if (dir == 0) {
      // nothing
    }

    position.add(velocity);

    if ( position.x<0 ) {
      velocity.x *= -1;
      position.x = 5;
    } else if (position.x > width) {
      velocity.x *= -1;
      position.x = width-5;
    }else if (position.y <0) {
      velocity.y *= -1;
      position.y = 5;
    } else if (position.y > height) {
      velocity.y *= -1;
      position.y = height-5;
    }
  }

  // DRAW ///////////////////////////////////////////////////////////////////////////////
  void draw() {
    pushStyle();
    stroke(col);
    strokeWeight(10);
    line(position.x, position.y, position.x-velocity.x, position.y-velocity.y);
    popStyle();
  }
}

