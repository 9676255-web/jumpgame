// Game.pde - globals and game logic

Player player;
ArrayList<Enemy> enemies;
ArrayList<Coin> coins;

int groundY;
int spawnTimer = 0;
int spawnInterval = 120; // frames between enemies
int score = 0;
int highScore = 0;

void resetGame() {
  player = new Player(100, groundY - 50, 40, 50);
  enemies = new ArrayList<Enemy>();
  coins = new ArrayList<Coin>();
  score = 0;
  spawnTimer = 0;
  spawnInterval = 120;
  // Create some coins across the level
  for (int i = 0; i < 8; i++) {
    float cx = 300 + i * 80 + random(-20, 20);
    float cy = groundY - 80 - (i % 3) * 30;
    coins.add(new Coin(cx, cy, 12));
  }
}

void updateGame() {
  // Spawn enemies periodically
  spawnTimer++;
  if (spawnTimer >= spawnInterval) {
    spawnTimer = 0;
    float ey = groundY - 40;
    float speed = 4 + random(0, 2) + score*0.05;
    enemies.add(new Enemy(width + 40, ey, 40, 40, -speed));
    spawnInterval = max(60, int(120 - score*0.8));
  }

  // update player
  player.update();

  // update enemies and check collisions
  for (int i = enemies.size()-1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.update();
    if (e.x + e.w < -50) {
      enemies.remove(i);
      continue;
    }
    if (e.collidesWith(player)) {
      state = "gameover";
      highScore = max(highScore, score);
    }
  }

  // coin collection
  for (int i = coins.size()-1; i >= 0; i--) {
    Coin c = coins.get(i);
    // move coins slightly left to create sense of forward motion if they were placed ahead
    c.x -=
