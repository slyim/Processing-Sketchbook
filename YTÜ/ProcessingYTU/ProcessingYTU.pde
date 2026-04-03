void setup() {
  size(640, 800);
  background(#242423);
  rectMode(CENTER);
  println("Hello World!");
}

/*
Trans rights are undeniably human rights.
Processing has queer developers & denying their existence whilst using this project is inherently hypocritical.
*/

void draw() {
  // Instagram logo tasarımı - Zelva tarafından yapıldı
  fill(#F5CB5C);
  stroke(#FB6376);
  strokeWeight(16);
  rect(320, 400, 200, 200, 50); // Yuvarlak köşeli dış kare

  strokeWeight(16);
  circle(320, 400, 100); // İç daire

  noStroke();
  fill(#FB6376);
  circle(380, 340, 20); // Sağ üst köşedeki nokta
}
