int x1, y1, x2, y2;
ArrayList<Tape> cyanTapes;
color rColour;

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100);
  strokeWeight(48);
  strokeCap(SQUARE);
  x1 = 48;
  y1 = 48;
  cyanTapes = new ArrayList<>();
  rColour = color(random(360), 80, 100);
}

void draw() {
  background(0);
  for (Tape tape : cyanTapes) {
    tape.draw(); 
  }
  stroke(rColour);
  line(x1, y1, x2, y2);
  
}

void mousePressed() {
  cyanTapes.add(new Tape(x1, y1, x2, y2, rColour));
}

void mouseMoved() {
  x2 = mouseX;
  y2 = mouseY;
}

void mouseReleased() {
  rColour = color(random(360), 80, 100);
  x1 = mouseX;
  y1 = mouseY;
}


class Tape {
  int x1, y1, x2, y2;
  color colour;
  
  Tape(int x1, int y1, int x2, int y2, color colour) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.colour = colour;
  }
  
  void draw() {
    stroke(colour);
    line(x1, y1, x2, y2);
  }
}