// Carribean coinflip game, made by Lila Aydin

PImage coinF, coinB;
PImage num1, num2, num3;
PImage bgSea;
PFont font;

boolean coinisF;

// immutable olarak yaptim cunku zaten veriler degismeyecek.
// veriler ekrana da text olarak yazilacak bu yuzden anlamlilar.
// state will help me cycle through states


// kodu daha okunabilir yapmak icin switch caseler ve buttononclickte kullanmak icin.
final int IDLE = 0;
final int COUNTDOWN = 1;
final int RESULT = 2;

int state = IDLE;
Button flipButton;
PImage buttonImg;

// idle 0, cd 1, flipping 2, result 3
int countdownS;

void setup() {
  size(800, 800, P3D);
  background(#320E3B);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  fill(0);

  font = createFont("PirataOne-Regular.ttf", 72);
  textFont(font);

  coinF = loadImage("CoinF.png");
  coinB = loadImage("CoinB.png");
  num1 = loadImage("num1.png");
  num2 = loadImage("num2.png");
  num3 = loadImage("num3.png");
  bgSea = loadImage("bgSea.png");

  buttonImg = loadImage("button.png");
  flipButton = new Button(width/2, height - 100, width/4, height/10, buttonImg);
}

void draw() {
  image(bgSea, width/2, height/2);

  // if else yerine switch case kullanildi.

  switch (state) {
    // 1. asama menu sayfasi vs
  case IDLE:
    text("Flip your fate...", width/2, 100);
    image(coinF, width/2, height/2, width/2, height/2);
    flipButton.display();
    break;
    // 2. asama millis ile 1000 esittir 1 saniye oluyo burada sayilari tek tek ekrana yazdirip sonraki case geciyor.
  case COUNTDOWN:
    int elapsed = millis() - countdownS;

    if (elapsed < 1000) {
      image (num3, width/2, height/2, width/2, height/2);
    } else if (elapsed < 2000) {
      image (num2, width/2, height/2, width/2, height/2);
    } else if (elapsed < 3000) {
      image (num1, width/2, height/2, width/2, height/2);
    } else {
      state = RESULT;
      coinisF = random(1) < 0.5;
    }
    break;
  case RESULT:
    //Sonuc, random fonksiyonu da kullanildi.
    //zaten true degerini alacak == TRUE yazmaya gerek yok ustteki sonuc coinF boolean sadece iki durum var.
    if (coinisF) {
      image(coinF, width/2, height/2, width/2, height/2);
      text("Heads!", width/2, 100);
    } else {
      image(coinB, width/2, height/2, width/2, height/2);
      text("Tails!", width/2, 100);
    }
    break;
  }
}

// press action
void mousePressed() {
  if (state == IDLE && flipButton.isHovered()) {
    state = COUNTDOWN;
    countdownS = millis();
  }

  // replay game fonksiyonu
  if (state == RESULT) {
    state = IDLE;
  }
}


// button class
class Button {
  float x, y, w, h;
  PImage button;

  Button(float x, float y, float w, float h, PImage button) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.button = button;
  }

  void display() {
    image(button, x, y, w, h);
  }

  boolean isHovered() {
    return mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2;
  }
}
