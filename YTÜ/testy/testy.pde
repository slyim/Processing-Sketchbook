float circleX;
float circleY;

void setup() {
  size(640, 360);
  
  circleX = 320; 
  circleY = 180;
  
  println("Hello uwu");  
}

void draw(){
  background(0);
  println(circleX);
  
  noStroke();
  fill(255);
  
  circle(circleX, circleY, 50);
  
  circleX+= 5; 
  circleY+= 2;
}
