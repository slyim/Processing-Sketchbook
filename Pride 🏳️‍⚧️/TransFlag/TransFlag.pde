// Trans bayrağı (1500x1000).
// Beyaz orta şerit ayrıca çizilmez; setup'taki beyaz arka plandan gelir.

void setup() {
  size(1500, 1000);
  noStroke();
  background(#FFFFFF); // Ortadaki beyaz şerit bu arka plandan oluşuyor
  noLoop(); // Statik çizim, animasyon gerekmez
}

void draw() {
  // Trans bayrağı: mavi - pembe - beyaz - pembe - mavi
  fill(#5BCFFB); rect(0,   0, 1500, 200); // Üst mavi
  fill(#F5ABB9); rect(0, 200, 1500, 200); // Üst pembe
                                           // y:400-600 = beyaz (arka plan)
  fill(#F5ABB9); rect(0, 600, 1500, 200); // Alt pembe
  fill(#5BCFFB); rect(0, 800, 1500, 200); // Alt mavi
}
