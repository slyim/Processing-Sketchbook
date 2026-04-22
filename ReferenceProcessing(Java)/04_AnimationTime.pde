// =============================================================
// 04_AnimationTime — Processing Reference
// =============================================================
// Covers:
//   setup() / draw() lifecycle — draw runs ~60 times/second
//   frameCount  — frames elapsed since start
//   frameRate() — set target FPS; frameRate (variable) — actual FPS
//   millis()    — milliseconds since start
//   sin() / cos() — oscillation, circular motion
//   map()       — remap a range to another range
//   lerp()      — linear interpolation (smooth follow)
//   loop() / noLoop() / redraw() — controlling the draw loop
// =============================================================

// Smooth-follow target for the lerp demo
float lerpX = 450, lerpY = 300;

void setup() {
  size(900, 620);
  frameRate(60);
}

void draw() {
  background(22, 22, 30);

  // frameCount is an integer that increments every draw() call.
  // Dividing it gives a slowly increasing float — good as a time variable.
  float t = frameCount * 0.02;  // t grows by 0.02 each frame

  // millis() gives time in ms — useful for real-time durations
  float tm = millis() * 0.001; // tm = seconds elapsed

  // ── 1. sin() oscillation ─────────────────────────────────
  sectionLabel(30, 30, "sin(t)  — oscillates between -1 and +1");

  // Waveform drawn across the top strip
  noFill();
  stroke(100, 200, 255);
  strokeWeight(2);
  beginShape();
  for (int x = 30; x < 420; x++) {
    float angle = map(x, 30, 420, t, t + TWO_PI * 2);
    float y = 80 + sin(angle) * 35;
    vertex(x, y);
  }
  endShape();

  // A bouncing circle driven by sin()
  float bx = 30 + (frameCount * 2) % 390;
  float by = 80 + sin(t * 3) * 35;
  fill(100, 200, 255);
  noStroke();
  circle(bx, by, 14);

  // ── 2. cos() — 90° offset from sin ───────────────────────
  sectionLabel(30, 145, "cos(t)  — 90° phase offset from sin");

  stroke(255, 160, 80);
  strokeWeight(2);
  noFill();
  beginShape();
  for (int x = 30; x < 420; x++) {
    float angle = map(x, 30, 420, t, t + TWO_PI * 2);
    float y = 190 + cos(angle) * 35;
    vertex(x, y);
  }
  endShape();

  // ── 3. Circular motion: sin + cos together ────────────────
  sectionLabel(30, 265, "sin + cos = circular motion");

  // Circle orbit
  stroke(80, 80, 80);
  strokeWeight(1);
  noFill();
  circle(170, 335, 130);

  float orbitR = 60;
  float ox = 170 + cos(t) * orbitR;
  float oy = 335 + sin(t) * orbitR;
  fill(100, 220, 140);
  noStroke();
  circle(ox, oy, 18);

  // Lissajous curve (different frequencies on x and y)
  stroke(200, 100, 220);
  strokeWeight(1);
  noFill();
  beginShape();
  for (float a = 0; a < TWO_PI; a += 0.02) {
    float lx = 330 + cos(a * 3 + t) * 70;
    float ly = 335 + sin(a * 2) * 70;
    vertex(lx, ly);
  }
  endShape(CLOSE);

  // ── 4. map() — translate ranges ──────────────────────────
  sectionLabel(440, 30, "map(value, inLow, inHigh, outLow, outHigh)");

  // map sin (−1..1) → hue (0..360) for a color cycle
  float hue = map(sin(t), -1, 1, 0, 360);
  colorMode(HSB, 360, 100, 100);
  fill(hue, 80, 90);
  colorMode(RGB);
  noStroke();
  circle(550, 100, 80);

  // map mouseX (0..width) → size
  float sz = map(mouseX, 0, width, 10, 120);
  fill(255, 200, 60, 180);
  circle(720, 100, sz);
  fill(180); textSize(10);
  text("size follows mouseX", 660, 155);

  // ── 5. lerp() — smooth interpolation ─────────────────────
  sectionLabel(440, 190, "lerp(start, stop, t)  — smooth follow (t: 0→1)");

  // lerpX/Y slowly chases the mouse
  lerpX = lerp(lerpX, mouseX, 0.07);
  lerpY = lerp(lerpY, mouseY, 0.07);

  stroke(100, 180, 255, 100);
  strokeWeight(1);
  line(mouseX, mouseY, lerpX, lerpY);

  fill(60, 140, 220);
  noStroke();
  circle(mouseX, mouseY, 12); // target (mouse)
  fill(255, 120, 60);
  circle(lerpX, lerpY, 22);   // follower (lerped)

  fill(180); textSize(10);
  text("orange follows mouse smoothly (lerp 7%)", 440, 370);

  // ── 6. frameRate and timing info ─────────────────────────
  sectionLabel(440, 410, "frameCount / frameRate / millis()");

  fill(180); textSize(12);
  text("frameCount: " + frameCount, 440, 435);
  text("frameRate:  " + nf(frameRate, 0, 1) + " fps", 440, 455);
  text("millis():   " + millis() + " ms  (" + nf(tm, 0, 2) + " s)", 440, 475);

  // Progress bar using millis (loops every 5 seconds)
  float progress = (millis() % 5000) / 5000.0;
  fill(50); noStroke();
  rect(440, 490, 400, 20, 5);
  fill(100, 220, 140);
  rect(440, 490, 400 * progress, 20, 5);
  fill(200); textSize(10);
  text("5-second timer via millis()", 440, 530);

  // ── 7. FPS display ───────────────────────────────────────
  fill(100); noStroke(); textSize(10);
  text("Press SPACE to pause / resume the loop", 30, 605);
}

void keyPressed() {
  if (key == ' ') {
    if (looping) noLoop();
    else         loop();
  }
}

// Helper
void sectionLabel(float x, float y, String label) {
  fill(255, 210, 80);
  noStroke();
  textSize(12);
  text(label, x, y);
}
