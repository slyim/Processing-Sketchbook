// Yukarı aşağı zıplayan basit top.
// "hareket" değişkeni topun yönünü tutar (+1 aşağı, -1 yukarı).

int y;
int hareket; // Topun dikey yönü (1 = aşağı, -1 = yukarı)

void setup() {
  size(300, 200);
  noStroke();
  fill(200, 100, 50);
  background(50);
  y = 25;
  hareket = 1;
}

void draw() {
  background(50);
  circle(width / 2, y, 50); // Topu çiz
  y += hareket;              // Topu ilerlet

  // Üst kenara ulaşınca aşağı, alt kenara ulaşınca yukarı git
  if (y <= 25)  hareket =  1;
  if (y == 175) hareket = -1;
}
