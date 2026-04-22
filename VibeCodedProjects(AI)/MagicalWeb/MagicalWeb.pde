// --- Configuration Constants ---
final int MAX_PARTICLES = 250;
final float SPHERE_RADIUS = 180.0;
final float CONNECTION_DIST = 65.0;
final float INTERACTION_RADIUS = 150.0;
final float SPRING_STRENGTH = 0.04;
final float FRICTION = 0.88;

ArrayList<Particle> particles;
float rotationX = 0, rotationY = 0;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  particles = new ArrayList<Particle>();
  
  
  // Generate particles mapped to a Fibonacci sphere
  for (int i = 0; i < MAX_PARTICLES; i++) {
    float phi = acos(1 - 2 * (i + 0.5f) / MAX_PARTICLES);
    float theta = PI * (1 + sqrt(5)) * i;
    
    float x = SPHERE_RADIUS * sin(phi) * cos(theta);
    float y = SPHERE_RADIUS * sin(phi) * sin(theta);
    float z = SPHERE_RADIUS * cos(phi);
    
    particles.add(new Particle(new PVector(x, y, z)));
  }
}

void draw() {
  background(230, 40, 10);
  blendMode(ADD);

  // Handle 3D Camera Translation & Rotation
  translate(width / 2.0, height / 2.0, 0);
  rotationX += (mouseY - height / 2.0) * 0.0001;
  rotationY += (mouseX - width / 2.0) * 0.0001;
  rotateX(-rotationX);
  rotateY(rotationY);

  // 1. Update and display all particles
  for (Particle p : particles) {
    p.update();
    p.display();
  }

  // 2. Draw connections between close particles
  strokeWeight(1);
  for (int i = 0; i < particles.size(); i++) {
    Particle p1 = particles.get(i);

    for (int j = i + 1; j < particles.size(); j++) {
      Particle p2 = particles.get(j);
      float d = PVector.dist(p1.pos, p2.pos);

      if (d < CONNECTION_DIST) {
        float alpha = map(d, 0, CONNECTION_DIST, 60, 0);
        float avgHue = calculateAverageHue(p1.hueValue, p2.hueValue);
        stroke(avgHue, 35, 90, alpha);
        line(p1.pos.x, p1.pos.y, p1.pos.z, p2.pos.x, p2.pos.y, p2.pos.z);
      }
    }
  }
}

// --- Helper Function for Clean Color Wrapping ---
float calculateAverageHue(float h1, float h2) {
  float diff = abs(h1 - h2);
  float avg = (h1 + h2) / 2.0;
  if (diff > 180) avg = (avg + 180) % 360;
  return avg;
}

// --- Particle Class using PVector Math ---
class Particle {
  PVector basePos, pos, vel;
  float hueValue, noiseOffset;

  Particle(PVector startPos) {
    basePos = startPos.copy();
    pos = startPos.copy();
    vel = new PVector();
    hueValue = random(360);
    noiseOffset = random(1000);
  }

  void update() {
    // Project current 3D position onto 2D screen space for mouse interaction
    float sx = screenX(pos.x, pos.y, pos.z);
    float sy = screenY(pos.x, pos.y, pos.z);
    
    // Calculate organic target position utilizing Perlin noise
    PVector targetPos = new PVector(
      basePos.x + map(noise(noiseOffset), 0, 1, -15, 15),
      basePos.y + map(noise(noiseOffset + 1000), 0, 1, -15, 15),
      basePos.z + map(noise(noiseOffset + 2000), 0, 1, -15, 15)
    );

    // Apply interaction force if mouse is pressed near the projected screen coordinates
    if (mousePressed) {
      float d = dist(mouseX, mouseY, sx, sy);
      if (d < INTERACTION_RADIUS) {
        float force = map(d, 0, INTERACTION_RADIUS, 1.5, 0);
        vel.x += (sx - mouseX) * force * 0.02;
        vel.y += (sy - mouseY) * force * 0.02;
        vel.z += force * 0.5; // Z-axis blast
      }
    }

    // Apply Spring Physics
    PVector springForce = PVector.sub(targetPos, pos).mult(SPRING_STRENGTH);
    vel.add(springForce);
    vel.mult(FRICTION);
    pos.add(vel);

    // Cycle hue and advance Perlin noise
    hueValue = (hueValue + 0.15) % 360;
    noiseOffset += 0.005;
  }
  
  // Isolate drawing commands
  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noStroke();
    fill(hueValue, 45, 95, 80);
    sphere(1.5);
    popMatrix();
  }
}