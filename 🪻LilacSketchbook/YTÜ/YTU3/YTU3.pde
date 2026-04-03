// Ekranı aşağı doğru tarayan kalın bir çizgi; y konumuna göre renk değiştirir.

int y = 0; // Çizginin dikey konumu

void setup() {
  size(800, 400);
}

void draw() {
  line(0, y, 800, y);
  strokeWeight(20);

  // y konumuna göre dört farklı renk bölgesi
  if (y <= 100) {
    stroke(#422344); // Mor
  } else if (y > 100 && y <= 200) {
    stroke(#994422); // Kahve
  } else if (y >= 200 && y <= 300) {
    stroke(#ffff22); // Sarı
  } else {
    stroke(#779922); // Yeşil
  }

  y += 8; // Her karede 8 piksel aşağı in
}
