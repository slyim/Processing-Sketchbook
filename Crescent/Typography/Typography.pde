
PImage photo;
int tSize = 72;

void setup () {
  size(600, 400);
  imageMode(CENTER);
  photo = loadImage("spaceBG.jpg");
}

void draw () {
  image(photo, width/2, height/2);
  textSize(tSize);
  text("Word", width/2, height/2);
}
