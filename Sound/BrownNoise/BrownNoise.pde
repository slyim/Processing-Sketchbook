import processing.sound.*;
WhiteNoise noise;

void setup() {
  size(640, 360);
  background(255);

  noise = new WhiteNoise(this);
  noise.play();
}

void draw() {
}