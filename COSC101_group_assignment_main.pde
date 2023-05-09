/*************************************************************************************************
* COSC101 - Assignment 3 - Group Project 21/05/2023
* David Hill, Student No: 220262575
* Scott Vale, Student No: 220264537
* Jake Mayled, Student No: 220265608
*
* ##############PROJECT DESCRIPTION & CODE EXPLANATIONS#########
*
**************************************************************************************************/

// Global varibles and Declarations
PImage city;
int[] cityX; // city x coordinate
int[] cityY; // city y coordinate
int cityCount;
float[] missileX; // missile x coordinate
float[] missileY; // missile y coordinate
int missileSpeed; // missile speed
int missileCount; // number of missiles
int[] missileDestroyed; // binary array, 0 = missile not destroyed, 1 = missile destroyed
int score; // player score
int magazineSize = 10; // Number of shots in the magazine
int numShots; // Current number of shots on screen
int shotsRemaining = magazineSize; // Number of shots remaining in the magazine
int level = 1; // level count
boolean shotFired = false; // A flag to ensure only 1 bullet is fired per mouse click
//PVector[] mousePos = new PVector[0];
//PVector[] shotPosition = new PVector[magazineSize+5]; // Array to store shot positions. Extra 5 elements to ensure no array out of bounds error.
PVector[][]shots = new PVector[magazineSize+5][2]; // Array to store shot positions and mouse positions
PVector[] shotVelocity = new PVector[magazineSize+5]; // Array to store shot velocities. Extra 5 elements to ensure no array out of bounds error.
PVector mouseVector;



/*************************************************************************************************
* Setup() - Initialise all required values for our program.
*************************************************************************************************/

void setup(){ 
  size(1200,800);
  
  score = 0;
  city = loadImage("city.png");
  cityCount = 4;
  
  //sets city X postion
  cityX = new int[4];
  cityX[0] = 180;
  cityX[1] = 380;
  cityX[2] = 740;
  cityX[3] = 940;
  
  //sets city Y position
  cityY = new int[4];
  cityY[0] = 695;
  cityY[1] = 695;
  cityY[2] = 695;
  cityY[3] = 695;
  
  //sets missile speed and the number of missiles
  missileSpeed = 1;
  missileCount = 5;
  
  missileDestroyed = new int[missileCount];
  for(int i=0; i<missileDestroyed.length; i++){
    missileDestroyed[i] = 0;
  }

  //sets missile x coordinate
  missileX = new float[missileCount];
  for(int i=0; i<missileX.length; i++){
    missileX[i] = random(width);
  }
  
  //sets missile y coordinate
  missileY = new float[missileCount];
  for(int i=0; i<missileY.length; i++){
    missileY[i] = random(-500, -50);
  }

}
  
/*************************************************************************************************
* draw() - Iteratively render the game
*************************************************************************************************/
void draw(){
  background(200);
  noCursor();
  crosshair();
  gunManager();
  missile();
  
  //displays score
  fill(0);
  textSize(25);
  text("score: " + score, 1000, 20);
  
  //displays background
  fill(0,128,0);
  rect(0, 700, 100, 150);
  rect(100, height-25, 1000, height-25);
  rect(1100, 700, 100, 150);
  fill(0,128,0);
  
  //displays citys
  for(int i=0; i<cityX.length; i++){
    image(city, cityX[i], cityY[i]);
  }
  
  // Text showing Ammunition
  fill(255);
  text("Ammo: " + (magazineSize - numShots), width/2.18, height);

}

/*************************************************************************************************
* Gun and Projectile Logic
*************************************************************************************************/
/* This function draws the crosshair image and positions it on top of the mouse coordinates */
void crosshair() { 
  stroke(255,0,0);
  strokeWeight(2);
  fill(200); // Allow a see through circle
  
  // Draw crosshair lines
  line(mouseX, mouseY - 20, mouseX, mouseY + 20);
  line(mouseX - 20, mouseY, mouseX + 20, mouseY);
  
  // Draw a thin circle around the mouse position
  strokeWeight(1);
  ellipse(mouseX, mouseY, 15, 15); // Center of circle is mouseX and mouseY pos
}
/* This gunManager() function draws the gun turret and bullet projectile.
  It controls where the gun turret points and the direction the projectiles fire (at the crosshair). */
void gunManager() {
  // Drawing Section
  
  // Create a PVector from the bottom center of the screen (gunTurret location) to the mouse position
  PVector mouseVector = new PVector(mouseX - width/2, mouseY - height);
  
  // Set the length of the gun line (proportional to screen size)
  mouseVector.setMag(height/13);
  
  // Draw a line from the center of the screen to the point on the mouseVector
  stroke(255);
  strokeWeight(7);
  line(width/2, height, width/2 + mouseVector.x, height + mouseVector.y);
  
  // Draw a semi-circle at the bottom-middle of the screen
  strokeWeight(3);
  fill(0);
  ellipse(width/2, height, 90, 90);
  
  // Gun Projectile Logic
  if (mousePressed && numShots < magazineSize && !shotFired) {
    // Add new shot
    shots[numShots][0] = new PVector(width/2, height); // Set initial position at the bottom-center of the screen
    shots[numShots][1] = new PVector(mouseX, mouseY); // Store the mouse position with the shot
    shotVelocity[numShots] = new PVector(mouseVector.x, mouseVector.y).setMag(10); // Set velocity towards the mouse position and set magnitude of velocity to control speed
    numShots++;
    shotFired = true; // Set shotFired to true to prevent firing multiple bullets
  }
  
  // Update and draw shots
  for (int i = 0; i < magazineSize; i++) { // Loop through all active shots
    if (shots[i][0] != null) {
  
      // Draw shot at current position
      noStroke();
      fill(255,69,0);
      ellipse(shots[i][0].x, shots[i][0].y, 5, 5);
      shots[i][0].add(shotVelocity[i]); // Update position based on velocity
    }
  }
}


/* This missile function draws the missile to the screen and detects if it collides with the citys or the players shot */
void missile(){
  //draws missile
  for(int i=0; i<missileX.length; i++) {
    stroke(0);
    line(missileX[i], missileY[i], missileX[i]+20, missileY[i]+60);
    missileY[i] += missileSpeed;
    if(missileY[i] >height){
      missileY[i] = random(-500, -50);
    }
  }
  
  //collision detection for missile and city
  for(int i=0; i<cityX.length; i++) {
    for(int x=0; x<missileX.length; x++) {
      if(dist(missileX[x], missileY[x], cityX[i], cityY[i]) < 40) {
        fill(255,0,0);
        ellipse(cityX[i]+40, cityY[i]+40, 80, 80);
        cityX[i] = -200;
      }
    }
  }
  
  //collision detection for missile and player shot
  for(int i=0; i<missileCount; i++){
    for(int j=0; j<numShots; j++){
      if(shots[j][0] != null) {
        if((dist(missileX[i], missileY[i], shots[j][0].x, shots[j][0].y) < 30)&&(missileDestroyed[i] == 0)) {
          fill(255,0,0);
          ellipse(missileX[i], missileY[i], 80, 80);
          score++;
          missileDestroyed[i] = 1;
          missileX[i] = -200; 
          shots[j][0] = null; // Remove the shot projectile
        }
      }
    }
  }
}
/*************************************************************************************************
* Mouse Controls
*************************************************************************************************/
/* This function fires shots when mouse is clicked */
void mousePressed() {
  //PVector[] mousePos = new PVector[1];
  if (shotsRemaining > 0) { // Only fire if there are shots remaining
    shotsRemaining--; // Decrement shots remaining in the magazine
  } else {
    shotFired = true; // Don't allow the player to fire once magazine is empty
  }
}
/* This function exists to allow shots to be fired again only once the mouse has been released */
void mouseReleased() {
  shotFired = false;
} 
/*************************************************************************************************
* Level Logic
*************************************************************************************************/
/* This function controls requirements to finish a level and magazine sizes
  At the moment it is a basic idea of how we might design a way to control levels. */
void levelManager() {
  if (level == 1) {
    magazineSize = 10;
  }
  if (level == 2) {
    magazineSize = 20;
  }
}
