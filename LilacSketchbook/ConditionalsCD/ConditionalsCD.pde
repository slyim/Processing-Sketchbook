ArrayList<PVector> particles = new ArrayList<PVector>();
float x;
float y;
float z;
float trans;

void setup() {
  size(1000, 600);
  background(0);
  noStroke();
}

void draw() {
  noStroke();
  background(0);
  fill(175);
  rectMode(CENTER);
  trans = random(10, 90);

  if (mouseX > 666) {
    stroke(1);
    fill(#DD4CAA, trans);
    circle(500, 300, x);
    x = random(0, 100);
  } else if (mouseX > 333) {
    stroke(1);
    fill(#65FFAA, trans);
    y = random(0, 100);
    square(500, 300, y);
  } else {
    stroke(1);
    fill(#FFCF70, trans);
    z = random(320, 260);
    x = random(240, 320);
    triangle(500, x, 520, z, 480, z);
  }

  particles.add(new PVector(500, 300));

  for (int i = particles.size() - 1; i >= 0; i--) {
    noStroke();
    PVector p = particles.get(i);
    circle(p.x, p.y, 10);

    if (mouseX > 666) {
      p.x += random(0, 0);
      p.y += random(0, 0);
    } else if (mouseX > 333) {
      p.y++;
    } else {
      p.y--;
    }

    if (particles.size() > 60) {
      particles.remove(0);
    }
  }

  stroke(#181818);
  strokeWeight(random(1, 2));
  line(333, 0, 333, height);
  line(666, 0, 666, height);
}
