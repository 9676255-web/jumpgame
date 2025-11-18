// Game.pde - Globals, game logic, and object classes

// --- Global Variables ---------------------------------------------------------

Player player;
ArrayList<Enemy> enemies;
ArrayList<Coin> coins;

int groundY;
int spawnTimer = 0;
int spawnInterval = 120;
int score = 0;
int highScore = 0;
float gameSpeed = 4;

String state = "start";

// --- Game Reset ---------------------------------------------------------------

void resetGame() {
  player = new Player(100, groundY - 50, 40, 50);
  enemies = new ArrayList<Enemy>();
  coins = new ArrayList<Coin>();
  
  score = 0;
  spawnTimer = 0;
  spawnInterval = 120;
  gameSpeed = 4;

  for (int i = 0; i < 8; i++) {
    float cx = 300 + i * 120 + random(-20, 20);
    float cy = groundY - 80 - (i % 3) * 30;
    coins.add(new Coin(cx, cy, 12));
  }
}

// --- Game Update --------------------------------------------------------------

void updateGame() {
  gameSpeed = 4 + score * 0.05;

  spawnTimer++;
  if (spawnTimer >= spawnInterval) {
    spawnTimer = 0;
    float ey = groundY - 40;
    float speed = -(gameSpeed + random(0, 1.5));
    enemies.add(new Enemy(width + 40, ey, 40, 40, speed));
    spawnInterval = max(60, int(120 - score * 0.8));
  }

  player.update();

  for (int i = enemies.size()-1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.update();
    if (e.x + e.w < -50) {
      enemies.remove(i);
      score += 1;
      continue;
    }
    if (e.collidesWith(player)) {
      state = "gameover";
      highScore = max(highScore, score);
    }
  }

  for (int i = coins.size()-1; i >= 0; i--) {
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

// --- Classes ------------------------------------------------------------------

class Player {
  float x, y, w, h;
  float yVel = 0;
  float gravity = 0.6;
  float jumpPower = -12;
  boolean onGround = true;

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
      onGround = true;
    }
  }

  void jump() {
    if (onGround) {
      yVel = jumpPower;
      onGround = false;
    }
  }

  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }

  boolean collidesWith(Object other) {
    if (other instanceof Enemy) {
      Enemy e = (Enemy) other;
      return (x < e.x + e.w && x + w > e.x &&
              y < e.y + e.h && y + h > e.y);
    } 
    else if (other instanceof Coin) {
      Coin c = (Coin) other;
      float dx = c.x - (x + w/2);
      float dy = c.y - (y + h/2);
      float distSq = dx*dx + dy*dy;
      float rad = c.r + w/2;
      return distSq < rad * rad;
    }
    return false;
  }
}

class Enemy {
  float x, y, w, h;
  float speed;

  Enemy(float x, float y, float w, float h, float speed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
  }

  void update() {
    x += speed;
  }

  void display() {
    fill(255, 0, 0);
    rect(x, y, w, h);
  }

  boolean collidesWith(Player p) {
    return (x < p.x + p.w && x + w > p.x &&
            y < p.y + p.h && y + h > p.y);
  }
}

class Coin {
  float x, y, r;

  Coin(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  void display() {
    float angle = radians(frameCount * 5);
    pushMatrix();
    translate(x, y);
    rotateY(angle);
    
    fill(255, 200, 0);
    ellipse(0, 0, r*2, r*2);
    
    fill(255, 230, 100);
    ellipse(0, 0, r*1.5, r*1.5);

    popMatrix();
  }
}
