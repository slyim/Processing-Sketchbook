void setup() {
  size(640, 360);
  background(#040F16);
}

// Aby is cute
// Ich liebe Aby <3

void sunshine() {
  fill(255, 255, 0); 
  circle(50, 50, 100);
  
}

void lollipop(float x, float y) {
  noStroke();
  rectMode(CENTER); 
  fill(255);
  rect(x, 240, 10, 100); 
  fill(#37FF8B);
  circle(x, y - 50, 50);
}
  

void draw() {
  background(0);
  
  sunshine();
  
  lollipop(320, 240);
  lollipop(400, 240); 
  
}
  
