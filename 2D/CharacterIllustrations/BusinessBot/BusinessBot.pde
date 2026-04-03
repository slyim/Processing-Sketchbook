// Basit bir karakter çizimi: üçgen gövde ve yuvarlatılmış köşeli dikdörtgen.

void setup() {
  size(640, 800);
  background(#FFFFFF);
  rectMode(CENTER); // Dikdörtgenleri merkeze göre çiz
}

void draw() {
  // Üçgen gövde
  fill(#aafff2);
  triangle(320, 300, 220, 500, 420, 500);

  // Gövdenin altındaki yuvarlak köşeli dikdörtgen
  noStroke();
  fill(#aafff2);
  rect(320, 600, 100, 100, 15); // 15px köşe yuvarlaması
}
