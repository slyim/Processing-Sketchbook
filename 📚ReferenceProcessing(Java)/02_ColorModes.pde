// =============================================================
// 02_ColorModes — Processing Reference
// =============================================================
// Covers:
//   RGB color mode (default)
//   HSB color mode — hue, saturation, brightness
//   Alpha (transparency) in both modes
//   color type, color(), red(), green(), blue(), hue()
//   lerpColor() — blend between two colors
//   colorMode() — switching modes and setting ranges
// =============================================================

color[] palette;

void setup() {
  size(900, 600);
  noLoop();

  // Build a palette of colors using the color() function
  palette = new color[] {
    color(220, 60, 60),   // red
    color(220, 160, 40),  // orange
    color(200, 220, 40),  // yellow-green
    color(60, 200, 80),   // green
    color(40, 160, 220),  // blue
    color(140, 60, 220)   // purple
  };
}

void draw() {
  background(20);

  // ── Section 1: RGB Mode ──────────────────────────────────
  // Default colorMode is RGB with range 0–255
  textSize(13);
  fill(200);
  noStroke();
  text("RGB mode  colorMode(RGB, 255)", 30, 35);

  // Red channel ramp
  for (int i = 0; i < 12; i++) {
    float r = map(i, 0, 11, 0, 255);
    fill(r, 80, 80);
    noStroke();
    rect(30 + i * 36, 50, 34, 60);
  }

  // Green channel ramp
  for (int i = 0; i < 12; i++) {
    float g = map(i, 0, 11, 0, 255);
    fill(80, g, 80);
    rect(30 + i * 36, 118, 34, 60);
  }

  // Blue channel ramp
  for (int i = 0; i < 12; i++) {
    float b = map(i, 0, 11, 0, 255);
    fill(80, 80, b);
    rect(30 + i * 36, 186, 34, 60);
  }

  fill(160);
  textSize(11);
  text("R", 12, 87); text("G", 12, 155); text("B", 12, 223);

  // ── Section 2: HSB Mode ──────────────────────────────────
  // Switch to HSB: hue 0–360, saturation 0–100, brightness 0–100
  colorMode(HSB, 360, 100, 100);

  fill(0, 0, 180); // white in HSB (0 hue, 0 sat, high bright) – note: after colorMode
  // Actually in HSB(360,100,100): white = (0, 0, 100)
  fill(0, 0, 100, 100); // must use new range — but fill() interprets via colorMode
  textSize(13);
  // Temporarily switch back to draw text
  colorMode(RGB);
  fill(200);
  text("HSB mode  colorMode(HSB, 360, 100, 100)", 30, 285);
  colorMode(HSB, 360, 100, 100);

  // Hue ramp (full spectrum)
  for (int i = 0; i < 36; i++) {
    float h = map(i, 0, 35, 0, 360);
    fill(h, 85, 90);
    noStroke();
    rect(30 + i * 24, 295, 23, 60);
  }

  // Saturation ramp (fixed hue 200 = blue, brightness 90)
  for (int i = 0; i < 12; i++) {
    float s = map(i, 0, 11, 0, 100);
    fill(200, s, 90);
    rect(30 + i * 36, 363, 34, 60);
  }

  // Brightness ramp (fixed hue 200, saturation 80)
  for (int i = 0; i < 12; i++) {
    float b = map(i, 0, 11, 0, 100);
    fill(200, 80, b);
    rect(30 + i * 36, 431, 34, 60);
  }

  colorMode(RGB); // reset to RGB for the rest
  fill(160);
  textSize(11);
  text("H", 12, 332); text("S", 12, 400); text("Br", 8, 468);

  // ── Section 3: Alpha transparency ───────────────────────
  fill(200);
  textSize(13);
  text("Alpha (4th arg)", 490, 35);

  // Layered semi-transparent circles
  noStroke();
  for (int i = 0; i < 6; i++) {
    float alpha = map(i, 0, 5, 40, 255);
    fill(220, 80, 60, alpha);
    circle(540 + i * 30, 100, 90);
  }

  // Blend on top of each other
  fill(220, 80, 60, 120);
  circle(680, 140, 100);
  fill(60, 180, 220, 120);
  circle(720, 140, 100);
  fill(60, 220, 80, 120);
  circle(700, 110, 100);

  // ── Section 4: lerpColor ────────────────────────────────
  fill(200);
  textSize(13);
  text("lerpColor(c1, c2, t)  — t: 0.0 → 1.0", 490, 285);

  color c1 = color(220, 60, 60);
  color c2 = color(60, 160, 220);
  for (int i = 0; i < 20; i++) {
    float t = i / 19.0;
    fill(lerpColor(c1, c2, t));
    noStroke();
    rect(490 + i * 21, 295, 20, 60);
  }

  // Triple lerp by chaining
  color cMid = color(220, 220, 60);
  text("3-color gradient via chained lerpColor", 490, 385);
  for (int i = 0; i < 20; i++) {
    float t = i / 19.0;
    color c;
    if (t < 0.5) c = lerpColor(c1, cMid, t * 2);
    else         c = lerpColor(cMid, c2, (t - 0.5) * 2);
    fill(c);
    noStroke();
    rect(490 + i * 21, 395, 20, 60);
  }

  // ── Section 5: Extracting components ────────────────────
  fill(200);
  textSize(13);
  text("red() green() blue() / hue() saturation() brightness()", 490, 495);

  color sample = color(180, 100, 220);
  fill(sample);
  noStroke();
  rect(490, 510, 60, 60);

  fill(red(sample), 0, 0);     rect(560, 510, 55, 60);
  fill(0, green(sample), 0);   rect(620, 510, 55, 60);
  fill(0, 0, blue(sample));    rect(680, 510, 55, 60);

  fill(200);
  textSize(10);
  text("sample", 492, 585);
  text("R=" + int(red(sample)), 562, 585);
  text("G=" + int(green(sample)), 622, 585);
  text("B=" + int(blue(sample)), 682, 585);
}
