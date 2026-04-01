boolean state = false;

void setup(){
  size(400, 400);
  noStroke();
}   

void draw(){
  if(state){ 
    cursor(HAND);
    state = true;
    background(0);
    for(int i=255; i>=0; i--){
      fill(255-i);
      circle(width/2, height/2, i);
    }
  }
  else{
    cursor(ARROW);
    background(255);
 
    for(int i=255; i>=0; i--){
      fill(i);
      circle(width/2, height/2, i);
    }
  }
}

void mousePressed(){
  state = !state;
}