/**
 * Strange Attractor
 *
 * Iterates two classic chaotic systems 500 000 times per frame and
 * accumulates a density buffer. Log-scaling compresses the dynamic range
 * so both the dense core and sparse wisps are visible simultaneously.
 * Hue encodes the screen-space angle from the center — as the attractor
 * morphs, the rainbow shifts with it.
 *
 * Clifford:  x' = sin(a·y) + c·cos(a·x),  y' = sin(b·x) + d·cos(b·y)
 * de Jong:   x' = sin(a·y) − cos(b·x),     y' = sin(c·x) − cos(d·y)
 *
 * Parameters slowly lerp toward random targets, causing the shape to
 * continuously morph from one strange form into another.
 *
 * Space / R   : new morph target
 * Click       : instant jump to new attractor
 * Tab         : switch formula (Clifford ↔ de Jong)
 */

final int W     = 800;
final int H     = 600;
final int ITERS = 500000;
final float OX  = W / 2.0;
final float OY  = H / 2.0;
final float SCL = 108; // attractor units → pixels

// --- Attractor parameters (current + target) ---
float pa, pb, pc, pd;
float ta, tb, tc, td;
int   morphTimer  = 0;
int   formula     = 0; // 0 = Clifford, 1 = de Jong

// --- Density buffer ---
int[]  density = new int[W * H];
PImage img;
float  hueShift = 0;


// ─────────────────────────────────────────────
//  SETUP
// ─────────────────────────────────────────────

void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 360, 100, 100);
  img = createImage(W, H, RGB);
  instantJump();
}


// ─────────────────────────────────────────────
//  PARAMETER CONTROL
// ─────────────────────────────────────────────

void instantJump() {
  pa = random(-2.2, 2.2);
  pb = random(-2.2, 2.2);
  pc = random(-2.2, 2.2);
  pd = random(-2.2, 2.2);
  ta = pa;
  tb = pb;
  tc = pc;
  td = pd;
  newTarget();
}

void newTarget() {
  ta = random(-2.2, 2.2);
  tb = random(-2.2, 2.2);
  tc = random(-2.2, 2.2);
  td = random(-2.2, 2.2);
  morphTimer = (int)random(200, 420);
}


// ─────────────────────────────────────────────
//  DRAW
// ─────────────────────────────────────────────

void draw() {
  // Smoothly chase target parameters
  pa = lerp(pa, ta, 0.007);
  pb = lerp(pb, tb, 0.007);
  pc = lerp(pc, tc, 0.007);
  pd = lerp(pd, td, 0.007);
  if (--morphTimer <= 0) newTarget();

  // Clear density buffer
  java.util.Arrays.fill(density, 0);

  // Iterate the attractor, accumulate point density
  float x = 0.01, y = 0.01;
  for (int i = 0; i < ITERS; i++) {
    float nx, ny;

    if (formula == 0) {
      // Clifford
      nx = sin(pa * y) + pc * cos(pa * x);
      ny = sin(pb * x) + pd * cos(pb * y);
    } else {
      // de Jong
      nx = sin(pa * y) - cos(pb * x);
      ny = sin(pc * x) - cos(pd * y);
    }

    // Guard against rare escapes in de Jong
    if (Float.isNaN(nx) || abs(nx) > 20) {
      x = random(-1, 1);
      y = random(-1, 1);
      continue;
    }

    int px = (int)(nx * SCL + OX);
    int py = (int)(ny * SCL + OY);
    if (px >= 0 && px < W && py >= 0 && py < H)
      density[py * W + px]++;

    x = nx;
    y = ny;
  }

  // Find peak density for log normalisation
  int peak = 1;
  for (int i = 0; i < W * H; i++) if (density[i] > peak) peak = density[i];
  float logPeak = log(peak + 1);

  // Render: density → brightness, screen angle → hue
  img.loadPixels();
  for (int px = 0; px < W; px++) {
    for (int py = 0; py < H; py++) {
      int   idx = py * W + px;
      int   cnt = density[idx];
      if (cnt == 0) {
        img.pixels[idx] = color(235, 38, 6);
        continue;
      }
      float t   = log(cnt + 1) / logPeak;                         // 0–1 log scale
      float hue = (degrees(atan2(py - OY, px - OX)) + 180 + hueShift) % 360;
      float sat = map(t, 0, 1, 82, 30);                           // desaturate dense core → white glow
      img.pixels[idx] = color(hue, sat, t * 100);
    }
  }
  img.updatePixels();
  image(img, 0, 0);

  hueShift = (hueShift + 0.35) % 360;

  // HUD
  fill(0, 0, 70, 80);
  noStroke();
  textAlign(LEFT);
  textSize(11);
  String fname = (formula == 0) ? "Clifford" : "de Jong";
  text("Space/R: new target   Click: jump   Tab: formula (" + fname + ")", 10, H - 10);
}


// ─────────────────────────────────────────────
//  INPUT
// ─────────────────────────────────────────────

void keyPressed() {
  if (key == ' ' || key == 'r' || key == 'R') newTarget();
  if (key == TAB) {
    formula = (formula + 1) % 2;
    instantJump();
  }
}

void mousePressed() {
  instantJump();
}
