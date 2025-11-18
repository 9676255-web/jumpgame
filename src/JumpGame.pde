int W = 800;
int H = 400;

String state = "start"; // "start", "playing", "gameover"

void setup() {
  size(W, H);
  textAlign(CENTER, CENTER);
  rectMode(CORNER);
  ellipseMode(CENTER);
  smooth();
  groundY = height - 60; // declared in Game.pde
  resetGame();
}

void draw() {
  background(80, 180, 230);
  if (state.equals("start")) {
    drawStartScreen();
  } else if (state.equals("playing")) {
    updateGame();
    drawGame();
  } else if (state.equals("gameover")) {
    drawGameOver();
  }
}

void keyPressed() {
  if (state.equals("start")) {
    if (key == ' ' || keyCode == UP) {
      state = "playing";
    }
  } else if (state.equals("playing")) {
    if (key == ' ' || keyCode == UP) {
      player.jump();
    }
  } else if (state.equals("gameover")) {
    if (key == 'r' || key == 'R') {
      resetGame();
      state = "playing";
    } else if (key == ' ' || keyCode == UP) {
      state = "start";
      resetGame();
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
