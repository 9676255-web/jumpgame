import processing.core.PApplet;

public class Coin {
    PApplet p;
    float x, y, r;
    boolean collected = false;

    public Coin(PApplet p, float x, float y, float r) {
        this.p = p;
        this.x = x;
        this.y = y;
        this.r = r;
    }

    public void display(int frameCount) {
        p.pushMatrix();
        float bob = p.sin((frameCount + x) * 0.05f) * 6f;
        p.fill(255, 200, 0);
        float drawX = x - (frameCount * 0.5f) % (p.width + 200);
        p.ellipse(drawX, y + bob, r * 2, r * 2);
        p.popMatrix();
    }

    public boolean collectedBy(Player pl) {
        float px = pl.getX() + pl.getW() * 0.5f;
        float py = pl.getY() + pl.getH() * 0.5f;
        float d = p.dist(px, py, x, y);
        if (d < r + Math.max(pl.getW(), pl.getH()) / 2f) {
            return true;
        }
        return false;
    }

    // helper to move coin (if you want coins to scroll)
    public void move(float dx) {
        x += dx;
    }
}