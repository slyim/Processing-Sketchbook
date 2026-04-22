PFont header1;
PFont header2;
PFont sub;

String str1 = "What even is BOLD?";
String str2 = "think small be different";
String str3 = "What even is a bread?";

void setup() {
  size(800, 800, P3D);
  background(#320E3B);

  header1 = createFont("Lexend-Black", 48);
  header2 = createFont("Silver", 48);
  sub = createFont("Lexend-Thin", 24);

  rectMode(CENTER);
  textAlign(CENTER);
}

void draw() {
  background(#320E3B);

  // --- Cube Logic ---
  pushMatrix(); // Isolate the transformation so it doesn't affect the text
  translate(width/2, height/2 - 100); // Move to the position

  // Rotate based on frameCount to create animation
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);

  fill(#E56399);
  noStroke();
  box(50); // This creates the 3D cube (width, height, depth all 50)
  popMatrix(); // Restore coordinate system

  // --- Text Rendering ---
  fill(#E56399);
  textFont(header1);
  text(str1, width/2, height/2);

  textFont(header2);
  text(str3, width/2, height/2 + 50);

  textFont(sub);
  text(str2, width/2, height/2 + 100);
}
