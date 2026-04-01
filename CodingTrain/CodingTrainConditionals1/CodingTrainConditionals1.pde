void setup() {
  size(600, 600);
  rectMode(CENTER);
  noStroke();
  background(0);
}

void draw() {
  background(0);

  if (mouseX >= 200 && mouseX <= 400 && 
      mouseY >= 200 && mouseY <= 400  ){

    circle(width/2, height/2, 200);
  } else {
    rect(width/2, height/2, 200, 200);
  }
}
