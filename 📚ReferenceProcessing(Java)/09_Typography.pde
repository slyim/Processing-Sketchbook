// =============================================================
// 09_Typography — Processing Reference
// =============================================================
// Covers:
//   text(str, x, y)           — draw text at position
//   textSize(size)            — set font size
//   textAlign(H, V)           — LEFT/CENTER/RIGHT, TOP/CENTER/BOTTOM/BASELINE
//   textWidth(str)            — pixel width of a string
//   textAscent() / textDescent() — font metrics
//   textLeading(leading)      — line spacing
//   fill() affects text color
//   text(str, x, y, w, h)     — text in a bounding box (auto wrap)
//   loadFont() / createFont() — custom fonts
//   nf() / nfc() / nfp()      — number formatting helpers
// =============================================================

PFont monoFont;
float t = 0;

void setup() {
  size(900, 620);

  // createFont(name, size) — uses a system font by name
  // To see all available fonts: println(PFont.list());
  monoFont = createFont("Courier New", 14, true);
}

void draw() {
  background(22, 22, 30);
  t += 0.02;

  // ── 1. textSize and fill ─────────────────────────────────
  sectionLabel(30, 30, "textSize + fill");

  textFont(null); // reset to default font
  int[] sizes = {10, 14, 18, 24, 32, 42};
  float tx = 30, ty = 50;
  for (int sz : sizes) {
    textSize(sz);
    fill(200);
    text("Aa", tx, ty + sz);
    tx += textWidth("Aa") + 10;
  }

  // ── 2. textAlign ─────────────────────────────────────────
  sectionLabel(30, 160, "textAlign(H, V)");

  textSize(12);
  // Vertical center line
  stroke(60); strokeWeight(1);
  line(200, 175, 200, 260);
  noStroke();

  textAlign(LEFT);    fill(255, 160, 80);  text("LEFT align",   200, 195);
  textAlign(CENTER);  fill(100, 200, 255); text("CENTER align", 200, 215);
  textAlign(RIGHT);   fill(140, 220, 100); text("RIGHT align",  200, 235);
  textAlign(LEFT); // reset

  // Vertical alignment on a horizontal baseline
  stroke(60); line(30, 270, 400, 270); noStroke();
  textSize(14);
  textAlign(LEFT, TOP);      fill(255, 160, 80);  text("TOP",      30, 270);
  textAlign(LEFT, CENTER);   fill(100, 200, 255); text("CENTER",  100, 270);
  textAlign(LEFT, BASELINE); fill(140, 220, 100); text("BASELINE",195, 270);
  textAlign(LEFT, BOTTOM);   fill(220, 100, 180); text("BOTTOM",  300, 270);
  textAlign(LEFT, BASELINE); // reset

  // ── 3. textWidth / textAscent / textDescent ──────────────
  sectionLabel(30, 310, "textWidth / textAscent / textDescent");

  textSize(20);
  String sample = "Hello Processing!";
  float sw = textWidth(sample);
  float asc = textAscent();
  float desc = textDescent();

  float tx2 = 30, ty2 = 360;
  // Draw metrics visually
  noFill(); stroke(255, 80, 80); strokeWeight(1);
  line(tx2, ty2 - asc, tx2 + sw, ty2 - asc);    // ascent line
  line(tx2, ty2, tx2 + sw, ty2);                 // baseline
  line(tx2, ty2 + desc, tx2 + sw, ty2 + desc);  // descent line
  rect(tx2, ty2 - asc, sw, asc + desc);          // bounding box

  fill(220); noStroke();
  text(sample, tx2, ty2);

  textSize(10);
  fill(255, 80, 80);
  text("textAscent=" + nf(asc, 0, 1), tx2 + sw + 10, ty2 - asc + 4);
  text("baseline",                     tx2 + sw + 10, ty2 + 4);
  text("textDescent=" + nf(desc, 0, 1),tx2 + sw + 10, ty2 + desc + 4);
  text("textWidth=" + nf(sw, 0, 1),    tx2, ty2 + desc + 18);

  // ── 4. Bounding-box text wrap ─────────────────────────────
  sectionLabel(480, 30, "text(str, x, y, w, h)  — auto wrap");

  String paragraph = "Processing is a flexible software sketchbook and a language for learning how to code within the context of the visual arts. It promotes software literacy within the visual arts and visual literacy within technology.";

  fill(10, 10, 20, 180); noStroke();
  rect(480, 48, 380, 120, 6);

  fill(200);
  textSize(12);
  textLeading(20); // extra line spacing
  text(paragraph, 490, 65, 360, 110); // bounded text box
  textLeading(textSize() * 1.2); // reset to default leading

  // ── 5. Custom font (mono) ─────────────────────────────────
  sectionLabel(480, 200, "createFont / loadFont");

  textFont(monoFont);
  textSize(13);
  fill(100, 220, 140);
  text("createFont(\"Courier New\", 14)", 480, 230);
  text("for (int i = 0; i < 10; i++) {", 480, 248);
  text("  println(i);", 480, 266);
  text("}", 480, 284);
  textFont(null); // switch back to default

  // ── 6. Number formatting helpers ─────────────────────────
  sectionLabel(480, 320, "nf() / nfc() / nfp()  — number formatting");

  textSize(12);
  fill(200);
  float num = 3.14159;
  text("nf(3.14159, 1, 2) = " + nf(num, 1, 2),     480, 345); // "3.14"
  text("nf(3.14159, 4, 4) = " + nf(num, 4, 4),     480, 363); // "0003.1416"
  text("nfc(12345.6, 2)   = " + nfc(12345.6, 2),   480, 381); // "12,345.60"
  text("nfp(3.14, 1, 2)   = " + nfp(3.14, 1, 2),  480, 399); // "+3.14"
  text("nfp(-3.14, 1, 2)  = " + nfp(-3.14, 1, 2), 480, 417); // "-3.14"

  // ── 7. Animated text effects ─────────────────────────────
  sectionLabel(480, 450, "Text as visual element");

  String word = "WAVE";
  textSize(48);
  for (int i = 0; i < word.length(); i++) {
    float wave = sin(t * 2 + i * 0.8) * 15;
    colorMode(HSB, 360, 100, 100);
    fill((i * 60 + frameCount * 2) % 360, 80, 90);
    colorMode(RGB);
    float cx = 490 + i * 55;
    text(word.charAt(i), cx, 530 + wave);
  }

  // Typewriter effect
  textSize(14);
  fill(180, 255, 180);
  int charCount = int(t * 8) % (60 + 1);
  String typeStr = "Processing is for everyone...";
  text(typeStr.substring(0, min(charCount, typeStr.length())), 480, 575);
  if (frameCount % 30 < 15) text("|", 480 + textWidth(typeStr.substring(0, min(charCount, typeStr.length()))), 575);
}

void sectionLabel(float x, float y, String label) {
  fill(255, 210, 80); noStroke(); textSize(12); textAlign(LEFT, BASELINE);
  text(label, x, y);
}
