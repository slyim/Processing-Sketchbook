// Test ve geçiş kodu. Statik mod denemeleri silinmiş, aktif modda çalışıyor.

// Statik mod denemeleri (pasif, referans için saklandı):
/*
size(400, 400);
background(0);
fill(154, 0, 54, 100);
rect(100, 100, 200, 200);
*/

// Aktif mod
void setup() {
  size(400, 200);
  background(0);
  fill(#D31E1E);
  noStroke();
}

void draw() {
  rect(0, 150, 50, 20); // Sol alt köşede küçük kırmızı dikdörtgen
}
