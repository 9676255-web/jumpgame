// JumpGame.pde (main game file) - instantiate every class to check connections
Player player;
ArrayList<Platform> platforms;

void setup() {
  size(800, 600);
  // instantiate
  player = new Player(100, 400);
  platforms = new ArrayList<Platform>();

  // example platforms to test interactions
  platforms.add(new Platform(50, 500, 200, 16));
  platforms.add(new Platform(300, 420, 160, 16));
  platforms.add(new Platform(520, 360, 180, 16));
}

void draw() {
  background(200);

  // update & display platforms
  for (Platform p : platforms) {
    p.display();
  }
  player.move();
  player.display();

  // basic HUD
  fill(0);
  textSize(12);
  text("Use LEFT/RIGHT arrows and SPACE to jump", 10, 20);

    if (keyCode == LEFT) {
    player.vx = -4;
  } else if (keyCode == RIGHT) {
    player.vx = 4;
  }
}
}


void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    player.vx = 0;
  }
}
