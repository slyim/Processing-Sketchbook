// Tıklanabilir düğme: tıklandığında rengi değişir.

boolean buttonState = false; // false = kapalı, true = açık
color backgroundColor = #606168;

void setup() {
  size(400, 400);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  background(backgroundColor);
  if (buttonState) {
    fill(#eff2ff); // Açık renk
  } else {
    fill(#888a9b); // Kapalı renk
  }
  rect(width/2, height/2, height/2, height/4, 20); // Yuvarlak köşeli düğme
}

// Fare düğme üzerinde tıklandığında durumu bir kere değiştir
void mousePressed() {
  if (mouseX > width/2 - height/4 && mouseX < width/2 + height/4 &&
      mouseY > height/2 - height/8 && mouseY < height/2 + height/8) {
    buttonState = !buttonState;
  }
}
