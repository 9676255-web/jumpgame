// Game.pde - Globals, game logic, and object classes

Player player;
ArrayList<Enemy> enemies;
ArrayList<Coin> coins;

int groundY;
int spawnTimer = 0;
int coinSpawnTimer = 0;

int spawnInterval = 120;
int coinSpawnInterval = 90;

int score = 0;
int highScore = 0;

float gameSpeed = 4;

String state = "start";

// --- Reset Game ---------------------------------------------------------------

void resetGame() {
  player = new Player(100, groundY - 50, 40, 50);

  enemies = new ArrayList<Enemy>();
  coins = new ArrayList<Coin>();

  score = 0;
  spawnTimer = 0;
  coinSpawnTimer = 0;

  spawnInterval = 120;
  coinSpawnInterval = 90;

  gameSpeed = 4;
}

// --- Main Game Update ---------------------------------------------------------

void updateGame() {

  gameSpeed = 4 + score * 0.07;

  // --------- ENEMY SPAWNING ---------------------------------------------------
  spawnTimer++;

  if (spawnTimer >= spawnInterval) {
    spawnTimer = 0;

    int type = int(random(3));   // 0 small, 1 big, 2 flying
    Enemy e;

    if (type == 0) {
      e = new Enemy(width + 40, groundY - 30, 30, 30,
                    -(gameSpeed + random(2, 5)), 0);

    } else if (type == 1) {
      e = new Enemy(width + 40, groundY - 60, 60, 60,
                    -(gameSpeed + random(0, 2)), 1);

    } else {
      float fy = groundY - 150 - random(0, 60);
      e = new Enemy(width + 40, fy, 40, 40,
                    -(gameSpeed + random(1, 4)), 2);
    }

    enemies.add(e);

    spawnInterval = max(50, int(120 - score * 0.6));
  }

  // --------- COIN SPAWNING ----------------------------------------------------
  coinSpawnTimer++;
  if (coinSpawnTimer >= coinSpawnInterval) {
    coinSpawnTimer = 0;

    float cy = groundY - 80 - random(0, 150);
    coins.add(new Coin(width + 20, cy, 12));

    coinSpawnInterval = max(40, int(90 - score * 0.3));
  }

  // --------- UPDATE PLAYER ----------------------------------------------------
  player.update();

  // --------- UPDATE ENEMIES ---------------------------------------------------
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.update();

    if (e.x + e.w < -50) {
      enemies.remove(i);
      score++;
      continue;
    }
    if (e.collidesWith(player)) {
      state = "gameover";
      highScore = max(highScore, score);
    }
  }

  // --------- UPDATE COINS -----------------------------------------------------
  for (int i = coins.size() - 1; i >= 0; i--) {
    Coin c = coins.get(i);
    c.x -= gameSpeed * 0.8;

    if (c.x + c.r < 0) {
      coins.remove(i);
      continue;
    }

    if (player.collidesWith(c)) {
      coins.remove(i);
      score += 10;
    }
  }
}

// --- PLAYER WITH DOUBLE JUMP --------------------------------------------------

class Player {
  float x, y, w, h;
  float yVel = 0;
  float gravity = 0.6;

  float jumpPower = -12;
  float doubleJumpPower = -10;

  int jumpsLeft = 2;  // <-- Double jump enabled

  Player(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update() {
    y += yVel;
    yVel += gravity;

    if (y + h >= groundY) {
      y = groundY - h;
      yVel = 0;
      jumpsLeft = 2;        // <-- Reset double jump when touching ground
    }
  }

  void jump() {
    if (jumpsLeft > 0) {
      if (jumpsLeft == 2) {
        yVel = jumpPower;   // First jump
      } else {
        yVel = doubleJumpPower; // Second jump
      }
      jumpsLeft--;
    }
  }

  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }

  boolean collidesWith(Object other) {
    if (other instanceof Enemy) {
      Enemy e = (Enemy) other;
      return (x < e.x + e.w &&
              x + w > e.x &&
              y < e.y + e.h &&
              y + h > e.y);
    } else if (other instanceof Coin) {
      Coin c = (Coin) other;
      float dx = c.x - (x + w/2);
      float dy = c.y - (y + h/2);
      float distSq = dx*dx + dy*dy;
      float radius = c.r + w/2;
      return distSq < radius * radius;
    }
    return false;
  }
}

// --- ENEMY --------------------------------------------------------------------

class Enemy {
  float x, y, w, h;
  float speed;
  int type;

  Enemy(float x, float y, float w, float h, float speed, int type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.type = type;
  }

  void update() {
    x += speed;

    if (type == 2) {
      y += sin(frameCount * 0.1) * 1.5;
    }
  }

  void display() {
    if (type == 0) fill(255, 50, 50);
    else if (type == 1) fill(200, 0, 0);
    else fill(255, 120, 0);

    rect(x, y, w, h);
  }

  boolean collidesWith(Player p) {
    return (x < p.x + p.w &&
            x + w > p.x &&
            y < p.y + p.h &&
            y + h > p.y);
  }
}

// --- COIN ---------------------------------------------------------------------

class Coin {
  float x, y, r;

  Coin(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  void display() {
    float angle = radians(frameCount * 6);
    pushMatrix();
    translate(x, y);
    rotateY(angle);

    fill(255, 200, 0);
    ellipse(0, 0, r*2, r*2);

    fill(255, 230, 80);
    ellipse(0, 0, r*1.4, r*1.4);

    popMatrix();
  }
}
