class Enemy {
  float x, y, w, h;   // Position (x, y) and size (width, height) of the enemy
  float speed;        // Horizontal movement speed
  int type;           // Enemy type (0, 1, or 2) which affects behavior and color

  // Constructor: initializes enemy properties
  Enemy(float x, float y, float w, float h, float speed, int type) {
    this.x = x;       // Set starting x-position
    this.y = y;       // Set starting y-position
    this.w = w;       // Set enemy width
    this.h = h;       // Set enemy height
    this.speed = speed; // Movement speed
    this.type = type;   // Enemy behavior/color type
  }

  void update() {
    x += speed;  // Move the enemy horizontally

    // If the enemy is type 2, make it move up and down using a sine wave
    if (type == 2) 
      y += sin(frameCount * 0.1) * 1.5;
  }

  void display() {
    // Select color based on enemy type
    if (type == 0)      fill(255, 50, 50);   // Light red enemy
    else if (type == 1) fill(200, 0, 0);     // Dark red enemy
    else                fill(255, 120, 0);   // Orange enemy (type 2)

    rect(x, y, w, h);   // Draw enemy rectangle
  }

  boolean collidesWith(Player p) {
    // Axis-aligned bounding box (AABB) collision detection with the player
    return (x < p.x + p.w &&     // Enemy left is left of player right
            x + w > p.x &&       // Enemy right is right of player left
            y < p.y + p.h &&     // Enemy top is above player bottom
            y + h > p.y);        // Enemy bottom is below player top
  }
}
