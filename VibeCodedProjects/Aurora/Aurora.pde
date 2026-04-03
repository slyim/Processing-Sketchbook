/**
 * Aurora Borealis
 *
 * Three aurora ribbons — green, teal, violet — computed via per-column
 * Gaussian profiles driven by Perlin noise. Additive blending gives
 * authentic glow. A mountain silhouette grounds the scene.
 *
 * The aurora breathes, drifts, and shimmers on its own.
 * Press R to summon a different sky.
 */

final int W     = 800;
final int H     = 600;
final int STARS = 320;

// --- Star field ---
float[] starX  = new float[STARS];
float[] starY  = new float[STARS];
float[] starB  = new float[STARS]; // base brightness
float[] starPh = new float[STARS]; // twinkle phase offset

// --- Aurora pixel accumulators (linear light, 0–1 range) ---
float[] rBuf = new float[W * H];
float[] gBuf = new float[W * H];
float[] bBuf = new float[W * H];

// --- Terrain ---
float[] terrainY = new float[W];

PImage skyBg;     // static gradient background
PImage auroraImg; // rendered each frame

float t    = 0;
float seed = random(10000); // noise offset — change with R

void setup() {
  size(800, 600, P2D);
  colorMode(RGB, 255);

  auroraImg = createImage(W, H, ARGB);
  buildSky();
  buildTerrain();

  for (int i = 0; i < STARS; i++) {
    starX[i]  = random(W);
    starY[i]  = random(H * 0.72);
    starB[i]  = random(0.4, 1.0);
    starPh[i] = random(TWO_PI);
  }
}

// ─────────────────────────────────────────────
//  DRAW
// ─────────────────────────────────────────────

void draw() {
  // Sky gradient base
  image(skyBg, 0, 0);

  // Stars with gentle twinkle
  blendMode(ADD);
  noStroke();
  for (int i = 0; i < STARS; i++) {
    float twinkle = 0.65 + 0.35 * sin(t * 2.5 + starPh[i]);
    int   b       = (int)(starB[i] * twinkle * 255);
    fill(b / 4, b / 4, b / 3, 50);
    ellipse(starX[i], starY[i], 5, 5);
    fill(b, b, min(b + 30, 255), 220);
    ellipse(starX[i], starY[i], 1.5, 1.5);
  }
  blendMode(BLEND);

  // Aurora ribbons
  computeAurora();
  blendMode(ADD);
  image(auroraImg, 0, 0);
  blendMode(BLEND);

  // Mountain silhouette
  fill(4, 10, 20);
  noStroke();
  beginShape();
  vertex(0, H);
  for (int x = 0; x < W; x++) vertex(x, terrainY[x]);
  vertex(W, H);
  endShape(CLOSE);

  // Ground fog — softens the terrain base
  for (int y = (int)(H * 0.82); y < H; y++) {
    float fogT = map(y, H * 0.82, H, 0, 1);
    fill(3, 8, 18, (int)(fogT * 190));
    rect(0, y, W, 1);
  }

  t += 0.007;
}

// ─────────────────────────────────────────────
//  AURORA COMPUTATION
// ─────────────────────────────────────────────

void computeAurora() {
  java.util.Arrays.fill(rBuf, 0);
  java.util.Arrays.fill(gBuf, 0);
  java.util.Arrays.fill(bBuf, 0);

  // Whole-aurora breathing pulse
  float pulse = 0.75 + 0.25 * sin(t * 0.45);

  addRibbon(0.05, 1.00, 0.18, seed,        t, 0.55 * pulse); // green  (dominant)
  addRibbon(0.00, 0.60, 0.85, seed + 3000, t, 0.28 * pulse); // teal   (mid layer)
  addRibbon(0.60, 0.04, 0.90, seed + 6000, t, 0.18 * pulse); // violet (high, faint)

  auroraImg.loadPixels();
  for (int i = 0; i < W * H; i++) {
    auroraImg.pixels[i] = color(
      (int)min(rBuf[i] * 255, 255),
      (int)min(gBuf[i] * 255, 255),
      (int)min(bBuf[i] * 255, 255),
      255
    );
  }
  auroraImg.updatePixels();
}

// Draw one aurora ribbon layer into the RGB accumulators.
// cr/cg/cb: base color; nOff: noise space offset; time: current time; maxBright: peak amplitude.
void addRibbon(float cr, float cg, float cb, float nOff, float time, float maxBright) {
  for (int x = 0; x < W; x++) {
    // Ribbon center: slow broad drift + fine vertical ray shimmer
    float cy = H * 0.17
             + noise(x * 0.003 + nOff, time * 0.35) * H * 0.20  // broad wave
             + noise(x * 0.026 + nOff + 500, time * 1.4) * 20;  // fine rays

    float rh  = 52 + noise(x * 0.005 + nOff + 1000, time * 0.22) * 95; // ribbon half-height
    float amp = noise(x * 0.009 + nOff + 2000, time * 0.65) * maxBright;

    int yStart = max(0, (int)(cy - rh * 2.3));
    int yEnd   = min(H, (int)(cy + rh * 2.3));

    for (int y = yStart; y < yEnd; y++) {
      float dy = (y - cy) / rh;
      // Smooth parabolic falloff — fast, no exp() needed
      float n       = max(0.0, 1.0 - dy * dy * 0.44);
      float falloff = n * n;
      float intensity = falloff * amp;

      int idx = y * W + x;
      rBuf[idx] += cr * intensity;
      gBuf[idx] += cg * intensity;
      bBuf[idx] += cb * intensity;
    }
  }
}

// ─────────────────────────────────────────────
//  SCENE BUILDERS (called once)
// ─────────────────────────────────────────────

void buildSky() {
  skyBg = createImage(W, H, RGB);
  skyBg.loadPixels();
  for (int y = 0; y < H; y++) {
    float yf = y / (float)H;
    int r = (int)lerp(1,  6, yf);
    int g = (int)lerp(4, 14, yf);
    int b = (int)lerp(16, 28, yf);
    for (int x = 0; x < W; x++)
      skyBg.pixels[y * W + x] = color(r, g, b);
  }
  skyBg.updatePixels();
}

void buildTerrain() {
  // Multi-ridge noise mountain silhouette
  for (int x = 0; x < W; x++) {
    float nx = x * 0.006;
    float h  = noise(nx + seed * 0.1)         * 0.55  // broad ridges
             + noise(nx * 2.8 + seed * 0.1)   * 0.28  // mid detail
             + noise(nx * 8.0 + seed * 0.1)   * 0.10  // fine peaks
             + noise(nx * 20  + seed * 0.1)   * 0.07; // micro roughness
    terrainY[x] = H * 0.66 + h * H * 0.11;
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    seed = random(10000);
    t    = random(100);
    buildTerrain();
    buildSky();
  }
}
