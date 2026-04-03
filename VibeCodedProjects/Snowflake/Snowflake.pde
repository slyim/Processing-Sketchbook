/**
 * Crystallographic Snowflake Generator
 *
 * Branches grow outward from the center using BFS, constrained to the
 * hexagonal crystal lattice (60° branching angles only). 6-fold rotational
 * symmetry is applied at render time, so one arm's geometry becomes the
 * whole snowflake.
 *
 * Shimmering HSB colors + additive blending — same visual language as
 * MagicalWeb. Each branch has a golden-angle phase offset so the shimmer
 * ripples independently across the crystal.
 *
 * Space / R     : grow a new snowflake
 * 3 / 4 / 5     : branch depth (complexity)
 * Mouse         : orbit camera
 */

// --- Crystal Data ---
class Seg {
  float x1, y1, x2, y2;
  int   depth;
  float hue;
}

class Platelet {
  float cx, cy, r, hue;
}

ArrayList<Seg>      segs  = new ArrayList<Seg>();
ArrayList<Platelet> tips  = new ArrayList<Platelet>();
ArrayList<float[]>  queue = new ArrayList<float[]>(); // BFS growth queue

// --- State ---
float rotX = 0, rotY = 0;
float hueShift = 0;
float armLen;
int   maxDepth = 4;

final int GROWTH_RATE = 2; // branch segments added to the crystal per frame
final float COS60 = 0.5;
final float SIN60 = 0.8660254;


// ─────────────────────────────────────────────
//  SETUP
// ─────────────────────────────────────────────

void setup() {
  size(800, 600, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  generate();
}


// ─────────────────────────────────────────────
//  GENERATION
// ─────────────────────────────────────────────

void generate() {
  segs.clear();
  tips.clear();
  queue.clear();
  armLen = random(100, 148);
  // Seed the BFS queue with one arm pointing along +X
  // Format: {fromX, fromY, dirX, dirY, length, depth}
  queue.add(new float[]{0, 0, 1, 0, armLen, maxDepth});
}

// Each frame: pop GROWTH_RATE items from the BFS queue,
// add the resulting segments/platelets, and enqueue children.
// The snowflake visibly grows from center outward.
void processGrowth() {
  for (int g = 0; g < GROWTH_RATE && !queue.isEmpty(); g++) {
    float[] item = queue.remove(0);
    float fx  = item[0], fy  = item[1];
    float dx  = item[2], dy  = item[3];
    float len = item[4];
    int   dep = (int)item[5];

    if (len < 4) continue;

    float tx = fx + dx * len;
    float ty = fy + dy * len;

    // Hue: main arm is warmer cyan, sub-branches shift to deeper blue
    float h = map(dep, 1, maxDepth, 215, 168) + random(-12, 12);

    Seg s = new Seg();
    s.x1 = fx; s.y1 = fy; s.x2 = tx; s.y2 = ty;
    s.depth = dep; s.hue = h;
    segs.add(s);

    if (dep <= 1) {
      // Leaf node: small hexagonal platelet at tip
      Platelet p = new Platelet();
      p.cx = tx; p.cy = ty; p.r = len * 0.21; p.hue = h + 18;
      tips.add(p);
      continue;
    }

    // Branch count: depth-1 gives 3, 2, 1 branch pairs for depths 4, 3, 2
    int nBranch = dep - 1;

    for (int i = 1; i <= nBranch; i++) {
      float t    = (float)i / (nBranch + 1) * 0.88 + 0.06; // keep away from endpoints
      float bLen = len * (1.0 - t * 0.20) * random(0.40, 0.54);
      if (bLen < 4) continue;

      float bx = fx + dx * len * t;
      float by = fy + dy * len * t;

      // Rotate direction ±60° — the hexagonal crystal lattice constraint
      float ldx =  dx * COS60 - dy * SIN60;
      float ldy =  dx * SIN60 + dy * COS60;
      float rdx =  dx * COS60 + dy * SIN60;
      float rdy = -dx * SIN60 + dy * COS60;

      queue.add(new float[]{bx, by, ldx, ldy, bLen, dep - 1});
      queue.add(new float[]{bx, by, rdx, rdy, bLen, dep - 1});
    }
  }
}


// ─────────────────────────────────────────────
//  DRAW
// ─────────────────────────────────────────────

void draw() {
  background(230, 40, 8);
  blendMode(ADD);

  // Mouse-driven orbit — exactly like MagicalWeb
  rotX += (mouseY - height / 2.0) * 0.0001;
  rotY += (mouseX - width  / 2.0) * 0.0001;

  processGrowth();
  hueShift = (hueShift + 0.25) % 360;

  // 3D scene
  pushMatrix();
    translate(width / 2.0, height / 2.0, 0);
    rotateX(-rotX);
    rotateY(rotY);

    // 6-fold symmetry: render one arm 6 times at 60° increments
    for (int arm = 0; arm < 6; arm++) {
      pushMatrix();
        rotateZ(arm * PI / 3.0);
        renderArm(arm);
      popMatrix();
    }

    renderCenter();
  popMatrix();

  blendMode(BLEND);

  // HUD — drawn after popMatrix so it's in flat screen space
  hint(DISABLE_DEPTH_TEST);
  fill(0, 0, 72, 90);
  noStroke();
  textAlign(LEFT);
  textSize(11);
  text("Space/R: new snowflake    3/4/5: depth (" + maxDepth + ")    Mouse: orbit", 10, height - 10);
  hint(ENABLE_DEPTH_TEST);
}


// ─────────────────────────────────────────────
//  RENDER: ARM + PLATELETS
// ─────────────────────────────────────────────

// Draw all segments and platelets for one arm copy.
// armIdx slightly offsets the hue per copy for extra color variety.
void renderArm(int armIdx) {
  for (int i = 0; i < segs.size(); i++) {
    Seg s = segs.get(i);

    // Golden-angle phase offset — each branch shimmers at its own rhythm
    float shimmer = sin(frameCount * 0.05 + i * 2.3998) * 18;
    float h  = (s.hue + hueShift + shimmer + armIdx * 4) % 360;
    float sw = map(s.depth, 1, maxDepth, 0.5, 2.8);
    float al = map(s.depth, 1, maxDepth, 40, 78);

    // Wide glow pass — creates the ice-crystal radiance
    stroke(h, 22, 90, al * 0.35);
    strokeWeight(sw * 4.5);
    line(s.x1, s.y1, 0, s.x2, s.y2, 0);

    // Sharp core pass
    stroke(h, 50, 98, al);
    strokeWeight(sw);
    line(s.x1, s.y1, 0, s.x2, s.y2, 0);
  }

  // Hexagonal tip platelets
  noFill();
  for (int i = 0; i < tips.size(); i++) {
    Platelet p = tips.get(i);
    float shimmer = sin(frameCount * 0.06 + (segs.size() + i) * 2.3998) * 18;
    float h = (p.hue + hueShift + shimmer) % 360;

    pushMatrix();
      translate(p.cx, p.cy, 0);

      // Glow hex
      stroke(h, 22, 90, 26);
      strokeWeight(3.5);
      beginShape();
      for (int v = 0; v < 6; v++) vertex(p.r * cos(v * PI/3), p.r * sin(v * PI/3), 0);
      endShape(CLOSE);

      // Core hex
      stroke(h, 52, 98, 58);
      strokeWeight(0.8);
      beginShape();
      for (int v = 0; v < 6; v++) vertex(p.r * cos(v * PI/3), p.r * sin(v * PI/3), 0);
      endShape(CLOSE);
    popMatrix();
  }
}


// ─────────────────────────────────────────────
//  RENDER: CENTER
// ─────────────────────────────────────────────

// Concentric hexagons at the hub where all 6 arms meet.
// With ADD blending, the overlapping arms already make this very bright —
// these rings add structure to the center glow.
void renderCenter() {
  noFill();
  float cr = armLen * 0.11;

  for (int ring = 1; ring <= 3; ring++) {
    float t  = ring / 3.0;
    float sc = t * cr;
    float h  = (172 + ring * 24 + hueShift) % 360;

    // Glow ring
    stroke(h, 22, 90, 22);
    strokeWeight(5.5 * t);
    beginShape();
    for (int v = 0; v < 6; v++) vertex(sc * cos(v * PI/3), sc * sin(v * PI/3), 0);
    endShape(CLOSE);

    // Core ring
    stroke(h, 52, 100, 54);
    strokeWeight(1.3);
    beginShape();
    for (int v = 0; v < 6; v++) vertex(sc * cos(v * PI/3), sc * sin(v * PI/3), 0);
    endShape(CLOSE);
  }
}


// ─────────────────────────────────────────────
//  INPUT
// ─────────────────────────────────────────────

void keyPressed() {
  if (key == ' ' || key == 'r' || key == 'R') generate();
  if (key == '3') { maxDepth = 3; generate(); }
  if (key == '4') { maxDepth = 4; generate(); }
  if (key == '5') { maxDepth = 5; generate(); }
}
