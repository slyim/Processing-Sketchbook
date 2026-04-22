float x, y, z;

void setup (){
  size(800, 600, P3D);
  background(#39375B);
  x = width / 2;
  y = height / 2;
  z = 0;
}

void draw() {
  translate(x, y, z);“
  lights();
  sphere();
}
