// Lila Aydin 2308A025

void setup() {
    noStroke();
    size(800, 400);
    background(0);
    rect(400, 0, 800, 400);
}

void draw() {

// Check the mouse X position
  if (mouseX >= 400){
    stroke(0);
  } else if (mouseX <= 400){
    stroke(255);
  }

// Draw the stroke
    line(mouseX, mouseY, width/2, height/2);
}


// Canvas Reset
void mousePressed(){
    noStroke();
    size(800, 400);
    background(0);
    rect(400, 0, 800, 400);
}