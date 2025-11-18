import processing.core.PApplet;

public class Player {
    PApplet p;
    float x, y, w, h;
    float vy = 0;
    float gravity = 0.9f;
    float jumpForce = -14f;
    boolean onGround = false;

    public Player(PApplet p, float x, float y, float w, float h) {
        this.p = p;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    public void update(int groundY) {
        vy += gravity;
        y += vy;
        if (y + h > groundY) {
            y = groundY - h;
            vy = 0;
            onGround = true;
        } else {
            onGround = false;
        }
        if (y < 0) {
            y = 0;
            vy = 0;
        }
    }

    public void jump() {
        if (onGround) {
            vy = jumpForce;
            onGround = false;
        }
    }

    public void display() {
        p.pushMatrix();
        p.fill(240, 80, 60);
        p.rect(x, y, w, h, 6);
        p.fill(255);
        p.rect(x + w * 0.15f, y + h * 0.2f, w * 0.18f, h * 0.18f, 4);
        p.rect(x + w * 0.55f, y + h * 0.2f, w * 0.18f, h * 0.18f, 4);
        p.popMatrix();
    }

    // getters used by other classes
    public float getX() { return x; }
    public float getY() { return y; }
    public float getW() { return w; }
    public float getH() { return h; }
}