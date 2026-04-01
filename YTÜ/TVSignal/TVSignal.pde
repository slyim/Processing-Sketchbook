
void setup(){
  size(600, 400);
  //colorMode(RGB, width);
}

void draw(){
  
  for (int i = 0; i < width; i++){
    stroke(random(255));
    line(i, 0, i, height); 
  }
}

