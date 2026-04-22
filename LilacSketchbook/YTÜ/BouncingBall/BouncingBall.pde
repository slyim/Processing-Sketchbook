// Ekranın içinde çapraz yönde zıplayan basit bir top.

float x = 200;
float y = 200;
float speedX = 6;
float speedY = 4;

void setup() {
  size(400, 400);
}

void draw() {
  background(255);

  // Topu her karede hız vektörü kadar ilerlet
  x += speedX;
  y += speedY;

  // Sağ/sol kenarlara çarptığında yatay yönü ters çevir
  if (x >= 375 || x <= 25) speedX *= -1;

  // Üst/alt kenarlara çarptığında dikey yönü ters çevir
  if (y >= 375 || y <= 25) speedY *= -1;

  fill(0, 150, 255);
  ellipse(x, y, 50, 50);
}
