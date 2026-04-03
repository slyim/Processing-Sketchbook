// Meyve envanterini çubuk grafik olarak gösteren çizim.
float[] fruitInventory = new float[5]; // Her meyvenin miktarı
String[] fruitNames = {"mango", "strawberry", "kiwi", "plum", "blueberry"};

void setup() {
  size(640, 360);

  // Her meyveye rastgele bir miktar ata (50-100 arası)
  for (int i = 0; i < fruitInventory.length; i++) {
    fruitInventory[i] = random(50, 100);
  }
}

void draw() {
  background(0);
  strokeWeight(24);
  stroke(255);
  strokeCap(SQUARE);
  textAlign(CENTER);
  textSize(24);
  fill(255);

  // Her meyve için dikey çubuk ve etiket çiz
  for (int i = 0; i < fruitNames.length; i++) {
    float x = 100 + i * 100; // Çubukları eşit aralıklarla yerleştir
    line(x, height/2, x, height/2 - fruitInventory[i]); // Çubuk
    text(fruitNames[i], x, height/2 + 64);               // Etiket
  }
}
