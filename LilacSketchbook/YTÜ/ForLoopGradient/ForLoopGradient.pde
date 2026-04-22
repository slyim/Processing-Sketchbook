// For döngüsüyle siyahtan beyaza gradyan çizer.
// Her satır bir ton daha açık gri alır (0'dan 255'e).

void setup() {
  size(400, 256); // 256 satır = tam gri skalası (0-255)
}

void draw() {
  for (int i = 0; i < 256; i++) {
    stroke(i);            // i=0 siyah, i=255 beyaz
    line(0, i, width, i); // Yatay çizgi
  }
}
