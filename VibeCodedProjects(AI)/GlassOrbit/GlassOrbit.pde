/**
 * Glass Orbit
 *
 * A ring of luminous shards orbits a soft core while each shard also follows
 * its own tiny epicycle. The result feels part chandelier, part sci-fi
 * stained glass. Mouse movement tilts the whole structure in 3D space.
 *
 * Mouse         : tilt the sculpture
 * Space / R     : generate a new orbit
 * 1 / 2 / 3     : switch orbit density
 */

final int W = 800;
final int H = 600;
final int MAX_SHARDS = 220;

float[] baseAngle = new float[MAX_SHARDS];
float[] orbitRadius = new float[MAX_SHARDS];
float[] shardSize = new float[MAX_SHARDS];
float[] hueOffset = new float[MAX_SHARDS];
float[] spinRate = new float[MAX_SHARDS];
float[] wobble = new float[MAX_SHARDS];

int shardCount = 140;
float masterHue;
float orbitSeed;
float t;

void settings() {
  size(W, H, P3D);
  smooth(8);
}

void setup() {
  colorMode(HSB, 360, 100, 100, 100);
  regenerate();
}

void draw() {
  background(214, 34, 7);

  float rotY = map(mouseX, 0, width, -0.65, 0.65);
  float rotX = map(mouseY, 0, height, 0.55, -0.55);

  blendMode(ADD);
  pushMatrix();
  translate(width * 0.5, height * 0.5, -120);
  rotateX(rotX);
  rotateY(rotY + t * 0.12);
  rotateZ(sin(t * 0.4) * 0.18);

  drawCoreGlow();

  for (int i = 0; i < shardCount; i++) {
    float a = baseAngle[i] + t * spinRate[i];
    float r = orbitRadius[i] + sin(t * 1.5 + wobble[i]) * 16;
    float ex = cos(a * 3.0 + wobble[i]) * shardSize[i] * 0.7;
    float ey = sin(a * 2.4 - wobble[i]) * shardSize[i] * 0.7;

    float x = cos(a) * r + ex;
    float y = sin(a) * r * 0.56 + ey;
    float z = sin(a * 1.7 + wobble[i]) * 90;

    pushMatrix();
    translate(x, y, z);
    rotateZ(a + wobble[i]);
    rotateX(sin(t + wobble[i]) * 0.5);
    drawShard(i);
    popMatrix();
  }

  drawOrbitThreads();
  popMatrix();
  blendMode(BLEND);

  drawHud();

  t += 0.012;
}

void regenerate() {
  orbitSeed = random(10000);
  masterHue = random(360);
  t = random(200);

  for (int i = 0; i < MAX_SHARDS; i++) {
    baseAngle[i] = random(TWO_PI);
    orbitRadius[i] = random(110, 250);
    shardSize[i] = random(8, 24);
    hueOffset[i] = random(-35, 35);
    spinRate[i] = random(0.08, 0.24) * (random(1) < 0.5 ? -1 : 1);
    wobble[i] = random(TWO_PI);
  }
}

void drawCoreGlow() {
  noStroke();
  for (int i = 0; i < 4; i++) {
    float radius = 180 - i * 34 + sin(t * 0.8 + i) * 10;
    fill((masterHue + i * 12) % 360, 24, 40 + i * 10, 6 + i * 3);
    ellipse(0, 0, radius, radius);
  }
}

void drawShard(int i) {
  float h = (masterHue + hueOffset[i] + sin(t * 0.9 + i) * 18 + 360) % 360;
  float s = 30 + noise(orbitSeed + i * 0.1, t * 0.2) * 36;
  float b = 70 + noise(orbitSeed + i * 0.2, t * 0.35) * 30;
  float size = shardSize[i];

  noStroke();
  fill(h, s, b, 30);
  beginShape();
  vertex(-size * 1.2, 0, 0);
  vertex(-size * 0.2, -size * 0.38, size * 0.2);
  vertex(size * 1.1, 0, 0);
  vertex(-size * 0.2, size * 0.38, -size * 0.2);
  endShape(CLOSE);

  stroke(h, 38, 100, 42);
  strokeWeight(1.0);
  line(-size * 1.2, 0, 0, size * 1.1, 0, 0);
}

void drawOrbitThreads() {
  strokeWeight(0.65);
  for (int i = 0; i < shardCount; i++) {
    int j = (i + 1) % shardCount;

    float a1 = baseAngle[i] + t * spinRate[i];
    float a2 = baseAngle[j] + t * spinRate[j];

    float r1 = orbitRadius[i] + sin(t * 1.5 + wobble[i]) * 16;
    float r2 = orbitRadius[j] + sin(t * 1.5 + wobble[j]) * 16;

    float x1 = cos(a1) * r1;
    float y1 = sin(a1) * r1 * 0.56;
    float z1 = sin(a1 * 1.7 + wobble[i]) * 90;

    float x2 = cos(a2) * r2;
    float y2 = sin(a2) * r2 * 0.56;
    float z2 = sin(a2 * 1.7 + wobble[j]) * 90;

    float h = (masterHue + (hueOffset[i] + hueOffset[j]) * 0.5 + 360) % 360;
    stroke(h, 20, 80, 13);
    line(x1, y1, z1, x2, y2, z2);
  }
}

void drawHud() {
  hint(DISABLE_DEPTH_TEST);
  noStroke();
  fill(0, 0, 72, 88);
  textAlign(LEFT);
  textSize(11);
  text("Space/R: new orbit    1/2/3: density (" + shardCount + ")    Mouse: tilt", 10, height - 10);
  hint(ENABLE_DEPTH_TEST);
}

void keyPressed() {
  if (key == ' ' || key == 'r' || key == 'R') regenerate();
  if (key == '1') {
    shardCount = 90;
    regenerate();
  }
  if (key == '2') {
    shardCount = 140;
    regenerate();
  }
  if (key == '3') {
    shardCount = 190;
    regenerate();
  }
}
