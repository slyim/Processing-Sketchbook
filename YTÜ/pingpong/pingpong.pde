// Çapraz hareketle ekranda ilerleyen, konsola konum yazan daire.

float circleX;
float circleY;

void setup() {
  size(640, 360);
  circleX = 320; // Başlangıç merkezi
  circleY = 180;
  println("Hello uwu");
}

void draw() {
  background(0);
  println(circleX); // Her karede x konumunu konsola yaz

  noStroke();
  fill(255);
  circle(circleX, circleY, 50);

  circleX += 5; // Sağa doğru hareket
  circleY += 2; // Aşağıya doğru hareket
}
