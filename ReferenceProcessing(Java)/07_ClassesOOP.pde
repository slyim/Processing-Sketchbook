// =============================================================
// 07_ClassesOOP — Processing Reference
// =============================================================
// Covers:
//   Defining a class (fields, constructor, methods)
//   Creating objects with  new
//   ArrayList of objects — add, remove, iterate
//   Inheritance: extending a class
//   Interface-like pattern with abstract-ish behavior
//   this keyword
//   Static fields (shared across instances)
// =============================================================

ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Spark> sparks = new ArrayList<Spark>();

// ── Main sketch ──────────────────────────────────────────────
void setup() {
  size(900, 620);
  // Spawn some balls
  for (int i = 0; i < 8; i++) {
    balls.add(new Ball(random(width), random(height)));
  }
}

void draw() {
  background(20, 20, 28);

  // Update and draw all balls
  for (Ball b : balls) {
    b.update();
    b.draw();
  }

  // Update and draw sparks; remove dead ones
  for (int i = sparks.size() - 1; i >= 0; i--) {
    Spark s = sparks.get(i);
    s.update();
    s.draw();
    if (s.isDead()) sparks.remove(i); // safe to remove while iterating backwards
  }

  // ── HUD ─────────────────────────────────────────────────
  fill(10, 10, 20, 160);
  noStroke();
  rect(20, 20, 270, 160, 8);

  fill(255, 210, 80); textSize(13);
  text("Classes & OOP", 35, 45);

  fill(160); textSize(11);
  text("Balls (Ball class):  " + balls.size(), 35, 68);
  text("Sparks (Spark extends Ball): " + sparks.size(), 35, 86);
  text("Total created:  " + Ball.totalCreated, 35, 104);

  fill(180); textSize(10);
  text("Click: add Ball   Right-click: add Spark", 35, 130);
  text("C: clear sparks   R: reset", 35, 148);
  text("Balls bounce off walls. Sparks fade out.", 35, 166);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    balls.add(new Ball(mouseX, mouseY));
  } else {
    // Sparks extend Ball — they're also a Ball!
    for (int i = 0; i < 8; i++) {
      sparks.add(new Spark(mouseX, mouseY));
    }
  }
}

void keyPressed() {
  if (key == 'c' || key == 'C') sparks.clear();
  if (key == 'r' || key == 'R') { balls.clear(); sparks.clear(); Ball.totalCreated = 0; }
}

// ============================================================
// Ball — base class
// ============================================================
class Ball {

  // Fields — each instance has its own copy
  float x, y;         // position
  float vx, vy;       // velocity
  float radius;
  color col;

  // Static field — shared across ALL Ball instances
  static int totalCreated = 0;

  // ── Constructor — called when you write  new Ball(...)  ──
  Ball(float startX, float startY) {
    this.x = startX;   // 'this' refers to the current instance
    this.y = startY;
    this.radius = random(12, 32);
    this.vx = random(-3, 3);
    this.vy = random(-3, 3);
    this.col = color(random(80, 220), random(80, 180), random(100, 255));
    totalCreated++; // increment the shared counter
  }

  // ── Methods ─────────────────────────────────────────────
  void update() {
    x += vx;
    y += vy;
    bounceWalls();
  }

  void bounceWalls() {
    if (x - radius < 0 || x + radius > width)  vx *= -1;
    if (y - radius < 0 || y + radius > height) vy *= -1;
    x = constrain(x, radius, width - radius);
    y = constrain(y, radius, height - radius);
  }

  void draw() {
    // Trail
    noFill();
    stroke(red(col), green(col), blue(col), 60);
    strokeWeight(1);
    circle(x, y, radius * 2 + 10);

    // Body
    fill(col);
    noStroke();
    circle(x, y, radius * 2);

    // Highlight
    fill(255, 255, 255, 80);
    circle(x - radius * 0.3, y - radius * 0.3, radius * 0.6);
  }

  // Getters (optional but good practice)
  float getSpeed() {
    return sqrt(vx * vx + vy * vy);
  }
}

// ============================================================
// Spark — extends Ball (inheritance)
// Adds: fade-out lifetime, no wall bounce
// ============================================================
class Spark extends Ball {

  float lifetime;    // frames remaining
  float maxLife;

  // Constructor — must call super() first to run parent constructor
  Spark(float startX, float startY) {
    super(startX, startY);            // calls Ball(startX, startY)
    this.vx = random(-5, 5);
    this.vy = random(-7, 1);          // mostly upward
    this.radius = random(3, 10);
    this.maxLife = random(30, 90);
    this.lifetime = maxLife;
  }

  // ── Override update() — no wall bounce, add gravity ──────
  @Override
  void update() {
    vy += 0.15;    // gravity
    x += vx;
    y += vy;
    lifetime--;
  }

  // ── Override draw() — fade based on lifetime ─────────────
  @Override
  void draw() {
    float alpha = map(lifetime, 0, maxLife, 0, 255);
    float sz    = map(lifetime, 0, maxLife, 0, radius * 2);
    fill(red(col), green(col), blue(col), alpha);
    noStroke();
    circle(x, y, sz);
  }

  // New method — only Spark has this
  boolean isDead() {
    return lifetime <= 0;
  }
}
