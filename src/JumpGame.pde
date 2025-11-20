String state = "start";  
int groundY;

int score = 0;
int highScore = 0;

Player player;
ArrayList<Coin> coins;
ArrayList<Enemy> enemies;

// -------------------------------------------------------------------

void setup() {
  size(500,500);
  textAlign(CENTER, CENTER);
  rectMode(CORNER);
  ellipseMode(CENTER);
  smooth();

  groundY = height - 60;
  resetGame();
}

void draw() {
  background(80, 180, 230);
  drawGround();

  switch(state) {

    case "start":
      drawStartScreen();
      break;

    case "menu":
      drawMenuScreen();
      break;

    case "settings":
      drawSettingsScreen();
      break;

    case "playing":
      updateGame();
      drawGame();
      break;

    case "pause":
      drawGame();
      drawPauseScreen();
      break;

    case "gameover":
      drawGame();
      drawGameOver();
      break;

    case "stats":
      drawStatsScreen();
      break;
  }
}

// -------------------------------------------------------------------
// INPUT HANDLING
// -------------------------------------------------------------------

void keyPressed() {

  // Global hotkeys (override)
  if (key == 's') state = "start";
  if (key == 'm') state = "menu";
  if (key == 't') state = "settings";
  if (key == 'p') state = "playing";
  if (key == 'u') state = "pause";
  if (key == 'g') state = "gameover";
  if (key == 'a') state = "stats";

  // Gameplay specific
  if (state.equals("start")) {
    if (key == ' ' || keyCode == UP) state = "playing";

  } else if (state.equals("playing")) {
    if (key == ' ' || keyCode == UP) player.jump();

  } else if (state.equals("gameover")) {
    if (key == 'r' || key == 'R') {
      resetGame();
      state = "playing";
    }
  }
}

void mousePressed() {
  if (state.equals("start")) state = "playing";
  else if (state.equals("playing")) player.jump();
  else if (state.equals("gameover")) {
    resetGame();
    state = "playing";
  }
}

// -------------------------------------------------------------------
// DRAWING
// -------------------------------------------------------------------

void drawGround() {
  fill(120, 80, 40);
  rect(0, groundY, width, height - groundY);
  stroke(80, 50, 20);
  line(0, groundY, width, groundY);
}

void drawGame() {
  for (Coin c : coins)   c.display();
  for (Enemy e : enemies) e.display();
  player.display();

  fill(0);
  textSize(24);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10);
}

// -------------------------------------------------------------------
// NEW SCREENS
// -------------------------------------------------------------------

void drawStartScreen() {
  fill(0, 150);
  rect(0, 0, width, height);

  fill(255);
  textSize(48);
  text("JUMPY RUNNER", width/2, height/2 - 50);

  textSize(24);
  text("Press SPACE or UP to Start", width/2, height/2 + 20);

  textSize(16);
  text("Press M for Menu", width/2, height/2 + 60);
}

void drawMenuScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textSize(50);
  text("MENU", width/2, 100);

  textSize(28);
  text("1. Play (Press P)", width/2, 220);
  text("2. Settings (Press T)", width/2, 260);
  text("3. Stats (Press A)", width/2, 300);

  textSize(20);
  text("Press S to return to Start", width/2, height - 40);
}

void drawSettingsScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textSize(48);
  text("SETTINGS", width/2, 100);

  textSize(24);
  text("• (Placeholder) Game speed", width/2, 240);
  text("• (Placeholder) Sound Options", width/2, 280);
  text("• (Placeholder) Color Themes", width/2, 320);

  textSize(20);
  text("Press M for Menu", width/2, height - 40);
}

void drawPauseScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255,255,0);
  textSize(48);
  text("PAUSED", width/2, height/2);

  textSize(20);
  text("Press P to Resume", width/2, height/2 + 50);
  text("Press S for Start", width/2, height/2 + 80);
}

void drawGameOver() {
  fill(0, 150);
  rect(0, 0, width, height);

  fill(255, 0, 0);
  textSize(64);
  text("GAME OVER", width/2, height/2 - 70);

  fill(255);
  textSize(32);
  text("Score: " + score, width/2, height/2);
  text("High Score: " + highScore, width/2, height/2 + 40);

  textSize(20);
  text("Press R to Play Again", width/2, height/2 + 90);
  text("Press S for Start", width/2, height/2 + 120);
}

void drawStatsScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textSize(50);
  text("STATS", width/2, 100);

  textSize(28);
  text("High Score: " + highScore, width/2, 240);

  textSize(20);
  text("Press M for Menu", width/2, height - 40);
}

// -------------------------------------------------------------------
// EXISTING GAME LOGIC (unchanged)
// -------------------------------------------------------------------

void resetGame() {
  score = 0;
  player = new Player();
  coins = new ArrayList<Coin>();
  enemies = new ArrayList<Enemy>();
}
