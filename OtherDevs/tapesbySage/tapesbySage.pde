// Sage tarafından yazılmış çizim aracı.
// Her fare hareketi yeni bir şerit (tape) çizer; her tıklamada renk değişir.

int x1, y1, x2, y2; // Aktif çizginin başlangıç ve bitiş koordinatları
ArrayList<Tape> cyanTapes; // Tamamlanan tüm şeritler
color rColour; // Aktif çizginin rengi

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100); // HSB renk modu: renk geçişleri için ideal
  strokeWeight(48);
  strokeCap(SQUARE);
  x1 = 48;
  y1 = 48;
  cyanTapes = new ArrayList<>();
  rColour = color(random(360), 80, 100); // Rastgele başlangıç rengi
}

void draw() {
  background(0);

  // Kaydedilmiş tüm şeritleri çiz
  for (Tape tape : cyanTapes) {
    tape.draw();
  }

  // Aktif çizgiyi (henüz tamamlanmamış) göster
  stroke(rColour);
  line(x1, y1, x2, y2);
}

// Fare tıklandığında mevcut çizgiyi şerit listesine ekle
void mousePressed() {
  cyanTapes.add(new Tape(x1, y1, x2, y2, rColour));
}

// Fare hareket ettikçe aktif çizginin ucu fareyi takip et
void mouseMoved() {
  x2 = mouseX;
  y2 = mouseY;
}

// Fare bırakıldığında rengi değiştir ve yeni başlangıç noktasını ayarla
void mouseReleased() {
  rColour = color(random(360), 80, 100);
  x1 = mouseX;
  y1 = mouseY;
}

// Tek bir şerit: koordinatları ve rengi saklar, çizimi üstlenir
class Tape {
  int x1, y1, x2, y2;
  color colour;

  Tape(int x1, int y1, int x2, int y2, color colour) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.colour = colour;
  }

  void draw() {
    stroke(colour);
    line(x1, y1, x2, y2);
  }
}
