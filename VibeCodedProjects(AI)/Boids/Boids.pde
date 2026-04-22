/**
 * Boids — Emergent Flocking
 *
 * Three local rules produce a coherent flock from 350 independent agents:
 *   Separation : steer away from neighbours that are too close
 *   Alignment  : match the average heading of nearby neighbours
 *   Cohesion   : drift toward the average position of nearby neighbours
 *
 * Move the mouse near the flock to scatter it — agents perceive the cursor
 * as a predator and flee. Hold mouse button to attract instead.
 *
 * Thin lines connect agents within sensing range, echoing MagicalWeb's
 * visual language. Trails fade slowly on the dark canvas.
 *
 * +/- : more/fewer boids     Space : scatter     F : toggle connections
 */

final int   MAX_BOIDS      = 600;
final float MAX_SPEED      = 3.2;
final float MAX_FORCE      = 0.10;
final float SIGHT_RADIUS   = 60;
final float SEP_RADIUS     = 22;
final float PRED_RADIUS    = 120;
final float TRAIL_ALPHA    = 18;  // canvas fade per frame — controls trail length
final float CONN_DIST      = 55;

int   numBoids     = 350;
boolean showLines  = true;

float[] bx, by;     // position
float[] vx, vy;     // velocity
float[] hues;       // per-boid cycling hue


// ─────────────────────────────────────────────
//  SETUP
// ─────────────────────────────────────────────

void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  background(225, 30, 7);

  bx   = new float[MAX_BOIDS];
  by   = new float[MAX_BOIDS];
  vx   = new float[MAX_BOIDS];
  vy   = new float[MAX_BOIDS];
  hues = new float[MAX_BOIDS];

  for (int i = 0; i < MAX_BOIDS; i++) spawnBoid(i);
}

void spawnBoid(int i) {
  bx[i]   = random(width);
  by[i]   = random(height);
  float a = random(TWO_PI);
  vx[i]   = cos(a) * random(1, MAX_SPEED);
  vy[i]   = sin(a) * random(1, MAX_SPEED);
  hues[i] = random(360);
}


// ─────────────────────────────────────────────
//  DRAW
// ─────────────────────────────────────────────

void draw() {
  // Slowly fade previous frame → produces trails
  noStroke();
  fill(225, 30, 7, TRAIL_ALPHA);
  rect(0, 0, width, height);

  blendMode(ADD);

  updateBoids();

  // Draw connections between close neighbours
  if (showLines) {
    strokeWeight(0.8);
    for (int i = 0; i < numBoids; i++) {
      for (int j = i + 1; j < numBoids; j++) {
        float dx = bx[j] - bx[i];
        float dy = by[j] - by[i];
        float d  = sqrt(dx*dx + dy*dy);
        if (d < CONN_DIST) {
          float alpha = map(d, 0, CONN_DIST, 45, 0);
          float avgH  = wrapAvgHue(hues[i], hues[j]);
          stroke(avgH, 35, 88, alpha);
          line(bx[i], by[i], bx[j], by[j]);
        }
      }
    }
  }

  // Draw boids as small oriented triangles
  noStroke();
  for (int i = 0; i < numBoids; i++) {
    float h = hues[i];
    pushMatrix();
    translate(bx[i], by[i]);
    rotate(atan2(vy[i], vx[i]));
    fill(h, 55, 95, 85);
    triangle(7, 0, -4, -3, -4, 3);    // narrow arrowhead
    fill(h, 25, 100, 40);
    triangle(10, 0, -6, -5, -6, 5);   // glow halo
    popMatrix();

    hues[i] = (hues[i] + 0.18) % 360;
  }

  blendMode(BLEND);

  // HUD
  fill(0, 0, 70, 80);
  noStroke();
  textAlign(LEFT);
  textSize(11);
  text("n=" + numBoids + "   +/-: boids   Space: scatter   F: connections   Mouse: predator / [held] attractor", 8, height - 8);
}


// ─────────────────────────────────────────────
//  BOID PHYSICS
// ─────────────────────────────────────────────

void updateBoids() {
  float[] ax = new float[numBoids]; // acceleration x
  float[] ay = new float[numBoids]; // acceleration y

  for (int i = 0; i < numBoids; i++) {
    // Accumulators for the three rules
    float sepX = 0, sepY = 0, sepCnt = 0;
    float aliX = 0, aliY = 0;
    float cohX = 0, cohY = 0, cohCnt = 0;

    for (int j = 0; j < numBoids; j++) {
      if (i == j) continue;
      float dx = bx[j] - bx[i];
      float dy = by[j] - by[i];
      float d  = sqrt(dx*dx + dy*dy);

      if (d < SIGHT_RADIUS) {
        // Cohesion + alignment
        cohX += bx[j]; cohY += by[j]; cohCnt++;
        aliX += vx[j]; aliY += vy[j];

        // Separation
        if (d < SEP_RADIUS && d > 0) {
          sepX -= dx / d; sepY -= dy / d; sepCnt++;
        }
      }
    }

    // Separation force
    if (sepCnt > 0) {
      float f = steer(sepX / sepCnt, sepY / sepCnt, vx[i], vy[i]);
      ax[i] += (sepX / sepCnt) * f * 1.6;
      ay[i] += (sepY / sepCnt) * f * 1.6;
    }

    if (cohCnt > 0) {
      // Cohesion: steer toward average position
      float dcx = cohX / cohCnt - bx[i];
      float dcy = cohY / cohCnt - by[i];
      addSteer(ax, ay, i, dcx, dcy, vx[i], vy[i], 0.9);

      // Alignment: match average velocity
      addSteer(ax, ay, i, aliX / cohCnt, aliY / cohCnt, vx[i], vy[i], 1.0);
    }

    // Predator avoidance / attraction
    float pdx = mouseX - bx[i];
    float pdy = mouseY - by[i];
    float pd  = sqrt(pdx*pdx + pdy*pdy);
    if (pd < PRED_RADIUS && pd > 0) {
      float strength = map(pd, 0, PRED_RADIUS, 3.0, 0);
      if (mousePressed) {
        // Attract toward mouse
        ax[i] += (pdx / pd) * strength * MAX_FORCE * 2;
        ay[i] += (pdy / pd) * strength * MAX_FORCE * 2;
      } else {
        // Flee from mouse
        ax[i] -= (pdx / pd) * strength * MAX_FORCE * 3;
        ay[i] -= (pdy / pd) * strength * MAX_FORCE * 3;
      }
    }
  }

  // Integrate and wrap
  for (int i = 0; i < numBoids; i++) {
    vx[i] += ax[i]; vy[i] += ay[i];
    limitSpeed(i);
    bx[i] = (bx[i] + vx[i] + width)  % width;
    by[i] = (by[i] + vy[i] + height) % height;
  }
}

// Returns a scaled steering force magnitude toward (tx,ty)
float steer(float tx, float ty, float cvx, float cvy) {
  float len = sqrt(tx*tx + ty*ty);
  return (len > 0) ? MAX_FORCE / len : 0;
}

// Adds a capped steering force toward (tx,ty) to acceleration array
void addSteer(float[] ax, float[] ay, int i, float tx, float ty, float cvx, float cvy, float weight) {
  float len = sqrt(tx*tx + ty*ty);
  if (len == 0) return;
  float scale = MAX_FORCE * weight / len;
  ax[i] += tx * scale;
  ay[i] += ty * scale;
}

void limitSpeed(int i) {
  float spd = sqrt(vx[i]*vx[i] + vy[i]*vy[i]);
  if (spd > MAX_SPEED) {
    vx[i] = vx[i] / spd * MAX_SPEED;
    vy[i] = vy[i] / spd * MAX_SPEED;
  }
  // Minimum speed so boids don't stall
  if (spd > 0 && spd < 0.8) {
    vx[i] = vx[i] / spd * 0.8;
    vy[i] = vy[i] / spd * 0.8;
  }
}

// Circular mean for hue averaging (avoids 0/360 wrap artefacts)
float wrapAvgHue(float h1, float h2) {
  float diff = abs(h1 - h2);
  float avg  = (h1 + h2) / 2.0;
  if (diff > 180) avg = (avg + 180) % 360;
  return avg;
}


// ─────────────────────────────────────────────
//  INPUT
// ─────────────────────────────────────────────

void keyPressed() {
  if (key == '+' || key == '=') {
    if (numBoids < MAX_BOIDS) { spawnBoid(numBoids); numBoids++; }
  }
  if (key == '-') {
    if (numBoids > 10) numBoids--;
  }
  if (key == ' ') {
    // Scatter: randomise all velocities
    for (int i = 0; i < numBoids; i++) {
      float a = random(TWO_PI);
      vx[i] = cos(a) * MAX_SPEED;
      vy[i] = sin(a) * MAX_SPEED;
    }
  }
  if (key == 'f' || key == 'F') showLines = !showLines;
}
