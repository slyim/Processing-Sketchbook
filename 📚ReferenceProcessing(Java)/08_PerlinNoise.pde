// =============================================================
// 08_PerlinNoise — Processing Reference
// =============================================================
// Covers:
//   noise(x)            — 1D Perlin noise (0.0 → 1.0)
//   noise(x, y)         — 2D noise (for textures / fields)
//   noise(x, y, z)      — 3D noise (animate 2D noise over time)
//   noiseDetail(lod, falloff) — control octaves and roughness
//   noiseSeed(seed)     — reproducible results
//   Difference: noise() vs random()
//   Common uses: flow field, terrain, organic motion, texture
// =============================================================

float t = 0;             // time offset for animation
float noiseScale = 0.008; // how "zoomed in" the noise field is

// Flow field particles
int PARTICLE_COUNT = 400;
float[] px = new float[PARTICLE_COUNT];
float[] py = new float[PARTICLE_COUNT];
float[] page = new float[PARTICLE_COUNT]; // lifetime

PGraphics noiseCanvas; // persistent draw surface for particle trails

void setup() {
  size(900, 620);
  noiseDetail(4, 0.5); // 4 octaves, 0.5 falloff (smoother = lower falloff)

  // Initialize particles at random positions
  for (int i = 0; i < PARTICLE_COUNT; i++) {
    resetParticle(i);
    page[i] = random(200); // stagger lifetimes
  }

  // PGraphics canvas: particles draw on this persistently (no background clear)
  noiseCanvas = createGraphics(width, height);
  noiseCanvas.beginDraw();
  noiseCanvas.background(22, 22, 30);
  noiseCanvas.endDraw();
}

void draw() {
  // ── Slowly fade the persistent canvas ────────────────────
  noiseCanvas.beginDraw();
  noiseCanvas.fill(22, 22, 30, 18); // low alpha = long trail
  noiseCanvas.noStroke();
  noiseCanvas.rect(0, 0, width, height);

  // Update and draw each particle on the noise canvas
  for (int i = 0; i < PARTICLE_COUNT; i++) {
    // 3D noise: x and y determine position in the field,
    //           t slowly drifts the field over time
    float angle = noise(px[i] * noiseScale, py[i] * noiseScale, t) * TWO_PI * 2;

    float speed = 2.5;
    float nx = px[i] + cos(angle) * speed;
    float ny = py[i] + sin(angle) * speed;

    // Color from hue = angle direction
    float hue = map(angle % TWO_PI, 0, TWO_PI, 0, 360);
    noiseCanvas.colorMode(HSB, 360, 100, 100);
    noiseCanvas.stroke(hue, 70, 90, 180);
    noiseCanvas.strokeWeight(1.2);
    noiseCanvas.line(px[i], py[i], nx, ny);
    noiseCanvas.colorMode(RGB);

    px[i] = nx;
    py[i] = ny;
    page[i]++;

    // Reset if out of bounds or too old
    if (px[i] < 0 || px[i] > width || py[i] < 0 || py[i] > height || page[i] > 300) {
      resetParticle(i);
    }
  }
  noiseCanvas.endDraw();

  // Draw the noise canvas to screen
  image(noiseCanvas, 0, 0);

  t += 0.003; // advance time slowly

  // ── HUD panels ───────────────────────────────────────────
  // Panel 1: noise() vs random() comparison
  fill(10, 10, 20, 200);
  noStroke();
  rect(20, 20, 300, 180, 8);

  fill(255, 210, 80); textSize(13);
  text("noise(x)  vs  random()", 35, 45);

  // noise() line — smooth
  stroke(100, 200, 255);
  strokeWeight(2);
  noFill();
  beginShape();
  for (int x = 0; x < 130; x++) {
    float v = noise(x * 0.08 + t * 5) * 80;
    vertex(35 + x, 170 - v);
  }
  endShape();

  // random() line — jagged
  stroke(255, 120, 80);
  beginShape();
  for (int x = 0; x < 130; x++) {
    float v = random(80); // new random every frame — very noisy
    vertex(175 + x, 170 - v);
  }
  endShape();

  fill(100, 200, 255); textSize(10);
  text("noise() — smooth", 35, 185);
  fill(255, 120, 80);
  text("random() — chaotic", 175, 185);

  // Panel 2: 2D noise texture
  fill(10, 10, 20, 200);
  noStroke();
  rect(20, 220, 300, 200, 8);

  fill(255, 210, 80); textSize(13);
  text("noise(x, y, t)  — 2D texture", 35, 245);

  int texSize = 80; // pixel grid
  int cellPx = 3;   // pixels per cell
  noStroke();
  for (int ty = 0; ty < texSize; ty++) {
    for (int tx = 0; tx < texSize; tx++) {
      float v = noise(tx * 0.08, ty * 0.08, t * 2);
      float bright = v * 255;
      fill(bright * 0.4, bright * 0.7, bright);
      rect(35 + tx * cellPx, 255 + ty * cellPx, cellPx, cellPx);
    }
  }

  // Panel 3: noiseDetail
  fill(10, 10, 20, 200);
  noStroke();
  rect(20, 440, 300, 160, 8);

  fill(255, 210, 80); textSize(13);
  text("noiseDetail(lod, falloff)", 35, 465);

  // Low detail (1 octave) vs high detail (6 octaves)
  drawNoiseWave(35, 530, 120, 1, 0.5, color(255, 180, 60));
  drawNoiseWave(165, 530, 120, 6, 0.5, color(100, 220, 140));

  fill(255, 180, 60); textSize(10); text("lod=1 (smooth)", 35, 550);
  fill(100, 220, 140);              text("lod=6 (detailed)", 165, 550);

  // Controls label
  fill(120); textSize(10); noStroke();
  text("SPACE: clear canvas   +/-: noise scale = " + nf(noiseScale, 0, 4), 35, 605);
}

void resetParticle(int i) {
  px[i] = random(width);
  py[i] = random(height);
  page[i] = 0;
}

void drawNoiseWave(float ox, float oy, int len, int lod, float falloff, color c) {
  noiseDetail(lod, falloff);
  stroke(c);
  strokeWeight(1.5);
  noFill();
  beginShape();
  for (int x = 0; x < len; x++) {
    float v = noise(x * 0.12 + t * 3) * 40;
    vertex(ox + x, oy - v);
  }
  endShape();
  noiseDetail(4, 0.5); // reset
}

void keyPressed() {
  if (key == ' ') {
    noiseCanvas.beginDraw();
    noiseCanvas.background(22, 22, 30);
    noiseCanvas.endDraw();
    for (int i = 0; i < PARTICLE_COUNT; i++) resetParticle(i);
  }
  if (key == '+' || key == '=') noiseScale = min(noiseScale * 1.3, 0.1);
  if (key == '-')               noiseScale = max(noiseScale / 1.3, 0.001);
}
