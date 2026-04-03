// Fare konumuna her karede rastgele renkli daireler çizer.

void setup() {
  size(400, 400);
  background(50);
  noStroke();
  fill(50);
}

void draw() {
  // Her karede rastgele RGBA renk üret
  float R = random(0, 255);
  float G = random(0, 255);
  float B = random(0, 255);
  float A = random(0, 255); // Alfa (şeffaflık)
  fill(R, G, B, A);
  circle(mouseX, mouseY, 75); // Fare konumuna daire çiz
}
