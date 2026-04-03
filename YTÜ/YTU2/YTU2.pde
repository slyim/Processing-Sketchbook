// Soldan sağa hareket eden kırmızı dikdörtgen.

int x = 0; // Başlangıç x konumu

void setup() {
  size(400, 400);
  background(200);
  fill(#D31E1E);
  noStroke();
  frameRate(20);
}

void draw() {
  background(200);
  rect(x, 150, 50, 20); // Dikdörtgeni çiz
  x += 4;               // Her karede 4 piksel sağa kayar
}
