class Coin {
  float x, y, r;  // Position (x, y) and radius (r) of the coin

  // Constructor: initializes the coin's position and radius
  Coin(float x, float y, float r) {
    this.x = x;   // Set x-position
    this.y = y;   // Set y-position
    this.r = r;   // Set radius
  }

  void display() {
    // Calculate rotation angle based on frame count (6 degrees per frame)
    float angle = radians(frameCount * 6);

    pushMatrix();     // Save the current transformation state
    translate(x, y);  // Move drawing origin to the coin's position
    rotateY(angle);   // Rotate the coin around the Y-axis to simulate spinning

    fill(255, 200, 0);          // Set color for outer circle (gold)
    ellipse(0, 0, r*2, r*2);    // Draw outer circle of the coin

    fill(255, 230, 80);         // Set color for inner circle (lighter gold)
    ellipse(0, 0, r*1.4, r*1.4);// Draw inner circle for detail

    popMatrix();      // Restore previous transformation state
  }
}
