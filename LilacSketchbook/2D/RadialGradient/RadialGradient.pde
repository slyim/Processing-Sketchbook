// Fare tıklamasıyla açık/koyu mod arasında geçiş yapan radyal degrade.
boolean state = false;

void setup() {
  size(400, 400);
  noStroke();
}

void draw() {
  if (state) {
    // Koyu mod: dıştan içe doğru siyahtan beyaza
    cursor(HAND);
    background(0);
    for (int i = 255; i >= 0; i--) {
      fill(255 - i); // i=255'te siyah, i=0'da beyaz
      circle(width/2, height/2, i);
    }
  } else {
    // Açık mod: dıştan içe doğru beyazdan siyaha
    cursor(ARROW);
    background(255);
    for (int i = 255; i >= 0; i--) {
      fill(i); // i=255'te beyaz, i=0'da siyah
      circle(width/2, height/2, i);
    }
  }
}

// Fare tıklandığında modu değiştir
void mousePressed() {
  state = !state;
}
