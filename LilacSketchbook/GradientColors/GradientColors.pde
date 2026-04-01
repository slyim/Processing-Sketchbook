int i;
int numColors = 5;
color gradientColors[] = { #00ff2a, #ff0000};
color bgColor = lerpColor(gradientColors[0], gradientColors[1], 0.1);

void setup() {
  size(600, 600);
}
void draw() {
  
  for (i = 0; i < width; i++) {
    
    int gradientMap = i / (width / numColors); 
    
    float t = map(gradientMap, 0, numColors - 1, 0, 1);
    color gradient = lerpColor(gradientColors[0], gradientColors[1], t);
    
    stroke(gradient);  
    line(i, 0, i, height);
  }
  fill(bgColor);
  noStroke();
  rect(0, 0, width, height/5);
  rect(0, height*4/5, width, height/5);
}