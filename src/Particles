class Particle {
  float x, y;    // Position of the particle
  float vx, vy;  // Velocity of the particle (x and y directions)
  float life;    // How long the particle will exist

  Particle(float x, float y) {  // Constructor takes starting position
    this.x = x;                  // Set initial x position
    this.y = y;                  // Set initial y position
    vx = random(-3, 3);          // Random horizontal velocity between -3 and 3
    vy = random(-4, -1);         // Random upward velocity (negative y)
    life = 40;                   // Particle starts with a life value of 40
  }

  void update() {
    x += vx;          // Move particle horizontally
    y += vy;          // Move particle vertically
    vy += 0.2;        // Apply gravity by increasing downward velocity
    life--;           // Reduce life each frame
  }

  void display() {
    noStroke();                    // Draw without outline
    fill(255, 200, 0, life * 6);   // Fade color based on remaining life
    ellipse(x, y, 8, 8);           // Draw particle as small circle
  }

  boolean dead() {
    return life <= 0;   // Returns true when particle's life has ended
  }
}

void spawnDeathParticles(float px, float py) {
  for (int i = 0; i < 30; i++) {           // Create 30 particles
    deathParticles.add(new Particle(px, py));  // Add each new particle at given position
  }
}
