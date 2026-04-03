// Fareden ekranın merkezine rastgele renkli çizgiler çizer.
// Fare tıklandığında tuval temizlenir.

float a, b, c, d;

void setup() {
  size(400, 400);
  background(#5E4C5A);
}

void draw() {
  // Her karede rastgele RGBA renk üret
  a = random(0, 255); // Kırmızı
  b = random(0, 255); // Yeşil
  c = random(0, 255); // Mavi
  d = random(0, 255); // Alfa (şeffaflık)
  stroke(a, b, c, d);
  line(mouseX, mouseY, width/2, height/2); // Fareden merkeze çizgi
}

// Tuvali arka plan rengiyle temizle
void mouseClicked() {
  background(#5E4C5A);
}
