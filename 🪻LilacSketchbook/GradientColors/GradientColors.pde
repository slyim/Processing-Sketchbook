// Soldan sağa yeşilden kırmızıya degrade çizer.
// Üst ve alt kenarlara arka plan rengiyle ince bant ekler.

int i;
color[] gradientColors = { #00ff2a, #ff0000 }; // Başlangıç ve bitiş rengi
color bgColor = lerpColor(gradientColors[0], gradientColors[1], 0.1); // Bant rengi

void setup() {
  size(600, 600);
}

void draw() {
  // Her sütun için ara rengi hesapla ve dikey çizgi çiz
  for (i = 0; i < width; i++) {
    float t = map(i, 0, width - 1, 0, 1); // Her sütunu 0-1 arasına normalize et
    color gradient = lerpColor(gradientColors[0], gradientColors[1], t);
    stroke(gradient);
    line(i, 0, i, height);
  }

  // Üst ve alt kenara arka plan rengiyle ince bant çiz
  fill(bgColor);
  noStroke();
  rect(0, 0,          width, height/5);
  rect(0, height*4/5, width, height/5);
}
