// Fonksiyon kullanımını gösteren egzersiz.
// milesToKm() fonksiyonu mil birimini kilometreye çevirir.

void setup() {
  background(0);
  size(640, 360);

  float miles = 100;
  float kilometers = milesToKm(miles); // Dönüşümü çağır
  println(kilometers);                 // Sonucu konsola yazdır

  // İki mesafeyi görsel olarak karşılaştır
  stroke(255);
  strokeWeight(4);
  line(10, 100, 10 + miles,       100); // Mil çizgisi (üstte, daha kısa)
  line(10, 200, 10 + kilometers,  200); // Kilometre çizgisi (altta, daha uzun)
}

// Mil cinsinden mesafeyi kilometreye çevirir
float milesToKm(float miles) {
  return miles * 1.60934;
}
