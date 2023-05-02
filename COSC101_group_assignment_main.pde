/*************************************************************************************************
* COSC101 - Assignment 3 - Group Project 21/05/2023
* David Hill, Student No: 220262575
* Scott Vale, Student No: 
* Jake Mayled, Student No: 220265608
*
* ##############PROJECT DESCRIPTION & CODE EXPLANATIONS#########
*
**************************************************************************************************/

// Global varibles and Declarations
PImage city;
int score;
int[] cityX; // city x coordinate
int[] cityY; // city y coordinate


/*************************************************************************************************
* Setup() - Initialise all required values for our program.
*************************************************************************************************/

void setup(){ 
  size(1200,800);
  
  score = 0;
  city = loadImage("city.png");
  
  //sets city X postion
  cityX = new int[4];
  cityX[0] = 180;
  cityX[1] = 380;
  cityX[2] = 740;
  cityX[3] = 940;
  
  //sets city Y position
  cityY = new int[4];
  cityY[0] = 650;
  cityY[1] = 650;
  cityY[2] = 650;
  cityY[3] = 650;
 
  
  
}

  
/*************************************************************************************************
* draw() - Iteratively render the game
*************************************************************************************************/
void draw(){
  background(200);
  
  //hides mouse cursor and displays crosshair
  noCursor();
  strokeWeight(3);
  line(mouseX, mouseY-15, mouseX, mouseY+15);
  line(mouseX-15, mouseY, mouseX+15, mouseY);
  
  //displays score
  fill(0);
  textSize(25);
  text("score: " + score, 1000, 20);
  
  //displays background
  fill(200, 0, 0);
  rect(0, 650, 100, 150);
  rect(100, 730, 1000, 100);
  rect(1100, 650, 100, 150);
  fill(0);
  ellipse(600, 680, 20, 20);
  fill(200, 0, 0);
  rect(550, 680, 100, 50);
  
  //displays citys
  for(int i=0; i<cityX.length; i++){
    image(city, cityX[i], cityY[i]);
  }

}
