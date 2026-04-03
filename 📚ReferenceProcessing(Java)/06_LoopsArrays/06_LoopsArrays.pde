// =============================================================
// 06_LoopsArrays — Processing Reference
// =============================================================
// Covers:
//   for loop (counting, iterating, nested)
//   while loop
//   break / continue
//   int[] / float[] arrays — declaration, access, length
//   2D arrays  int[][]
//   ArrayList<T> — dynamic size, add/remove/get
//   IntList, FloatList (Processing-specific)
//   Common patterns: grid, radial, wave, data histogram
// =============================================================

float t = 0;

void setup() {
  size(900, 620);
}

void draw() {
  background(22, 22, 30);
  t += 0.02;

  // ── 1. Basic for loop: dot row ────────────────────────────
  sectionLabel(30, 30, "for loop — basic counting");

  for (int i = 0; i < 20; i++) {
    float x = 30 + i * 30;
    float sz = 8 + i * 1.2;
    colorMode(HSB, 360, 100, 100);
    fill(i * 18, 80, 90);
    colorMode(RGB);
    noStroke();
    circle(x, 60, sz);
  }

  // ── 2. Nested for loop: grid ──────────────────────────────
  sectionLabel(30, 100, "nested for — grid");

  int cols = 10, rows = 5;
  float cellW = 28, cellH = 28;
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      float x = 30 + col * cellW;
      float y = 115 + row * cellH;
      // Checkerboard using modulo
      if ((col + row) % 2 == 0) fill(80, 120, 200);
      else                      fill(30, 50, 90);
      noStroke();
      rect(x, y, cellW - 2, cellH - 2, 3);
    }
  }

  // ── 3. while loop and break/continue ─────────────────────
  sectionLabel(330, 30, "while / break / continue");

  // while: draw circles until total area > threshold
  float totalArea = 0;
  float wx = 330;
  int maxCircles = 20;
  int drawn = 0;
  while (totalArea < 4000 && drawn < maxCircles) {
    float sz = random(10, 50);
    // continue skips tiny circles (< 12) to show continue usage
    if (sz < 12) { drawn++; continue; }
    fill(60 + totalArea * 0.05, 180, 120, 180);
    noStroke();
    circle(wx, 80, sz);
    wx += sz * 0.9;
    totalArea += PI * (sz/2) * (sz/2);
    drawn++;
  }

  // ── 4. Arrays ─────────────────────────────────────────────
  sectionLabel(30, 275, "int[] / float[] arrays");

  float[] heights = new float[12];
  // Fill with sin wave
  for (int i = 0; i < heights.length; i++) {
    heights[i] = 60 + sin(t + i * 0.6) * 40;
  }

  // Draw as bar chart
  for (int i = 0; i < heights.length; i++) {
    float bx = 30 + i * 34;
    float bh = heights[i];
    fill(100, 180, 255);
    noStroke();
    rect(bx, 400 - bh, 28, bh);
    fill(160); textSize(9);
    text(i, bx + 8, 415);
  }
  fill(200); textSize(10);
  text("heights[i] animated with sin()", 30, 430);

  // ── 5. 2D array ───────────────────────────────────────────
  sectionLabel(30, 450, "2D arrays  int[rows][cols]");

  int[][] grid = {
    {1, 0, 1, 0, 1},
    {0, 1, 0, 1, 0},
    {1, 0, 1, 0, 1},
    {0, 1, 0, 1, 0}
  };

  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      float gx = 30 + col * 38;
      float gy = 465 + row * 38;
      fill(grid[row][col] == 1 ? color(220, 120, 60) : color(50));
      noStroke();
      rect(gx, gy, 34, 34, 4);
    }
  }

  // ── 6. ArrayList ──────────────────────────────────────────
  sectionLabel(500, 30, "ArrayList<PVector>  — dynamic size");

  // Draw radial arrangement updated each frame
  int n = 24 + int(sin(t) * 8);  // count changes!
  for (int i = 0; i < n; i++) {
    float angle = TWO_PI / n * i + t;
    float r = 70 + sin(t * 2 + i * 0.4) * 20;
    float px = 650 + cos(angle) * r;
    float py = 130 + sin(angle) * r;
    colorMode(HSB, 360, 100, 100);
    fill(i * (360.0 / n), 80, 90);
    colorMode(RGB);
    noStroke();
    circle(px, py, 12);
  }
  fill(180); textSize(10);
  text("n = " + n + " (dynamic, changes with sin)", 500, 230);

  // ── 7. map() with array — histogram ───────────────────────
  sectionLabel(500, 270, "map() + array — histogram pattern");

  float[] data = new float[20];
  for (int i = 0; i < data.length; i++) {
    data[i] = abs(sin(t * 0.5 + i * 0.4 + noise(i) * 3)) * 120;
  }

  float maxVal = max(data); // max() works on arrays directly
  float minVal = min(data); // min() too

  for (int i = 0; i < data.length; i++) {
    float bx = 500 + i * 20;
    float bh = map(data[i], 0, maxVal, 5, 150);
    colorMode(HSB, 360, 100, 100);
    fill(map(data[i], minVal, maxVal, 200, 360), 75, 90);
    colorMode(RGB);
    noStroke();
    rect(bx, 480 - bh, 17, bh, 3);
  }
  fill(180); textSize(10);
  text("max=" + nf(maxVal, 0, 1) + "  min=" + nf(minVal, 0, 1), 500, 500);

  // ── Handy array functions label ───────────────────────────
  fill(120); textSize(10);
  text("Useful: append(), subset(), concat(), reverse(), sort(), shorten()", 30, 600);
}

void sectionLabel(float x, float y, String label) {
  fill(255, 210, 80);
  noStroke();
  textSize(12);
  text(label, x, y);
}
