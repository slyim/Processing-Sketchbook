// Lila Aydin 2308A025
// Ekranın alt merkezinden üst kenara dört renk bölgesiyle yelpazen gibi çizgiler çizer.

int x = 0; // Çizginin üst uç x koordinatı

void setup() {
  size(800, 800);
  background(#160C28);
  strokeWeight(0.5);
}

void draw() {
  // x konumuna göre renk bölgesi belirle
  if (x < 200) {
    stroke(#EFCB68); // Sarı
  } else if (x >= 200 && x < 400) {
    stroke(#9CF6F6); // Açık mavi
  } else if (x >= 400 && x < 600) {
    stroke(#61FF7E); // Yeşil
  } else if (x >= 600 && x < 800) {
    stroke(#D81E5B); // Pembe
  } else {
    noLoop(); // Tüm çizgiler tamamlandığında dur
  }

  line(400, 800, x, 0); // Alt merkezden üst kenara çizgi
  x += 10;
}
