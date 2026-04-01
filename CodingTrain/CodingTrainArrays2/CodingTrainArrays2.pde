float[] fruitInventory = new float[5];
String[] fruitNames = {"mango", "strawberry", "kiwi", "plum", "blueberry"};

void setup() {
  size(640, 360);
  
  for (int i = 0; i < fruitInventory.length; i++) {
    fruitInventory[i] = random(50, 100);
  }
}

void draw() {
  background(0);
  strokeWeight(24);
  stroke(255);
  strokeCap(SQUARE);
  textAlign(CENTER);
  textSize(24);
  fill(255);
  
  for (int i = 0; i < fruitNames.length; i++) {
    
  float x = 100 + i * 100;
  line(x, height/2, x , height/2 - fruitInventory[i]);
  text(fruitNames[i], x, height/2 + 64); 
  }
}
