// Player.pde
class Player {
  // member variables
  float x, y;
  float w, h;
  float vx, vy;
  color col;
  boolean onGround;

  // constructor
  Player(float startX, float startY) {
    x = startX;
    y = startY;
    w = 40;
    h = 60;
    vx = 0;
    vy = 0;
    col = color(40, 120, 255);
    onGround = false;
  }

  // display() - should match mockup (simple rectangle here)
  void display() {
    pushStyle();
    fill(col);
    noStroke();
    rectMode(CORNER);
    rect(x, y - h, w, h); // y is bottom
    popStyle();
  }

  // move() - can be simple for now (left/right via vx)
  void move() {
    x += vx;
    // keep inside window
