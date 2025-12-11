class Player {
  float x, y, w, h;      // Player's position (x, y) and size (width, height)
  float yVel = 0;        // Vertical velocity of the player
  float gravity = 0.6;   // Gravity applied each frame

  float jumpPower = -12;       // Strength of the first jump
  float doubleJumpPower = -10; // Strength of the second jump

  int jumpsLeft = 3;     // Player starts with 2 jumps (double jump system)

  Player(float x, float y, float w, float h) { // Constructor sets up player
    this.x = x;          // Starting x position
    this.y = y;          // Starting y position
    this.w = w;          // Player width
    this.h = h;          // Player height
  }

  void update() {
    y += yVel;           // Apply vertical movement
    yVel += gravity;     // Apply gravity to vertical velocity

    // Collision with the ground
    if (y + h >= groundY) { // If bottom of player touches or passes ground
      y = groundY - h;      // Snap player to ground position
      yVel = 0;             // Reset vertical velocity
      jumpsLeft = 3;        // Restore double jump
    }
  }

  void jump() {
    if (jumpsLeft > 0) {    // Only allow jump if one is available
      // Use stronger first jump, weaker second jump
      yVel = (jumpsLeft == 2 ? jumpPower : doubleJumpPower);
      jumpsLeft--;          // Reduce available jumps
    }
  }

  void display() {
    fill(0, 0, 255);   // Player color (blue)
    rect(x, y, w, h);  // Draw player as a rectangle
  }

  boolean collidesWith(Coin c) {
    // Calculate the horizontal distance from player center to coin center
    float dx = c.x - (x + w/2);

    // Calculate the vertical distance from player center to coin center
    float dy = c.y - (y + h/2);

    // Square distance between centers (avoids slow sqrt)
    float distSq = dx*dx + dy*dy;

    // Treat the player like a circle with radius = half width, added to coin radius
    float radius = c.r + w/2;

    // Collision occurs if distance between centers is smaller than combined radius
    return distSq < radius * radius;
  }
}
