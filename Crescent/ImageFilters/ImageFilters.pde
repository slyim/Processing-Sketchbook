PImage gorsel;
PImage gray, threshold, invert, poster, blur;
char currentMode = 's'; //start mode

void setup() {
  size(600, 600);
  gorsel = loadImage("Flowers.jpg");
  gray = gorsel.get();
  threshold = gorsel.get();
  invert = gorsel.get();
  poster = gorsel.get();
  blur = gorsel.get();

  gray.filter(GRAY);
  threshold.filter(THRESHOLD, 0.5);
  invert.filter(INVERT);
  poster.filter(POSTERIZE, 4);
  blur.filter(BLUR, 4);
}

void draw() {
  if (currentMode == 's') {
    image(gorsel, 0, 0, width, height);
  }
  if (currentMode == 'g') {
    image(gray, 0, 0, width, height);
  }
  if (currentMode == 't') {
    image(threshold, 0, 0, width, height);
  }
  if (currentMode == 'i') {
    image(invert, 0, 0, width, height);
  }
  if (currentMode == 'p') {
    image(poster, 0, 0, width, height);
  }
  if (currentMode == 'b') {
    image(blur, 0, 0, width, height);
  }
}

void keyPressed() {
  if (key == 'g') {
    currentMode = 'g';
  } else if (key == 't') {
    currentMode = 't';
  } else if (key == 'i') {
    currentMode = 'i';
  } else if (key == 'p') {
    currentMode = 'p';
  } else if (key == 'b') {
    currentMode = 'b';
  } else if (key == 's') {
    currentMode = 's';
  }
}
