// Tıklanabilir düğme: tıklandığında rengi değişir.

boolean buttonState = false; // false = kapalı, true = açık
color backgroundColor = #606168;

void setup() {
  size(400, 400);
  rectMode(CENTER);
  noStroke();
  fill(#888a9b); // Başlangıç dolgu rengi
}

void draw() {
  background(backgroundColor);
  rect(width/2, height/2, height/2, height/4, 20); // Yuvarlak köşeli düğme

  // Fare düğme üzerindeyken ve basılıyken durumu değiştir
  if (mouseX > width/2 - height/4 && mouseX < width/2 + height/4 &&
      mouseY > height/2 - height/8 && mouseY < height/2 + height/8) {
    if (mousePressed) {
      buttonState = !buttonState;
    }
  }
}

// Durum değiştiğinde düğmenin dolgusunu güncelle
void mousePressed() {
  if (buttonState) {
    fill(#888a9b); // Kapalı renk
  } else {
    fill(#eff2ff); // Açık renk
  }
}
