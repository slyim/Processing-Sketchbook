/**
 * Physarum Polycephalum — Slime Mold Simulation
 *
 * Hundreds of thousands of agents sense chemical trails left by others,
 * steer toward stronger concentrations, and deposit more trail as they move.
 * No global coordination — the filamentous networks emerge from local rules.
 *
 * Controls:
 *   1-4        : spawn shape (disk, ring, scatter, two blobs)
 *   R          : respawn current shape
 *   Click/Drag : paint food (bright trail that attracts agents)
 *   ↑ / ↓     : widen / narrow sensor angle
 *   ← / →     : decrease / increase rotation angle
 *   + / -      : slower / faster trail decay
 */

// --- Simulation Constants ---
final int W = 800;
final int H = 600;
final int N = 200000;   // agent count
final float DEPOSIT = 5.0;

// --- Agent State (flat arrays for performance) ---
float[] ax = new float[N];
float[] ay = new float[N];
float[] aa = new float[N]; // heading angle

// --- Trail Grid ---
float[] trail = new float[W * H];
float[] blurBuf = new float[W * H];

// --- Tunable Parameters ---
float SA = PI / 4;    // sensor angle offset from heading
float SD = 9.0;       // sensor distance (pixels)
float RA = PI / 4;    // rotation angle per step
float SS = 1.5;       // step size (pixels)
float decay = 0.965;  // trail multiplier per frame (closer to 1 = longer trails)

// --- Display ---
PImage canvas;
float hueBase = 190; // starting hue for the color cycle
int spawnMode = 1;


// ─────────────────────────────────────────────
//  SETUP
// ─────────────────────────────────────────────

void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 360, 100, 100);
  canvas = createImage(W, H, RGB);
  spawn(1);
}


// ─────────────────────────────────────────────
//  MAIN LOOP
// ─────────────────────────────────────────────

void draw() {
  simulate();
  diffuseAndDecay();
  render();
  hueBase = (hueBase + 0.2) % 360;
}


// ─────────────────────────────────────────────
//  SPAWN SHAPES
// ─────────────────────────────────────────────

void spawn(int mode) {
  spawnMode = mode;
  for (int i = 0; i < W * H; i++) trail[i] = 0;

  float cx = W * 0.5, cy = H * 0.5;
  float minDim = min(W, H);

  for (int i = 0; i < N; i++) {
    float angle = random(TWO_PI);
    float r;

    switch (mode) {

      case 1: // Disk — colony growing outward
        r = random(minDim * 0.25);
        ax[i] = cx + cos(angle) * r;
        ay[i] = cy + sin(angle) * r;
        aa[i] = angle; // face outward
        break;

      case 2: // Ring — inward/outward tension produces tight web
        r = minDim * 0.35 + random(-10, 10);
        ax[i] = cx + cos(angle) * r;
        ay[i] = cy + sin(angle) * r;
        aa[i] = angle;
        break;

      case 3: // Scatter — fills screen with freeform net
        ax[i] = random(W);
        ay[i] = random(H);
        aa[i] = random(TWO_PI);
        break;

      case 4: // Two blobs — watch them discover each other and merge
        if (i < N / 2) {
          r = random(minDim * 0.15);
          ax[i] = W * 0.25 + cos(angle) * r;
          ay[i] = cy    + sin(angle) * r;
          aa[i] = angle;
        } else {
          r = random(minDim * 0.15);
          ax[i] = W * 0.75 + cos(angle) * r;
          ay[i] = cy       + sin(angle) * r;
          aa[i] = angle;
        }
        break;
    }
  }
}


// ─────────────────────────────────────────────
//  AGENT UPDATE
// ─────────────────────────────────────────────

// Read trail at a position offset from (x,y) by distance SD along angle a.
// Wraps toroidally so agents never hit a wall.
float sense(float x, float y, float a) {
  int sx = ((int)(x + cos(a) * SD) + W) % W;
  int sy = ((int)(y + sin(a) * SD) + H) % H;
  return trail[sy * W + sx];
}

void simulate() {
  for (int i = 0; i < N; i++) {
    float x = ax[i], y = ay[i], a = aa[i];

    float fwd = sense(x, y, a);
    float lft = sense(x, y, a + SA);
    float rgt = sense(x, y, a - SA);

    if (fwd >= lft && fwd >= rgt) {
      // Straight ahead is best — keep heading
    } else if (lft > rgt) {
      aa[i] += RA;                           // turn left
    } else if (rgt > lft) {
      aa[i] -= RA;                           // turn right
    } else {
      aa[i] += (random(1) < 0.5 ? 1 : -1) * RA; // tied — random turn
    }

    // Step forward and wrap
    ax[i] = (x + cos(aa[i]) * SS + W) % W;
    ay[i] = (y + sin(aa[i]) * SS + H) % H;

    // Deposit trail
    int idx = (int)ay[i] * W + (int)ax[i];
    trail[idx] = min(trail[idx] + DEPOSIT, 255);
  }
}


// ─────────────────────────────────────────────
//  TRAIL DIFFUSION + DECAY
// ─────────────────────────────────────────────

// 3×3 box blur spreads the chemical, then multiply by decay factor.
// Border pixels are left as-is (toroidal agent wrapping means they
// accumulate very little trail anyway).
void diffuseAndDecay() {
  for (int x = 1; x < W - 1; x++) {
    for (int y = 1; y < H - 1; y++) {
      float sum =
        trail[(y-1)*W + (x-1)] + trail[(y-1)*W + x] + trail[(y-1)*W + (x+1)] +
        trail[ y   *W + (x-1)] + trail[ y   *W + x] + trail[ y   *W + (x+1)] +
        trail[(y+1)*W + (x-1)] + trail[(y+1)*W + x] + trail[(y+1)*W + (x+1)];
      blurBuf[y*W + x] = (sum / 9.0) * decay;
    }
  }
  // Swap buffers
  float[] tmp = trail;
  trail = blurBuf;
  blurBuf = tmp;
}


// ─────────────────────────────────────────────
//  RENDER
// ─────────────────────────────────────────────

void render() {
  canvas.loadPixels();
  for (int i = 0; i < W * H; i++) {
    float t = trail[i] / 255.0;             // normalize 0→1
    float h = (hueBase + t * 80) % 360;    // hue shifts with concentration
    float s = map(t, 0, 1, 0, 88);         // desaturate at zero (black bg)
    float b = map(sqrt(t), 0, 1, 0, 100);  // sqrt brightens dim filaments
    canvas.pixels[i] = color(h, s, b);
  }
  canvas.updatePixels();
  image(canvas, 0, 0);

  // HUD
  fill(0, 0, 100, 150);
  noStroke();
  textAlign(LEFT);
  textSize(11);
  text(
    "SA=" + nf(degrees(SA), 2, 0) + "°  " +
    "RA=" + nf(degrees(RA), 2, 0) + "°  " +
    "decay=" + nf(decay, 1, 3) +
    "    1-4: spawn    R: reset    drag: paint food    ↑↓: SA    ←→: RA    +/-: decay",
    8, H - 8
  );
}


// ─────────────────────────────────────────────
//  INTERACTION
// ─────────────────────────────────────────────

// Paint a circular patch of high trail value — agents flood toward it.
void paintFood(int mx, int my) {
  int r = 12;
  for (int dx = -r; dx <= r; dx++) {
    for (int dy = -r; dy <= r; dy++) {
      if (dx*dx + dy*dy <= r*r) {
        int px = constrain(mx + dx, 0, W - 1);
        int py = constrain(my + dy, 0, H - 1);
        trail[py * W + px] = min(trail[py * W + px] + 30, 255);
      }
    }
  }
}

void mouseDragged() { paintFood(mouseX, mouseY); }
void mousePressed()  { paintFood(mouseX, mouseY); }

void keyPressed() {
  if (key >= '1' && key <= '4')  spawn(key - '0');
  if (key == 'r' || key == 'R')  spawn(spawnMode);
  if (keyCode == UP)    SA = constrain(SA + radians(5), radians(5),  radians(90));
  if (keyCode == DOWN)  SA = constrain(SA - radians(5), radians(5),  radians(90));
  if (keyCode == RIGHT) RA = constrain(RA + radians(5), radians(5),  radians(90));
  if (keyCode == LEFT)  RA = constrain(RA - radians(5), radians(5),  radians(90));
  if (key == '+' || key == '=') decay = constrain(decay + 0.005, 0.80, 0.999);
  if (key == '-')               decay = constrain(decay - 0.005, 0.80, 0.999);
}
