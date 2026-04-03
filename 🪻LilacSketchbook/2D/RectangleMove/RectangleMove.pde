// 2308A025 - Lila Aydin
// Ekran boyunca ileri geri hareket eden dikdörtgen.

float x, y;
float xspd; // Yatay hız

void setup() {
  size(800, 640);
  xspd = 6;
  y = height / 2;
  x = 0;
  noStroke();
}

void draw() {
  background(#F5CAC3);

  x += xspd; // Dikdörtgeni her karede ilerlet

  // Sağ veya sol kenara çarptığında yönü ters çevir
  if (x > width - 200 || x < 0) {
    xspd *= -1;
  }

  fill(#F28482);
  rect(x, y, 200, 40, 16); // 16px köşe yuvarlaması
}
