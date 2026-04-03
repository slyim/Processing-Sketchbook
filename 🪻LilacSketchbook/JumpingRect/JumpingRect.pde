// Lila Aydin 2308A025
// Fare üzerine geldiğinde rastgele bir konuma zıplayan ve renk değiştiren kare.

float x, y;
float squareSize = 100;
color bgColor;
color squareColor;
// color tipi rengin hex değerini tutar :3

void setup() {
  size(800, 800);
  rectMode(CENTER);
  noStroke();

  bgColor     = color(0);
  squareColor = color(255);

  // Kareyi tuvalin ortasından başlat
  x = width  / 2;
  y = height / 2;
}

void draw() {
  background(bgColor);

  float halfSize = squareSize / 2;

  // Fare karenin üzerindeyse yeni rastgele konum, boyut ve renkler ata
  if (mouseX >= x - halfSize && mouseX <= x + halfSize &&
      mouseY >= y - halfSize && mouseY <= y + halfSize) {

    // Karenin yarı boyutu kadar içeride tut ki kenardan taşmasın
    x = random(halfSize, width  - halfSize);
    y = random(halfSize, height - halfSize);

    bgColor     = color(random(255), random(255), random(255));
    squareColor = color(random(255), random(255), random(255));
    squareSize  = random(40, 160);
  }

  fill(squareColor);
  // corners are rounded cuz I think I love rounded corners more :3
  rect(x, y, squareSize, squareSize, 8); // 8px köşe yuvarlaması
}
