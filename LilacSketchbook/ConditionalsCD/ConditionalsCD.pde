// Tuval üçe bölünmüş: sağda daire, ortada kare, solda üçgen çizilir.
// Her bölgede parçacıklar farklı yönde hareket eder.

ArrayList<PVector> particles = new ArrayList<PVector>();
float x;    // Daire / üçgen için boyut değişkeni
float y;    // Kare boyutu
float z;    // Üçgen için yükseklik koordinatı
float trans; // Her karede rastgele şeffaflık

void setup() {
  size(1000, 600);
  background(0);
  noStroke();
}

void draw() {
  noStroke();
  background(0);
  fill(175);
  rectMode(CENTER);
  trans = random(10, 90); // Şeffaflığı her karede rastgele belirle

  // Fare konumuna göre hangi bölgede olduğumuzu belirle ve şekli çiz
  if (mouseX > 666) {
    // Sağ bölge: daire
    stroke(1);
    fill(#DD4CAA, trans);
    circle(500, 300, x);
    x = random(0, 100);
  } else if (mouseX > 333) {
    // Orta bölge: kare
    stroke(1);
    fill(#65FFAA, trans);
    y = random(0, 100);
    square(500, 300, y);
  } else {
    // Sol bölge: üçgen
    stroke(1);
    fill(#FFCF70, trans);
    z = random(320, 260);
    x = random(240, 320);
    triangle(500, x, 520, z, 480, z);
  }

  // Merkeze yeni parçacık ekle ve tüm parçacıkları güncelle
  particles.add(new PVector(500, 300));

  for (int i = particles.size() - 1; i >= 0; i--) {
    noStroke();
    PVector p = particles.get(i);
    circle(p.x, p.y, 10);

    // Bölgeye göre parçacığın hareketi
    if (mouseX > 666) {
      // Sağ bölgede parçacıklar sabit kalır
    } else if (mouseX > 333) {
      p.y++; // Orta bölgede aşağı düşer
    } else {
      p.y--; // Sol bölgede yukarı yükselir
    }

    // Parçacık sayısını 60 ile sınırla, eskiyi sil
    if (particles.size() > 60) {
      particles.remove(0);
    }
  }

  // Bölge ayırıcı çizgiler
  stroke(#181818);
  strokeWeight(random(1, 2));
  line(333, 0, 333, height);
  line(666, 0, 666, height);
}
