// Joey Zheng | Xadian Butcher 2025 GameDev 1

String state = "start";               // Tracks which screen/game state is active

int groundY;                          // Y position of ground
int score = 0;                        // Player's current score
int highScore = 0;                    // Highest score reached

Player player;                        // Player object
ArrayList<Enemy> enemies;             // List of enemies on screen
ArrayList<Coin> coins;                // List of coins on screen
ArrayList<Particle> deathParticles;   // Particles displayed on death

int spawnTimer = 0;                   // Counts frames until next enemy spawn
int spawnInterval = 120;              // How often enemies spawn (in frames)
int coinSpawnTimer = 0;               // Counts frames until next coin spawn
int coinSpawnInterval = 90;           // How often coins spawn (in frames)

float gameSpeed = 4;                  // Base movement speed of game

// Variables for enemy spawn indicator (warning before an obstacle appears)
float nextSpawnX = 0;                 // X position where next enemy will appear
int indicatorFramesLeft = 0;          // Frames remaining to show indicator (<=60)

void setup() {
  size(500, 500);                     // Set window size
  textAlign(CENTER, CENTER);          // Center text both vertically & horizontally
  rectMode(CORNER);                   // Draw rectangles from top-left corner
  ellipseMode(CENTER);                // Draw ellipses from center
  smooth();                           // Enable antialiasing for cleaner visuals

  groundY = height - 60;              // Position ground near bottom of screen
  resetGame();                        // Initialize all game variables and objects
}

void draw() {
  background(80, 180, 230);           // Sky blue background
  drawGround();                       // Draw ground at bottom of screen

  // Handle screen-specific behavior depending on current state
  switch(state) {

    case "start":                     // Start screen
      drawStartScreen();
      break;

    case "menu":                      // Main menu screen
      drawMenuScreen();
      break;

    case "settings":                  // Settings/options screen
      drawSettingsScreen();
      break;

    case "playing":                   // Active game state
      updateGame();                   // Update game logic
      drawGame();                     // Draw everything on screen
      break;

    case "pause":                     // Game is paused
      drawGame();                     // Still draw game scene
      drawPauseScreen();              // Overlay pause UI
      break;

    case "gameover":                  // When player dies
      drawGame();                     // Show last frame of gameplay
      drawGameOver();                 // Display "game over" panel
      break;

    case "stats":                     // Stats or leaderboard page
      drawStatsScreen();
      break;
  }
}

void keyPressed() {

  // Quick state-switching (debug/testing shortcuts)
  if (key == 's') state = "start";
  if (key == 'm') state = "menu";
  if (key == 't') state = "settings";
  if (key == 'p') state = "playing";
  if (key == 'u') state = "pause";
  if (key == 'g') state = "gameover";
  if (key == 'a') state = "stats";

  // --- STATE-SPECIFIC KEY HANDLING ---

  if (state.equals("start")) {        // On start screen
    if (key == ' ' || keyCode == UP)  // Space or up arrow starts the game
      state = "playing";

  } else if (state.equals("playing")) {   // During gameplay
    if (key == ' ' || keyCode == UP)      // Space or up arrow makes player jump
      player.jump();

  } else if (state.equals("gameover")) {  // On game over screen
    if (key == 'r' || key == 'R') {       // Press R to restart
      resetGame();                        // Reset everything
      state = "playing";                  // Start a new run
    }
  }
}

void mousePressed() {

  // Mouse click starts the game from start screen
  if (state.equals("start"))
    state = "playing";

  // Clicking during game acts as jump
  else if (state.equals("playing"))
    player.jump();

  // Clicking on game over resets the game and restarts immediately
  else if (state.equals("gameover")) {
    resetGame();                          // Reset everything
    state = "playing";                    // Start new run
  }
}
