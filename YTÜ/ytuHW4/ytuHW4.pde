// Üzerine gelinince büyüyen, tıklandığında renk değiştiren kare.
// lerpColor ile iki renk arasında ara ton üretilir.

int renk = 0;   // Aktif renk indeksi
float scale = 1; // Karenin boyut çarpanı

float rectSize = 100;
float rectX, rectY;

color[] allColors; // Tüm renk seçenekleri

void setup() {
  size(400, 400);
  noStroke();
  rectMode(CENTER);

  rectX = width  / 2.0;
  rectY = height / 2.0;

  // İki renk arasında üç adımlı palet oluştur
  color c1 = #4400ff;
  color c2 = #b3d00f;
  allColors = new color[]{ c1, lerpColor(c1, c2, 0.5), c2 };
}

void draw() {
  // Arka planı bir sonraki renkle boya
  background(allColors[(renk + 1) % allColors.length]);

  // Fare üzerindeyse büyüt ve el imleci göster
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

// Tıklandığında bir sonraki renge geç
void mousePressed() {
  if (isHovering()) {
    renk = (renk + 1) % allColors.length;
  }
}

// Farenin kare üzerinde olup olmadığını kontrol et
boolean isHovering() {
  float halfSize = rectSize / 2.0;
  return mouseX > rectX - halfSize &&
         mouseX < rectX + halfSize &&
         mouseY > rectY - halfSize &&
         mouseY < rectY + halfSize;
}
