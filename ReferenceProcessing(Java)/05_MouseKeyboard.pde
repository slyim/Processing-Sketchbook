// =============================================================
// 05_MouseKeyboard — Processing Reference
// =============================================================
// Covers:
//   mouseX, mouseY         — current cursor position
//   pmouseX, pmouseY       — previous frame position (good for velocity)
//   mousePressed (boolean) — true while button held
//   mouseButton            — LEFT, RIGHT, CENTER
//   mouseMoved()           — event: called when mouse moves (not pressed)
//   mousePressed()         — event: called on click
//   mouseReleased()        — event: called on release
//   mouseDragged()         — event: called while dragging
//   mouseWheel(event)      — scroll wheel
//   key                    — the last key pressed (char)
//   keyCode                — for special keys (UP, DOWN, SHIFT, etc.)
//   keyPressed (boolean)   — true while any key held
//   keyPressed()           — event: called on key down
//   keyReleased()          — event: called on key up
// =============================================================

ArrayList<PVector> trail = new ArrayList<PVector>(); // mouse trail
ArrayList<PVector> clicks = new ArrayList<PVector>(); // click history
String lastKey = "–";
int lastKeyCode = 0;
float wheelOffset = 0;
boolean shiftHeld = false;
boolean mouseWasPressed = false;

void setup() {
  size(900, 620);
}

void draw() {
  background(22, 22, 30, 60); // low alpha = trail fade effect

  // Track mouse trail
  trail.add(new PVector(mouseX, mouseY));
  if (trail.size() > 80) trail.remove(0);

  // ── Mouse trail ──────────────────────────────────────────
  for (int i = 1; i < trail.size(); i++) {
    PVector a = trail.get(i - 1);
    PVector b = trail.get(i);
    float alpha = map(i, 0, trail.size(), 0, 255);
    stroke(100, 180, 255, alpha);
    strokeWeight(2);
    line(a.x, a.y, b.x, b.y);
  }

  // ── Cursor dot, size from wheel scroll ───────────────────
  float cursorSize = constrain(20 + wheelOffset * 3, 5, 100);
  noStroke();
  if (mousePressed) {
    fill(mouseButton == LEFT ? color(255, 120, 60) : color(60, 200, 255));
  } else {
    fill(200, 200, 255, 180);
  }
  circle(mouseX, mouseY, cursorSize);

  // ── Velocity from pmouse ─────────────────────────────────
  float speed = dist(mouseX, mouseY, pmouseX, pmouseY);
  stroke(255, 200, 0, 150);
  strokeWeight(2);
  line(mouseX, mouseY, mouseX + (mouseX - pmouseX) * 4, mouseY + (mouseY - pmouseY) * 4);

  // ── Click markers ────────────────────────────────────────
  for (PVector c : clicks) {
    noFill();
    stroke(255, 80, 80, 120);
    strokeWeight(1);
    circle(c.x, c.y, 20);
    circle(c.x, c.y, 40);
  }

  // ── HUD ─────────────────────────────────────────────────
  // Semi-transparent panel
  fill(10, 10, 20, 180);
  noStroke();
  rect(20, 20, 300, 260, 8);

  fill(255, 210, 80);
  textSize(13);
  noStroke();
  text("Mouse & Keyboard Info", 35, 45);

  fill(160);
  textSize(11);
  text("mouseX, mouseY:  " + mouseX + ", " + mouseY, 35, 70);
  text("pmouseX, pmouseY: " + pmouseX + ", " + pmouseY, 35, 88);
  text("Speed (dist/frame): " + nf(speed, 0, 1), 35, 106);
  text("mousePressed:    " + mousePressed, 35, 124);
  text("mouseButton:     " + (mouseButton == LEFT ? "LEFT" : mouseButton == RIGHT ? "RIGHT" : "CENTER"), 35, 142);
  text("Wheel offset:    " + wheelOffset, 35, 160);
  text("Cursor size:     " + nf(cursorSize, 0, 1), 35, 178);

  text("key:             '" + lastKey + "'", 35, 210);
  text("keyCode:         " + lastKeyCode, 35, 228);
  text("keyPressed:      " + keyPressed, 35, 246);
  text("SHIFT held:      " + shiftHeld, 35, 264);

  // ── Key hints ────────────────────────────────────────────
  fill(10, 10, 20, 180);
  noStroke();
  rect(20, 300, 300, 150, 8);

  fill(255, 210, 80); textSize(13);
  text("Controls", 35, 325);
  fill(160); textSize(11);
  text("Mouse: move = trail, drag = draw", 35, 345);
  text("Scroll wheel = resize cursor", 35, 363);
  text("Left click = orange dot", 35, 381);
  text("Right click = blue dot", 35, 399);
  text("C = clear clicks", 35, 417);
  text("SPACE = clear trail", 35, 435);

  // ── Arrow key visual ─────────────────────────────────────
  drawArrowKeys();
}

// ── Mouse event functions ────────────────────────────────────
void mousePressed() {
  // mouseButton tells you which button
  clicks.add(new PVector(mouseX, mouseY));
  if (clicks.size() > 15) clicks.remove(0);
}

void mouseDragged() {
  // Called every frame while dragging; pmouse gives last position
  stroke(60, 220, 140, 200);
  strokeWeight(3);
  line(pmouseX, pmouseY, mouseX, mouseY);
}

void mouseWheel(MouseEvent event) {
  // event.getCount() returns scroll direction (+1 down, -1 up)
  wheelOffset += event.getCount();
  wheelOffset = constrain(wheelOffset, -5, 26);
}

// ── Keyboard event functions ─────────────────────────────────
void keyPressed() {
  lastKey = str(key);
  lastKeyCode = keyCode;

  // keyCode for special keys: UP, DOWN, LEFT, RIGHT, SHIFT, CONTROL, ALT
  shiftHeld = (keyCode == SHIFT);

  if (key == 'c' || key == 'C') clicks.clear();
  if (key == ' ')               trail.clear();
}

void keyReleased() {
  if (keyCode == SHIFT) shiftHeld = false;
}

// ── Draw arrow key diagram ───────────────────────────────────
void drawArrowKeys() {
  int bx = 35, by = 475, bw = 40, bh = 30, gap = 5;

  fill(10, 10, 20, 180);
  noStroke();
  rect(20, 460, 300, 130, 8);

  fill(255, 210, 80); textSize(12);
  text("Special key codes", 35, 480);

  // UP
  drawKey(bx + bw + gap, by + 5, bw, bh, "UP", keyCode == UP && keyPressed);
  // LEFT, DOWN, RIGHT
  drawKey(bx,                by + bh + gap + 5, bw, bh, "LEFT",  keyCode == LEFT  && keyPressed);
  drawKey(bx + bw + gap,     by + bh + gap + 5, bw, bh, "DOWN",  keyCode == DOWN  && keyPressed);
  drawKey(bx + (bw + gap)*2, by + bh + gap + 5, bw, bh, "RIGHT", keyCode == RIGHT && keyPressed);

  // SHIFT, CTRL, ALT
  drawKey(bx + 160, by + 5,           60, bh, "SHIFT", keyCode == SHIFT   && keyPressed);
  drawKey(bx + 160, by + bh + gap + 5, 60, bh, "CTRL",  keyCode == CONTROL && keyPressed);
  drawKey(bx + 230, by + bh + gap + 5, 50, bh, "ALT",   keyCode == ALT     && keyPressed);
}

void drawKey(float x, float y, float w, float h, String label, boolean active) {
  fill(active ? color(255, 210, 80) : color(50, 50, 70));
  stroke(active ? color(255, 255, 200) : color(100));
  strokeWeight(1);
  rect(x, y, w, h, 4);
  fill(active ? color(20) : color(200));
  textSize(9);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2);
  textAlign(LEFT, BASELINE);
}
