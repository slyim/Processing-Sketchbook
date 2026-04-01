int renk = 0;
float scale = 1;

float rectSize = 100;
float rectX, rectY;

color[] allColors;

void setup() {
  size(400, 400);
  noStroke();
  rectMode(CENTER);

  rectX = width / 2.0;
  rectY = height / 2.0;

  color c1 = #4400ff;
  color c2 = #b3d00f;
  allColors = new color[]{ c1, lerpColor(c1, c2, 0.5), c2 };
}

void draw() {
  background(allColors[(renk + 1) % allColors.length]);

  if (isHovering()) {
    scale = 1.2;
    cursor(HAND);
  } else {
    scale = 1;
    cursor(ARROW);
  }

  fill(allColors[renk]);

  rect(rectX, rectY, rectSize * scale, rectSize * scale, 12);
}

void mousePressed() {
  if (isHovering()) {
    renk = (renk + 1) % allColors.length;
  }
}

boolean isHovering() {
  float halfSize = rectSize / 2.0;
  return mouseX > rectX - halfSize &&
    mouseX < rectX + halfSize &&
    mouseY > rectY - halfSize &&
    mouseY < rectY + halfSize;
}
