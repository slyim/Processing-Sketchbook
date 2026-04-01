void setup() {
  background(0);
  size(640, 360);
  
  float miles = 100; 
  
  float kilometers = milesToKm(miles);
  println(kilometers);
  
  stroke(255);
  strokeWeight(4);
  line(10, 100, 10 + miles, 100);
  line(10, 200, 10 + kilometers, 200);
}


float milesToKm(float miles) {
  
  float km = miles * 1.60934;
  return km;
}
