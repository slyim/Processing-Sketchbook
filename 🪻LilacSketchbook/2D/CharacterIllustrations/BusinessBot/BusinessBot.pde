// Basit bir karakter çizimi: To-Do

void setup() {
  size(640, 800);
  background(#FFFFFF);
  rectMode(CENTER);
}

void draw() {
  fill(#aafff2);
  triangle(320, 300, 220, 500, 420, 500);

  noStroke();
  fill(#aafff2);
  rect(320, 600, 100, 100, 15); // 15px köşe yuvarlaması
}
