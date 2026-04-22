// =============================================================
// 03_TransformsMatrix — Processing Reference
// =============================================================
// Covers:
//   translate(x, y)     — move the origin
//   rotate(angle)       — rotate around the current origin
//   scale(s) / scale(x, y) — scale around the current origin
//   pushMatrix / popMatrix — save & restore the transform state
//   Combining transforms: order matters!
//   resetMatrix()       — clear all transforms
// =============================================================

float t = 0; // time variable for animated demo

void setup() {
  size(900, 620);
}

void draw() {
  background(25);
  t += 0.02;

  // ── 1. translate ─────────────────────────────────────────
  // Without translate, everything is anchored at (0,0).
  // translate() moves the coordinate origin.
  sectionLabel(30, 25, "translate(x, y)");

  pushMatrix();
    // Draw at origin first (top-left)
    fill(80, 80, 80); noStroke();
    rect(30, 40, 60, 40);

    // Translate origin → draw same rect at different spot
    translate(130, 60);
    fill(200, 100, 60);
    rect(0, 0, 60, 40);  // still drawn at 0,0 — origin moved
  popMatrix();

  // ── 2. rotate ────────────────────────────────────────────
  sectionLabel(30, 140, "rotate(angle)  — rotates around origin");

  pushMatrix();
    // Rotate around top-left is rarely what you want.
    // Translate to the center of your object first.
    translate(120, 195);
    rotate(t);              // angle in radians
    fill(60, 160, 220);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, 70, 40);    // drawn centered on the (moved) origin
    rectMode(CORNER);       // reset rect mode
  popMatrix();

  // Rotating around a fixed point demo
  pushMatrix();
    translate(280, 195);
    rotate(t * 0.7);
    fill(220, 80, 160);
    noStroke();
    ellipse(55, 0, 20, 20); // planet orbiting center
    fill(255, 200, 0);
    circle(0, 0, 18);       // sun at origin
  popMatrix();

  // ── 3. scale ─────────────────────────────────────────────
  sectionLabel(30, 275, "scale(s)  — scales around origin");

  pushMatrix();
    translate(80, 330);
    noStroke();
    // scale > 1 enlarges, < 1 shrinks, negative flips
    float s = 0.5 + abs(sin(t)) * 1.5; // pulse between 0.5 and 2.0
    scale(s);
    fill(100, 220, 120);
    rect(-25, -20, 50, 40);
  popMatrix();

  // Non-uniform scale
  pushMatrix();
    translate(220, 330);
    scale(1 + sin(t) * 0.5, 1 + cos(t) * 0.5); // different x/y scale
    fill(220, 160, 60);
    noStroke();
    circle(0, 0, 50);
  popMatrix();

  // ── 4. pushMatrix / popMatrix ────────────────────────────
  sectionLabel(30, 405, "pushMatrix / popMatrix  — save & restore state");

  // Draw a tree of nested transforms
  drawBranch(120, 560, -HALF_PI, 80, 5);

  // ── 5. Order matters ─────────────────────────────────────
  sectionLabel(430, 25, "Order matters: translate then rotate ≠ rotate then translate");

  // Translate THEN rotate: spins in place at (540, 100)
  pushMatrix();
    translate(540, 100);
    rotate(t);
    fill(220, 100, 60);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, 60, 30);
    rectMode(CORNER);
    fill(200); textSize(10);
    text("translate→rotate", -30, 35);
  popMatrix();

  // Rotate THEN translate: orbits around (0,0)
  pushMatrix();
    rotate(t);
    translate(100, 0);
    translate(700, 100); // offset so we can see it
    fill(60, 180, 220);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, 60, 30);
    rectMode(CORNER);
    fill(200); textSize(10);
    text("rotate→translate", -30, 35);
  popMatrix();

  // ── 6. Multiple objects, independent transforms ──────────
  sectionLabel(430, 210, "Independent transforms with push/pop");

  // Grid of rotating squares, each with its own angle
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 5; col++) {
      pushMatrix();
        float cx = 480 + col * 80;
        float cy = 270 + row * 80;
        translate(cx, cy);
        // Each square spins at a different speed
        rotate(t * (col + 1) * 0.3 + row * 0.5);
        colorMode(HSB, 360, 100, 100);
        fill((col * 60 + row * 30) % 360, 70, 85);
        colorMode(RGB);
        noStroke();
        rectMode(CENTER);
        rect(0, 0, 50, 50);
        rectMode(CORNER);
      popMatrix();
    }
  }

  // ── Labels ───────────────────────────────────────────────
  fill(120); noStroke(); textSize(10);
  text("All shapes are rect(0,0,...) — only the matrix changes", 430, 590);
}

// Recursive branch-drawing function (uses nested pushMatrix/popMatrix)
void drawBranch(float x, float y, float angle, float len, int depth) {
  if (depth == 0) return;
  float x2 = x + cos(angle) * len;
  float y2 = y + sin(angle) * len;
  stroke(lerp(80, 200, (5 - depth) / 4.0), 160, 80);
  strokeWeight(depth);
  line(x, y, x2, y2);
  pushMatrix();
    drawBranch(x2, y2, angle - 0.45 + sin(t) * 0.1, len * 0.65, depth - 1);
  popMatrix();
  pushMatrix();
    drawBranch(x2, y2, angle + 0.45 + cos(t) * 0.1, len * 0.65, depth - 1);
  popMatrix();
}

void sectionLabel(float x, float y, String label) {
  fill(255, 210, 80);
  noStroke();
  textSize(12);
  text(label, x, y);
}
