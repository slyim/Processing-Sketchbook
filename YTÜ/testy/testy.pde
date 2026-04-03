// P3D renderer ile dönen 3D kutu.
// size() P3D ile birlikte settings() içinde tanımlanmalıdır.

void settings() {
  size(800, 600, P3D);
}

void setup() {
  background(15, 10, 30);
}

void draw() {
  background(15, 10, 30);
  lights();                            // Varsayılan ışıklandırma
  translate(width / 2, height / 2, 0); // Merkeze taşı
  rotateX(frameCount * 0.02f);         // Her karede X ekseninde döndür
  rotateY(frameCount * 0.03f);         // Her karede Y ekseninde döndür
  fill(255, 150, 200);
  noStroke();
  box(150);
}
