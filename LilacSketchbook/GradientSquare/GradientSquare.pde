// Her karede rastgele boyutlarda yarı saydam kareler ve daireler üst üste çizer.
// Düşük alfa değerleri sayesinde katmanlar birikince derinlik efekti oluşur.

float squareSize = random(50, 150);
float lineWidth  = random(4, 16);
float circleSize = random(25, 75);

void setup() {
  size(640, 360);
  background(0);
}

void draw() {
  // Her karede yeni rastgele boyutlar belirle
  squareSize = random(50, 150);
  lineWidth  = random(4, 16);

  // Merkezde yarı saydam kare (mavi kontur, yeşil dolgu)
  rectMode(CENTER);
  strokeWeight(lineWidth);
  stroke(0, 0, 255, 10); // Çok düşük alfa: biriktikçe görünür hale gelir
  fill(0, 255, 0, 5);
  square(320, 180, squareSize);

  // Merkezde yarı saydam daire (mor)
  fill(255, 0, 255, 5);
  circleSize = random(25, 75);
  circle(320, 180, circleSize);
}
