/**
 * Ink Drift — Zen Flow Field
 *
 * Particles drift through a Perlin noise current, leaving faint traces
 * that dissolve like ink in still water. The field shifts too slowly
 * to perceive directly — just watch.
 *
 * Click / Space : clear canvas
 * R             : reset everything
 */

final int   N        = 7000;
final float SCALE    = 0.0028;  // noise zoom — larger = tighter swirls
final float SPEED    = 1.6;     // pixels per frame
final float FADE_A   = 5;       // canvas fade alpha (lower = longer trails)
final float STROKE_A = 30;      // particle opacity

float[] px = new float[N];
float[] py = new float[N];

float noiseT  = 0;
float hueBase = 185;

void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  background(220, 22, 7);
  for (int i = 0; i < N; i++) resetParticle(i);
}

void draw() {
  // Slowly fade previous frame to create long, dissolving trails
  noStroke();
  fill(220, 22, 7, FADE_A);
  rect(0, 0, width, height);

  strokeWeight(1.1);

  for (int i = 0; i < N; i++) {
    // Map noise sample → heading angle
    float angle = noise(px[i] * SCALE, py[i] * SCALE, noiseT) * TWO_PI * 2.4;
    float nx    = px[i] + cos(angle) * SPEED;
    float ny    = py[i] + sin(angle) * SPEED;

    // Respawn when out of bounds or occasionally at random (keeps density even)
    if (nx < 0 || nx > width || ny < 0 || ny > height || random(1) < 0.0008) {
      resetParticle(i);
      continue;
    }

    // Hue drifts slowly with position and time — keeps it near-monochrome but alive
    float h = (hueBase + noise(px[i] * SCALE * 0.5, py[i] * SCALE * 0.5, noiseT * 0.4) * 65) % 360;
    stroke(h, 38, 80, STROKE_A);
    line(px[i], py[i], nx, ny);

    px[i] = nx;
    py[i] = ny;
  }

  // Field evolves imperceptibly slowly — this is the whole point
  noiseT  += 0.0013;
  hueBase  = (hueBase + 0.04) % 360;
}

void resetParticle(int i) {
  px[i] = random(width);
  py[i] = random(height);
}

void mousePressed() { background(220, 22, 7); }

void keyPressed() {
  if (key == ' ')               background(220, 22, 7);
  if (key == 'r' || key == 'R') {
    background(220, 22, 7);
    for (int i = 0; i < N; i++) resetParticle(i);
    noiseT = 0;
  }
}
