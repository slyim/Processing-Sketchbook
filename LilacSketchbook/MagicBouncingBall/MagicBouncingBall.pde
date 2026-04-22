// Lila Aydin 2308A025
// Duvarlara ve fareye çarparak zıplayan, her karede renk değiştiren top.

float xspd, yspd;
float ballStroke, ballEye; // Topu oluşturan iki dairenin boyutu
int fillC;
float x = width  / 2;
float y = height / 2;

void setup() {
  background(0);
  size(800, 640);
  noStroke();
  frameRate(60);
  xspd = 6;
  yspd = 4;
}

void draw() {
  ballStroke = random(75, 100); // Dış daire boyutu
  ballEye    = random(25, 100); // İç daire boyutu

  // Her karede rastgele renk; düşük alfa ile iz efekti oluşturur
  fill(random(0, 255), random(0, 255), random(0, 255), 100);

  x += xspd;
  y += yspd;

  // Duvar çarpışması: kenarlara göre yön ters çevir (ballStroke max 100, yani yarıçap max 50)
  if (x >= width  - 50 || x <= 50) xspd *= -1;
  if (y >= height - 50 || y <= 50) yspd *= -1;

  // Fare çarpışması: farenin yakınına gelince yön ters çevir
  if (dist(x, y, mouseX, mouseY) < ballStroke / 2) {
    xspd *= -1;
    yspd *= -1;
    x += xspd * 2; // Çakışmayı önlemek için fazladan adım at
    y += yspd * 2;
  }

  // Topu tuval sınırları içinde tut
  x = constrain(x, 50, width  - 50);
  y = constrain(y, 50, height - 50);

  circle(x, y, ballStroke); // Dış daire
  circle(x, y, ballEye);    // İç daire
  fill(255, 30);
}

/*
  Top fareye çarptığında tam karşı yöne değil, kendi yönünün tersine gider.
*/

// Fare tıklanınca arka planı rastgele renge boya ve hızı sıfırla
void mousePressed() {
  background(random(0, 255), random(0, 255), random(0, 255));
  xspd = random(-12, 12);
  yspd = random(-8,   8);
}
