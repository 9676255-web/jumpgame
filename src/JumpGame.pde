// MainSketch.pde  (MAIN FILE)

int W = 800;
int H = 400;

// state, player, enemies, groundY, score, etc. come from Game.pde

void settings() {
  // Processing 4 requires size() to be here if any code runs before setup()
  size(W, H);
}

void setup() {
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

  if (state.equals("start")) {
    drawStartScreen();
  } else if (state.equals("playing")) {
    updateGame();
    drawGame();
  } else if (state.equals("gameover")) {
    drawGame();
    drawGameOver();
  }
}

void keyPressed() {
  if (state.equals("start")) {
    if (key == ' ' || keyCode == UP) state = "playing";
    
  } else if (state.equals("playing")) {
    if (key == ' ' || keyCode == UP) player.jump();
    
  } else if (state.equals("gameover")) {
    if (key == 'r' || key == 'R') {
      resetGame();
      state = "playing";
    } else if (key == ' ' || keyCode == UP) {
      resetGame();
      state = "start";
    }
  }
}

void mousePressed() {
  if (state.equals("start")) {
    state = "playing";
  } else if (state.equals("playing")) {
    player.jump();
  } else if (state.equals("gameover")) {
    resetGame();
    state = "playing";
  }
}

// --- Drawing functions --------------------------------------------------------

void drawGround() {
  fill(120, 80, 40); 
  rect(0, groundY, width, height - groundY);
  
  stroke(80, 50, 20);
  line(0, groundY, width, groundY);
}

void drawGame() {
  for (Coin c : coins) c.display();
  for (Enemy e : enemies) e.display();
  player.display();
  
  fill(0);
  textSize(24);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10);
}

void drawStartScreen() {
  fill(0, 150);
  rect(0, 0, width, height);
  
  fill(255);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("JUMPY RUNNER", width/2, height/2 - 50);
  
  textSize(24);
  text("Press SPACE or UP to Start", width/2, height/2 + 20);
}

void drawGameOver() {
  fill(0, 150);
  rect(0, 0, width, height);
  
  fill(255, 0, 0);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2 - 70);
  
  fill(255);
  textSize(32);
  text("Score: " + score, width/2, height/2);
  text("High Score: " + highScore, width/2, height/2 + 40);
  
  textSize(20);
  text("Press 'R' to Play Again", width/2, height/2 + 90);
  text("Press SPACE to return to Start", width/2, height/2 + 120);
}
