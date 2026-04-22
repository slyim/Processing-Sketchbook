// Ethereal Flow System
// A pure Processing generative architecture.

ArrayList<FaeParticle> particles;
float globalZ = 0; // Used to move smoothly through the 3D noise space

void setup() {
  size(800, 800, P2D); // P2D renderer is faster for high-density particle blending
  background(10, 15, 25); // Deep night sky background
  
  particles = new ArrayList<FaeParticle>();

  // Spawn 1000 autonomous particles
  for (int i = 0; i < 1000; i++) {
    particles.add(new FaeParticle());
  }
}

void draw() {
  // 1. Fading Trail Effect
  // Instead of background() which clears the screen, we draw a semi-transparent rectangle.
  fill(10, 15, 25, 25);
  noStroke();
  rect(0, 0, width, height);

  // 2. Optical Blending
  // ADD mode makes overlapping colors glow, creating an ethereal aesthetic
  blendMode(ADD); 

  // 3. The Matrix Stack (Central Geometric Focus)
  pushMatrix();
  translate(width / 2, height / 2); // Move origin to center
  rotate(frameCount * 0.005);       // Slowly rotate
  noFill();
  stroke(100, 200, 255, 30);        // Faint cyan
  strokeWeight(1);
  // An ellipse that breathes in and out using trigonometry
  ellipse(0, 0, 150 + sin(frameCount * 0.02) * 30, 150 + cos(frameCount * 0.03) * 30);
  popMatrix();

  // 4. Update and Render System
  for (FaeParticle p : particles) {
    p.calculateForces(globalZ);
    p.update();
    p.checkEdges();
    p.display();
  }

  // Advance time for the Perlin noise field
  globalZ += 0.005; 
  
  // Reset blend mode so the background rectangle draws normally next frame
  blendMode(BLEND); 
}

// ==========================================
// CLASS BLUEPRINT: The Object-Oriented Particle
// ==========================================

class FaeParticle {
  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed;
  color c;

  FaeParticle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    maxSpeed = random(1.5, 4.0);
    
    // Assign a random glowing color (cyan, teal, or violet)
    c = color(random(100, 150), random(200, 255), random(220, 255), 150);
  }

  void calculateForces(float zOffset) {
    // Generate an organic angle using Perlin noise based on the particle's X/Y position
    float angle = noise(pos.x * 0.005, pos.y * 0.005, zOffset) * TWO_PI * 4;
    
    // Convert that angle into a directional vector (wind)
    PVector force = PVector.fromAngle(angle);
    force.mult(0.5); // Soften the wind strength

    // Interactive Override: If mouse is pressed, calculate vector towards cursor
    if (mousePressed) {
      PVector mousePos = new PVector(mouseX, mouseY);
      PVector attraction = PVector.sub(mousePos, pos); // Vector pointing to mouse
      attraction.setMag(1.5); // Set the strength of the gravity well
      force.add(attraction);  // Combine wind and gravity
    }

    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    vel.add(acc);          // Acceleration changes velocity
    vel.limit(maxSpeed);   // Prevent infinite acceleration
    pos.add(vel);          // Velocity changes position
    acc.mult(0);           // Reset acceleration to zero each frame
  }

  void display() {
    stroke(c);
    strokeWeight(random(1, 3)); // Randomizing stroke weight creates a flickering, stardust effect
    point(pos.x, pos.y);
  }

  void checkEdges() {
    // If a particle drifts off screen, wrap it around to the other side
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }
}