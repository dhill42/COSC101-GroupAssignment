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


/*************************************************************************************************
* Setup() - Initialise all required values for our program.
*************************************************************************************************/

void setup(){ 
  size(1200,800);
  
  score = 0;
  city = loadImage("City.png");
  
}
  
/*************************************************************************************************
* draw() - Iteratively render the game
*************************************************************************************************/
void draw(){
  background(255);
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
  image(city, 180, 650);
  image(city, 380, 650);
  image(city, 740, 650);
  image(city, 940, 650);

}
