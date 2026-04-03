// =============================================================
// 01_BasicShapes — Processing Reference
// =============================================================
// Covers:
//   rect, ellipse, circle, line, arc, triangle, quad
//   beginShape / vertex / endShape (custom polygon)
//   point
//   stroke, fill, noStroke, noFill
//   strokeWeight, strokeCap, strokeJoin
// =============================================================

void setup() {
  size(900, 650);
  noLoop(); // draw once — shapes don't change
}

void draw() {
  background(25);

  // ── Column 1: filled primitives ──────────────────────────
  // Rectangle  rect(x, y, width, height)
  fill(200, 80, 60);
  stroke(255);
  strokeWeight(2);
  rect(50, 50, 150, 90);

  // Rounded rectangle — 5th arg is corner radius
  fill(200, 140, 60);
  rect(50, 175, 150, 90, 18);

  // Ellipse  ellipse(x, y, w, h)  — x/y is CENTER by default
  fill(60, 160, 220);
  ellipse(125, 330, 140, 90);

  // Circle  circle(x, y, diameter)
  fill(60, 220, 140);
  circle(125, 450, 90);

  // Point (appears as a dot sized by strokeWeight)
  stroke(255, 220, 0);
  strokeWeight(10);
  point(125, 555);
  strokeWeight(2);

  // ── Column 2: stroke-only / outline styles ────────────────
  noFill();
  stroke(255, 100, 180);
  strokeWeight(3);
  rect(250, 50, 150, 90);

  // Arc  arc(x, y, w, h, startAngle, stopAngle)
  // Angles in radians — use HALF_PI, PI, TWO_PI constants
  stroke(255, 200, 60);
  strokeWeight(3);
  arc(325, 235, 130, 130, 0, PI + HALF_PI);  // ¾ circle
  arc(325, 235, 80, 80, PI + HALF_PI, TWO_PI, CHORD); // chord arc

  // Triangle  triangle(x1,y1, x2,y2, x3,y3)
  fill(120, 80, 220);
  stroke(255);
  strokeWeight(2);
  triangle(325, 330, 255, 440, 395, 440);

  // Quad (4-point polygon)
  fill(220, 80, 120);
  quad(260, 480, 390, 470, 400, 560, 250, 565);

  // ── Column 3: lines & caps ───────────────────────────────
  // Line  line(x1, y1, x2, y2)
  stroke(255);
  strokeWeight(1);
  line(480, 50, 630, 50);

  // strokeWeight variety
  for (int i = 1; i <= 6; i++) {
    strokeWeight(i * 2);
    line(480, 60 + i * 25, 630, 60 + i * 25);
  }
  strokeWeight(2);

  // strokeCap: ROUND (default), SQUARE, PROJECT
  stroke(255, 180, 0);
  strokeCap(SQUARE);
  line(480, 240, 630, 240);
  strokeCap(ROUND);
  line(480, 270, 630, 270);
  strokeCap(PROJECT);
  line(480, 300, 630, 300);
  strokeCap(ROUND); // reset

  // ── Column 4: custom polygon with beginShape ──────────────
  fill(80, 200, 200);
  stroke(255);
  strokeWeight(1);
  beginShape();
    vertex(700, 60);
    vertex(800, 40);
    vertex(860, 120);
    vertex(820, 200);
    vertex(730, 220);
    vertex(670, 150);
  endShape(CLOSE); // CLOSE draws the final edge back to start

  // Star using beginShape with two-radius trick
  fill(255, 220, 50);
  noStroke();
  beginShape();
  float cx = 765, cy = 370;
  float outerR = 70, innerR = 30;
  for (int i = 0; i < 10; i++) {
    float angle = TWO_PI / 10 * i - HALF_PI;
    float r = (i % 2 == 0) ? outerR : innerR;
    vertex(cx + cos(angle) * r, cy + sin(angle) * r);
  }
  endShape(CLOSE);

  // noFill / noStroke demo
  stroke(150, 255, 150);
  strokeWeight(2);
  noFill();
  rect(700, 470, 130, 80, 10);

  // ── Labels ───────────────────────────────────────────────
  fill(200);
  noStroke();
  textSize(11);
  text("rect / rounded rect / ellipse / circle / point", 20, 615);
  text("noFill outlines / arc / triangle / quad",        240, 615);
  text("line strokeWeight / strokeCap",                  460, 615);
  text("beginShape polygon / star / noFill rect",        670, 615);
}
