// Fare karenin üzerindeyken tam opak, değilse yavaş yavaş soldurur.
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

  // Fare kare üzerindeyse anında opak yap, değilse yavaşça soldur
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + w) {
    fill(trans = 255);
  } else {
    fill(trans -= 10); // Her karede 10 birim azalt
  }
  square(x, y, w);
}
