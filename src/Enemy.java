import processing.core.PApplet;

public class Enemy {
    PApplet p;
    float x, y, w, h;
    float vx = -4f;

    public Enemy(PApplet p, float x, float y, float w, float h, float vx) {
        this.p = p;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.vx = vx;
    }

    public void update() {
        x += vx;
    }

    public void display() {
        p.pushMatrix();
        p.fill(40);
        p.rect(x, y - h, w, h, 4);
        p.fill(200, 50, 50);
        p.ellipse(x + w * 0.5f, y - h + 12, 12, 12);
        p.popMatrix();
    }

    public boolean collidesWith(Player pl) {
        float px1 = pl.getX();
        float py1 = pl.getY();
        float px2 = pl.getX() + pl.getW();
        float py2 = pl.getY() + pl.getH();
        float ex1 = x;
        float ey1 = y - h;
        float ex2 = x + w;
        float ey2 = y;
        return !(px2 < ex1 || px1 > ex2 || py2 < ey1 || py1 > ey2);
    }
}