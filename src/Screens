void drawGround() {
  fill(120, 80, 40);                     // Brown ground color
  rect(0, groundY, width, height - groundY); // Draw ground rectangle at bottom
  stroke(80, 50, 20);                    // Darker outline color
  line(0, groundY, width, groundY);      // Line marking ground top edge
}

void drawGame() {

  // --- COINS ---
  for (Coin c : coins) c.display();      // Draw all coins

  // --- ENEMIES ---
  for (Enemy e : enemies) e.display();   // Draw all enemies

  // --- PLAYER ---
  player.display();                      // Draw player character

  // --- PARTICLES ---
  for (int i = deathParticles.size()-1; i >= 0; i--) { // Loop backwards so removal is safe
    Particle p = deathParticles.get(i); // Get particle
    p.update();                         // Update position + physics
    p.display();                        // Draw it
    if (p.dead()) deathParticles.remove(i); // Remove if lifetime ended
  }

  // --- SPAWN INDICATOR ---
  if (indicatorFramesLeft > 0) {         // Only visible for 60 frames
    stroke(255, 0, 0);                   // Red indicator line
    strokeWeight(3);                     // Line thickness
    line(nextSpawnX, 0, nextSpawnX, height); // Show where next object will spawn
    noStroke();                          // Reset stroke
  }

  // --- SCORE DISPLAY ---
  fill(0);                              // Black text
  textSize(24);                         // Score font size
  textAlign(LEFT, TOP);                 // Top-left alignment
  text("Score: " + score, 10, 10);      // Draw score text
}

void drawStartScreen() {
  fill(0, 150);                          // Transparent dark overlay
  rect(0, 0, width, height);             // Cover whole screen

  fill(255);                             // White text
  textSize(48);                          
  text("JUMPY RUNNER", width/2, height/2 - 50); // Game title

  textSize(24);
  text("Press SPACE or UP to Start", width/2, height/2 + 20); // Start instructions

  textSize(16);
  text("Press M for Menu", width/2, height/2 + 60); // Menu shortcut
}

void drawMenuScreen() {
  fill(0, 180);                          // Semi-transparent background
  rect(0, 0, width, height);

  fill(255);
  textSize(50);
  text("MENU", width/2, 100);            // Menu title

  textSize(28);
  text("1. Play (Press P)", width/2, 220);        // Option 1
  text("2. Settings (Press T)", width/2, 260);    // Option 2
  text("3. Stats (Press A)", width/2, 300);       // Option 3

  textSize(20);
  text("Press S to return to Start", width/2, height - 40); // Return instruction
}

void drawSettingsScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textSize(48);
  text("SETTINGS", width/2, 100);        // Settings header

  textSize(24);
  text("• Game speed (auto)", width/2, 240);      // Option placeholders
  text("• Sound Options", width/2, 280);
  text("• Color Themes", width/2, 320);

  textSize(20);
  text("Press M for Menu", width/2, height - 40); // Return to menu
}

void drawPauseScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255,255,0);
  textSize(48);
  text("PAUSED", width/2, height/2);              // Pause header

  textSize(20);
  text("Press P to Resume", width/2, height/2 + 50); // Resume
  text("Press S for Start", width/2, height/2 + 80); // Back to start
}

void drawGameOver() {
  fill(0, 150);
  rect(0, 0, width, height);               // Dark overlay

  fill(255, 0, 0);
  textSize(64);
  text("GAME OVER", width/2, height/2 - 70); // Big game-over message

  fill(255);
  textSize(32);
  text("Score: " + score, width/2, height/2);          // Final score
  text("High Score: " + highScore, width/2, height/2 + 40); // High score

  textSize(20);
  text("Press R to Play Again", width/2, height/2 + 90); // Restart
  text("Press S for Start", width/2, height/2 + 120);    // Back to start
}

void drawStatsScreen() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textSize(50);
  text("STATS", width/2, 100);             // Stats header

  textSize(28);
  text("High Score: " + highScore, width/2, 240); // Show high score

  textSize(20);
  text("Press M for Menu", width/2, height - 40); // Return to menu
}
