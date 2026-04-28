PFont font;
String msg = "Tickle me!";
float textX = 100;
float textY = 400;
int ticklePower = 2;

void setup () {
  background(#C42021);
  size (800, 800);
  font = createFont("RubikGemstones-Regular.ttf", 48);
  textFont(font);
}

void draw() {
  background(#3C1742);
  if (isInText()) {
    textX += random(ticklePower * -1, ticklePower);
    textY += random(ticklePower * -1, ticklePower);

    textX = constrain(textX, 0, width - textWidth(msg));
    textY = constrain(textY, textAscent(), height - textDescent());
  }
  fill(#F3FFB9);
  text(msg, textX, textY);
}

boolean isInText() {
  float left   = textX;
  float right  = textX + textWidth(msg);
  float top    = textY - textAscent();
  float bottom = textY + textDescent();
  return mouseX > left && mouseX < right && mouseY > top && mouseY < bottom;
}
