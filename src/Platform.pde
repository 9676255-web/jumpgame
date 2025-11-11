// Platform.pde
class Platform {
  float x, y; // x is left, y is top
  float w, h;
  color col;

  Platform(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    col = color(120, 200, 120);
  }

  void display() {
    pushStyle();
    fill(col);
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h);
    popStyle();
  }
}
