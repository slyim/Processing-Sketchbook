// =============================================================
// 10_3D_Basics — Processing Reference
// =============================================================
// Covers:
//   size(w, h, P3D)        — enable 3D renderer
//   box(size) / box(w,h,d) — 3D box
//   sphere(r)              — 3D sphere
//   sphereDetail(ures, vres) — sphere resolution
//   translate / rotateX / rotateY / rotateZ — 3D transforms
//   camera(eyeX,eyeY,eyeZ, centerX,centerY,centerZ, upX,upY,upZ)
//   perspective(fov, aspect, near, far)
//   lights()               — default lighting
//   ambientLight()         — ambient light
//   directionalLight()     — directional (sun-like) light
//   pointLight()           — point light source
//   beginShape / vertex in 3D — custom 3D geometry
//   PShape                 — reusable geometry
// =============================================================

float rx = 0, ry = 0; // rotation from mouse drag
float lastX, lastY;
boolean dragging = false;
float autoRot = 0;

void setup() {
  size(900, 620, P3D); // <-- P3D renderer enables 3D
  sphereDetail(30);    // sphere polygon resolution
}

void draw() {
  background(18, 18, 26);
  autoRot += 0.005;

  // ── Camera setup ─────────────────────────────────────────
  // Default camera looks at (width/2, height/2, 0)
  // We can override it:
  float eyeZ = (height / 2.0) / tan(PI * 30.0 / 180.0); // default formula
  camera(width / 2.0, height / 2.0, eyeZ,   // eye position
         width / 2.0, height / 2.0, 0,       // look-at target
         0, 1, 0);                            // up vector

  // Apply perspective (optional — Processing has defaults)
  perspective(PI / 3.5, float(width) / height, 1, 5000);

  // ── Scene lighting ────────────────────────────────────────
  ambientLight(40, 40, 60);                          // soft base light
  directionalLight(200, 200, 255, -1, 1, -1);        // blue-white sun
  pointLight(255, 140, 60,                           // warm orange point light
             width * 0.3 + sin(autoRot) * 200,       // x (orbiting)
             height * 0.3,                            // y
             200);                                    // z

  // ── Apply global rotation from mouse drag ─────────────────
  pushMatrix();
    translate(width / 2.0, height / 2.0, 0); // center of scene
    rotateX(rx);
    rotateY(ry + autoRot * 0.5);

    // ── Grid of 3D objects ───────────────────────────────
    int cols = 3, rows = 2;
    float spacing = 220;
    float startX = -(cols - 1) * spacing / 2.0;
    float startY = -(rows - 1) * spacing / 2.0;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        float ox = startX + col * spacing;
        float oy = startY + row * spacing;
        int idx = row * cols + col;

        pushMatrix();
          translate(ox, oy, 0);
          rotateY(autoRot * (0.5 + col * 0.3));
          rotateX(autoRot * (0.2 + row * 0.2));
          drawObject(idx);
        popMatrix();
      }
    }

  popMatrix();

  // ── HUD (drawn in 2D on top) ──────────────────────────────
  // Reset to 2D-style by calling camera/ortho
  hint(DISABLE_DEPTH_TEST); // draw HUD on top of 3D scene
  camera();                 // reset camera to default 2D
  ortho();                  // orthographic (no perspective distortion)

  fill(10, 10, 20, 200);
  noStroke();
  rect(15, 15, 310, 210, 8);

  fill(255, 210, 80); textSize(13);
  text("3D Basics (P3D renderer)", 30, 40);

  fill(160); textSize(11);
  text("size(900, 620, P3D)  — enables 3D", 30, 62);
  text("Shapes: box(), sphere(), beginShape()", 30, 80);
  text("Lights: ambientLight, directionalLight, pointLight", 30, 98);
  text("rotateX / rotateY / rotateZ", 30, 116);
  text("camera(eye, target, up)", 30, 134);
  text("perspective(fov, aspect, near, far)", 30, 152);
  text("hint(ENABLE/DISABLE_DEPTH_TEST)", 30, 170);

  fill(120); textSize(10);
  text("Drag to rotate scene   Auto-rotating", 30, 195);
  text("Objects: box, sphere, cone, torus, custom mesh", 30, 213);

  hint(ENABLE_DEPTH_TEST); // restore depth testing
}

// Draw a different 3D shape for each grid slot
void drawObject(int idx) {
  noStroke();

  switch (idx) {
    case 0: // Box
      fill(100, 160, 255);
      box(100, 80, 80); // width, height, depth
      label("box(100,80,80)", 0, 65);
      break;

    case 1: // Sphere
      fill(255, 120, 80);
      sphere(55);
      label("sphere(55)", 0, 70);
      break;

    case 2: // Cube with noFill wireframe overlay
      fill(80, 200, 140);
      box(90);
      fill(0, 0);
      stroke(255, 255, 255, 100);
      strokeWeight(1);
      box(95); // slightly larger wireframe
      noStroke();
      label("box + wireframe", 0, 65);
      break;

    case 3: // Custom 3D cone via beginShape
      fill(220, 180, 60);
      drawCone(0, 0, 0, 50, 100, 20);
      label("beginShape cone", 0, 85);
      break;

    case 4: // Multiple spheres (atom model)
      fill(180, 80, 220);
      sphere(35);
      fill(255, 200, 80);
      pushMatrix(); translate(65, 0, 0); sphere(15); popMatrix();
      pushMatrix(); translate(-65, 0, 0); sphere(15); popMatrix();
      pushMatrix(); translate(0, 65, 0); sphere(15); popMatrix();
      pushMatrix(); translate(0, -65, 0); sphere(15); popMatrix();
      label("atom model", 0, 75);
      break;

    case 5: // Stacked boxes
      for (int i = 0; i < 5; i++) {
        float s = map(i, 0, 4, 90, 20);
        float h = 18;
        colorMode(HSB, 360, 100, 100);
        fill(i * 50, 75, 85);
        colorMode(RGB);
        pushMatrix();
          translate(0, -i * h * 1.2 + 40, 0);
          box(s, h, s);
        popMatrix();
      }
      label("stacked boxes", 0, 75);
      break;
  }
}

// Simple cone from a center apex to a base circle
void drawCone(float cx, float cy, float cz, float r, float h, int res) {
  float[] bx = new float[res];
  float[] bz = new float[res];
  for (int i = 0; i < res; i++) {
    float a = TWO_PI / res * i;
    bx[i] = cx + cos(a) * r;
    bz[i] = cz + sin(a) * r;
  }
  // Side faces
  beginShape(TRIANGLE_FAN);
    vertex(cx, cy - h / 2, cz);  // apex
    for (int i = 0; i <= res; i++) {
      int j = i % res;
      vertex(bx[j], cy + h / 2, bz[j]);
    }
  endShape();
  // Base cap
  beginShape(TRIANGLE_FAN);
    vertex(cx, cy + h / 2, cz);  // center of base
    for (int i = res; i >= 0; i--) {
      int j = i % res;
      vertex(bx[j], cy + h / 2, bz[j]);
    }
  endShape();
}

void label(String s, float x, float y) {
  hint(DISABLE_DEPTH_TEST);
  fill(200, 200, 200, 200);
  textSize(10);
  textAlign(CENTER);
  text(s, x, y);
  textAlign(LEFT);
  hint(ENABLE_DEPTH_TEST);
}

// ── Mouse drag for rotation ───────────────────────────────────
void mouseDragged() {
  if (dragging) {
    ry += (mouseX - lastX) * 0.01;
    rx += (mouseY - lastY) * 0.01;
  }
  lastX = mouseX; lastY = mouseY;
  dragging = true;
}
void mouseReleased() { dragging = false; }
void mousePressed()   { lastX = mouseX; lastY = mouseY; dragging = true; }
