final int STAY = 0;
final int MOVELEFT = 1;
final int MOVERIGHT = 2;
final int SHOOT = 3;
final int GAMEOVER = 4;

int state = STAY;

// character
float rectX, rectY;
int rectWidth, rectHeight;

// enemy
float enemyX, enemyY;
float speed = 5;

// bullet
float bulletX, bulletY;
boolean bulletActive = false;
float bulletSpeed = 12;

void setup() {
  textSize(102);
  textAlign(CENTER, CENTER);
  size(800, 800);
  rectMode(CENTER);

  rectWidth = 150;
  rectHeight = 150;

  rectX = width / 2;
  rectY = height - rectHeight / 2;

  enemyX = random(60, 540);
  enemyY = 60;
}

void draw() {
  background(50);


  if (bulletActive) {
    bulletY -= bulletSpeed;
    stroke(255);
    line(bulletX, bulletY, bulletX, bulletY - 20);
    if (bulletY < 0) bulletActive = false;
  }

  if (state == GAMEOVER) {
    fill(255, 0, 0);
    text("GAME OVER!", width/2, height/2);
    return;
  }

  switch (state) {
  case STAY:
    break;
  case MOVELEFT:
    rectX -= speed;
    break;
  case MOVERIGHT:
    rectX += speed;
    break;
  case SHOOT:
    if (!bulletActive) {
      bulletX = rectX;
      bulletY = rectY - rectHeight / 2;
      bulletActive = true;
    }
    break;
  }

  stroke(155);
  line(0, height - rectHeight, width, height - rectHeight);

  fill(155);
  rect(rectX, rectY, rectWidth, rectHeight);

  enemyY += 1;
  if (enemyY >= height - rectHeight - 30) {
    state = GAMEOVER;
  }

  // asteroid
  fill(255, 0, 0);
  rect(enemyX, enemyY, 50, 50);
}

void keyPressed() {
  if (keyCode == LEFT) {
    state = MOVELEFT;
  } else if (keyCode == RIGHT) {
    state = MOVERIGHT;
  } else if (keyCode == UP || key == ' ') {
    state = SHOOT;
  }
}
