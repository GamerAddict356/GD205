//https://openprocessing.org/sketch/346743
//Inspied by polybuis
//doesn't have enemy yet :(
Ship ssGlitter;
Stars[] glitter=new Stars[100];

void setup() {
  size(600, 600, P3D);
  background(0);

  for (int i=0; i<glitter.length; i++) {
    glitter[i]=new Stars(int(random(width)), int(random(height)), -500);
  }//end set stars

  ssGlitter=new Ship(width/2, height/2);
}//end setup()

void draw() {
  //not a whole lot to explain here
  background(0);
  lights();
  //camera is centered on the middle of the screen on 0 depth and focuses on the middle
  //of the screen 500 pixels deep with the y axis pointing up
  camera(width/2, height/2, 0, width/2, height/2, -500, 0, 1, 0);

  for (int i=0; i<glitter.length; i++) {
    glitter[i].update();
    glitter[i].display();
  }//end star move

  ssGlitter.update();
  ssGlitter.display();
}//end draw()

//pressing or releasing a key sets ssGlitter booleans
//to know when a key is held
void keyPressed() {
  if (key=='a' || key=='A') {
    ssGlitter.setLeft(true);
  }
  if (key=='d' || key=='D') {
    ssGlitter.setRight(true);
  }
  if (key=='w' || key=='W') {
    ssGlitter.setUp(true);
  }
  if (key=='s' || key=='S') {
    ssGlitter.setDown(true);
  }
}//end keyPressed()

void keyReleased() {
  if (key=='a' || key=='A') {
    ssGlitter.setLeft(false);
  }
  if (key=='d' || key=='D') {
    ssGlitter.setRight(false);
  }
  if (key=='w' || key=='W') {
    ssGlitter.setUp(false);
  }
  if (key=='s' || key=='S') {
    ssGlitter.setDown(false);
  }
}//end keyReleased()
class Ship {
  float centerRot;
  float xPos, yPos;
  float xRot, yRot;

  boolean left, right, up, down;

  Ship(float tx, float ty) {
    xPos=tx;
    yPos=ty;

    left=false;
    right=false;
    up=false;
    down=false;
  }//end constructor

  void update() {
    //whenever a boolean is true, the rotation of the ship eases into the turn at 30 degrees
    if (left) {
      xRot+=(30-xRot)*.05;
      xPos--;
    }//end left
    if (right) {
      xRot+=(-30-xRot)*.05;
      xPos++;
    }//end right
    if (up) {
      yRot+=(-30-yRot)*.05;
      yPos--;
    }//end up
    if (down) {
      yRot+=(30-yRot)*.05;
      yPos++;
    }//end down
    
    //if neither boolean on an axis is true, the rotation eases back to 0 degrees
    if (!left && !right) {
      xRot+=(0-xRot)*.05;
    }//end horizontal flat
    if (!up && !down) {
      yRot+=(0-yRot)*.05;
    }//end vertical flat

    //keeps ship in frame
    xPos=constrain(xPos, 240, 360);
    yPos=constrain(yPos, 210, 390);
  }//end update()

  void display() {
    pushMatrix();

    strokeWeight(5);
    strokeCap(PROJECT);
    translate(xPos, yPos, -200);//translates whole ship

    //i drew the ship on the x y axis, so it would be top down facing right
    //these rotations set it to a backview facing in
    rotateY(radians(90));
    rotateX(radians(90));

    //these rotations are for when the ship is moving
    rotateX(radians(xRot));
    rotateY(radians(yRot));

    //center piece
    pushMatrix();
    //center piece rotates for aesthetics
    rotateX(radians(centerRot+=5));
    stroke(255, 0, 255);
    line(12.5, 0, 0, -12.5, -12.5, 0);
    line(-12.5, -12.5, 0, -37.5, 0, 0);
    line(-37.5, 0, 0, -12.5, 12.5, 0);
    line(-12.5, 12.5, 0, 12.5, 0, 0);

    line(12.5, 0, 0, -12.5, 0, 10);
    line(-12.5, 0, 10, -37.5, 0, 0);
    line(12.5, 0, 0, -12.5, 0, -10);
    line(-12.5, 0, -10, -37.5, 0, 0);
    popMatrix();

    //left wing
    stroke(255, 0, 0);
    line(37.5, -12.5, 0, 12.5, -25, 0);
    line(12.5, -25, 0, -25, -37.5, 0);
    line(-25, -37.5, 0, -37.5, -12.5, 0);
    line(-37.5, -12.5, 0, -12.5, -18.75, 0);
    line(-12.5, -18.75, 0, 37.5, -12.5, 0);

    line(37.5, -12.5, 0, 12.5, -18.75, 5);
    line(12.5, -18.75, 5, -25, -25, 10);
    line(-25, -25, 10, -37.5, -12.5, 0);
    line(37.5, -12.5, 0, 12.5, -18.75, -5);
    line(12.5, -18.75, -5, -25, -25, -10);
    line(-25, -25, -10, -37.5, -12.5, 0);

    //right wing
    stroke(0, 0, 255);
    line(37.5, 12.5, 0, 12.5, 25, 0);
    line(12.5, 25, 0, -25, 37.5, 0);
    line(-25, 37.5, 0, -37.5, 12.5, 0);
    line(-37.5, 12.5, 0, -12.5, 18.75, 0);
    line(-12.5, 18.75, 0, 37.5, 12.5, 0);

    line(37.5, 12.5, 0, 12.5, 18.75, 5);
    line(12.5, 18.75, 5, -25, 25, 10);
    line(-25, 25, 10, -37.5, 12.5, 0);
    line(37.5, 12.5, 0, 12.5, 18.75, -5);
    line(12.5, 18.75, -5, -25, 25, -10);
    line(-25, 25, -10, -37.5, 12.5, 0);

    popMatrix();
  }//end display()

  void setLeft(boolean setter) {
    left=setter;
  }//end setLeft()

  void setRight(boolean setter) {
    right=setter;
  }//end setRight()

  void setUp(boolean setter) {
    up=setter;
  }//end setUp()

  void setDown(boolean setter) {
    down=setter;
  }//end setDown()
}//end class Ship

class Stars {
  int xLoc, yLoc, zLoc;
  int speed;
  int size;

  Stars(int tx, int ty, int tz) {
    xLoc=tx;
    yLoc=ty;
    zLoc=tz;

    speed=int(random(7, 12));
    size=int(random(1, 3));
  }//end constructor

  void update() {
    //z location is the only variable that changes
    zLoc+=speed;
    //when a star goes "above" the screen, it goes back to its starting point
    if (zLoc>0) {
      zLoc=-600;
    }
  }//end update()

  void display() {
    noStroke();
    pushMatrix();
    translate(xLoc, yLoc, zLoc);
    fill(244, 255, 90);
    sphere(size);
    popMatrix();
  }//end display()
}//end class Stars


 
