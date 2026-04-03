// Lila Aydin 2308A025
// Fareden ekranın merkezine doğru çizgi çizer.
// Sol yarıda beyaz, sağ yarıda siyah çizgi.

void setup() {
  noStroke();
  size(800, 400);
  background(0);
  rect(400, 0, 800, 400); // Sağ yarıyı beyaz yap
}

void draw() {
  // Fare konumuna göre çizgi rengini belirle
  if (mouseX >= 400) {
    stroke(0);   // Sağ yarı: siyah çizgi (beyaz arka planda görünür)
  } else if (mouseX <= 400) {
    stroke(255); // Sol yarı: beyaz çizgi (siyah arka planda görünür)
  }

  line(mouseX, mouseY, width/2, height/2); // Fareden merkeze çizgi
}

// Fare tıklandığında tuvali sıfırla
void mousePressed() {
  noStroke();
  size(800, 400);
  background(0);
  rect(400, 0, 800, 400);
}
