import processing.core.PApplet;
import java.util.ArrayList;

public class Game {
    PApplet p;
    public Player player;
    public ArrayList<Enemy> enemies;
    public ArrayList<Coin> coins;

    public int groundY;
    public int spawnTimer = 0;
    public int spawnInterval = 120;
    public int score = 0;
    public int highScore = 0;

    public Game(PApplet p) {
        this.p = p;
        this.groundY = p.height - 60;
        resetGame();
    }

    public void resetGame() {
        player = new Player(p, 100, groundY - 50, 40, 50);
        enemies = new ArrayList<Enemy>();
        coins = new ArrayList<Coin>();
        score = 0;
        spawnTimer = 0;
        spawnInterval = 120;
        for (int i = 0; i < 8; i++) {
            float cx = 300 + i * 80 + p.random(-20, 20);
            float cy = groundY - 80 - (i % 3) * 30;
            coins.add(new Coin(p, cx, cy, 12));
        }
    }

    public void updateGame() {
        spawnTimer++;
        if (spawnTimer >= spawnInterval) {
            spawnTimer = 0;
            float ey = groundY - 40;
            float speed = 4 + p.random(0, 2) + score * 0.05f;
            enemies.add(new Enemy(p, p.width + 40, ey, 40, 40, -speed));
            spawnInterval = Math.max(60, (int)(120 - score * 0.8f));
        }

        player.update(groundY);

        for (int i = enemies.size() - 1; i >= 0; i--) {
            Enemy e = enemies.get(i);
            e.update();
            if (e.x + e.w < -50) {
                enemies.remove(i);
                continue;
            }
            if (e.collidesWith(player)) {
                // consumer handles game over -- just expose scores here
                highScore = Math.max(highScore, score);
                // You can set a flag or call back into the sketch when needed
            }
        }

        for (int i = coins.size() - 1; i >= 0; i--) {
            Coin c = coins.get(i);
            if (c.collectedBy(player)) {
                score++;
                coins.remove(i);
            }
        }

        if (coins.size() == 0) {
            for (int i = 0; i < 6; i++) {
                float cx = p.width + i * 120 + p.random(-20, 20);
                float cy = groundY - 80 - (i % 3) * 30;
                coins.add(new Coin(p, cx, cy, 12));
            }
            spawnTimer = -60;
        }
    }

    public void drawGame() {
        p.fill(65, 150, 70);
        p.rect(0, groundY, p.width, p.height - groundY);
        for (Coin c : coins) c.display(p.frameCount);
        for (Enemy e : enemies) e.display();
        player.display();

        p.fill(255);
        p.textSize(16);
        p.textAlign(PApplet.LEFT, PApplet.TOP);
        p.text("Score: " + score, 10, 10);
        p.text("High: " + highScore, 10, 30);
    }
}