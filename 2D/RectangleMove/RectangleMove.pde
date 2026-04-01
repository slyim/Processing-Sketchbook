// 2308A025 - Lila Aydin

float x, y;
float xspd; 

void setup(){
  size(800, 640);
  xspd = 6; 
  y = height/2;
  x = 0;
  noStroke();
}

void draw(){
  background(#F5CAC3);
  
  x = xspd + x; 
  
  if (x > width - 200 || x < 0) {
    xspd = xspd * -1;
  }
  
  fill(#F28482);
  rect(x, y, 200, 40, 16);
}
