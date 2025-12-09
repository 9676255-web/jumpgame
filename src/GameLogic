void resetGame() {

  // Create a new player at starting position
  player = new Player(100, groundY - 50, 40, 50);

  // Reset object lists
  enemies = new ArrayList<Enemy>();
  coins = new ArrayList<Coin>();
  deathParticles = new ArrayList<Particle>();

  // Reset score and timers
  score = 0;
  spawnTimer = 0;
  coinSpawnTimer = 0;
  gameSpeed = 4;

  // Reset spawn intervals
  spawnInterval = 120;
  coinSpawnInterval = 90;

  // Reset enemy indicator
  indicatorFramesLeft = 0;
}

void updateGame() {

  // Increase game speed gradually as score increases
  gameSpeed = 4 + score * 0.07;

  // Increment enemy spawn timer every frame
  spawnTimer++;

  // Show spawn indicator for last 60 frames before enemy appears
  if (spawnTimer >= spawnInterval - 60) {
    nextSpawnX = width + 40;            // Where enemy will appear
    indicatorFramesLeft = spawnInterval - spawnTimer; // Frames left to show indicator
  } else {
    indicatorFramesLeft = 0;            // Hide indicator
  }

  // Spawn a new enemy when timer reaches interval
  if (spawnTimer >= spawnInterval) {
    spawnTimer = 0;                     // Reset timer

    int type = int(random(3));          // Choose random enemy type (0–2)
    Enemy e;

    // Spawn small ground enemy
    if (type == 0)
      e = new Enemy(width + 40, groundY - 30, 30, 30, -(gameSpeed + random(2,5)), 0);

    // Spawn large ground enemy
    else if (type == 1)
      e = new Enemy(width + 40, groundY - 60, 60, 60, -(gameSpeed + random(0,2)), 1);

    // Spawn flying enemy
    else {
      float fy = groundY - 150 - random(0, 60);  // Random flying height
      e = new Enemy(width + 40, fy, 40, 40, -(gameSpeed + random(1,4)), 2);
    }

    enemies.add(e);                     // Add enemy to list

    // As score increases, reduce spawn interval (minimum 50)
    spawnInterval = max(50, int(120 - score * 0.6));
  }

  // COIN SPAWNING
  coinSpawnTimer++;                     // Increment coin spawn timer
  if (coinSpawnTimer >= coinSpawnInterval) {

    coinSpawnTimer = 0;                 // Reset timer

    float cy = groundY - 80 - random(0, 150);  // Random coin height
    coins.add(new Coin(width + 20, cy, 12));   // Add coin

    // Reduce spawn interval as score increases (minimum 40)
    coinSpawnInterval = max(40, int(90 - score * 0.3));
  }

  // Update player physics, movement, jumping, etc.
  player.update();

  // UPDATE ENEMIES
  for (int i = enemies.size()-1; i >= 0; i--) {

    Enemy e = enemies.get(i);
    e.update();                         // Move the enemy

    // Remove enemy if it goes off-screen
    if (e.x + e.w < -50) {
      enemies.remove(i);
      score++;                          // Reward point for dodging
      continue;
    }

    // Check collision with player
    if (e.collidesWith(player)) {
      spawnDeathParticles(player.x + player.w/2, player.y + player.h/2); // Death effect
      state = "gameover";               // End game
      highScore = max(highScore, score); // Save high score
    }
  }

  // UPDATE COINS
  for (int i = coins.size()-1; i >= 0; i--) {

    Coin c = coins.get(i);
    c.x -= gameSpeed * 0.8;             // Move coin left across screen

    // Remove if coin goes off-screen
    if (c.x + c.r < 0) {
      coins.remove(i);
      continue;
    }

    // Player collects coin
    if (player.collidesWith(c)) {
      coins.remove(i);                  // Remove collected coin
      score += 10;                      // Add points
    }
  }
}
