boolean buttonState = false;
color backgroundColor = #606168;

void setup() {
  size(400, 400);
  rectMode(CENTER);
  noStroke();
  fill(#888a9b);
}

void draw() {

  background(backgroundColor);
  rect(width/2, height/2, height/2, height/4, 20);


  if (mouseX > width/2 - height/4 && mouseX < width/2 + height/4 && mouseY > height/2 - height/8 && mouseY < height/2 + height/8) {
    if (mousePressed) {
      buttonState = !buttonState;
    }
  }
}

  void mousePressed() {
    if (buttonState) {
    fill(#888a9b);
  } else {
    fill(#eff2ff);
  }
}