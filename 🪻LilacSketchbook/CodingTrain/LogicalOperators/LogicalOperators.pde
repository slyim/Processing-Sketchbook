// Mantıksal operatörlerle (&&) hover tespiti: fare karenin üzerindeyse
// tam opak, değilse yavaş yavaş soldurur.
float x = 50;
float y = 100;
float w = 200;
float trans = 255; // Şeffaflık değeri (0=görünmez, 255=tam opak)

void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  stroke(255);

  // && operatörü: tüm koşullar aynı anda sağlanmalı
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + w) {
    fill(trans = 255);
  } else {
    fill(trans -= 10); // Her karede 10 birim azalt
  }
  square(x, y, w);
}
