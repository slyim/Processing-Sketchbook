float squareSize = random(50, 150);
float lineWidth = random(4, 16);

float circleSize = random(25, 75);


void setup() {
  size(640, 360);
  background(0);
}

void draw () {
  squareSize = random(50, 150);
  lineWidth = random(4, 16);
  rectMode(CENTER);
  strokeWeight(lineWidth);
  stroke(0, 0, 255, 10); 
  fill(0, 255, 0, 5);
  square(320, 180, squareSize);
  
  
  fill(255,0,255, 5);
  circleSize = random(25, 75);
  circle(320,180,circleSize);
}
