// Statik mod: setup/draw olmadan doğrudan çizim yapılır.
// colorMode ile renkler 0-100 aralığında tanımlanmış.

size(640, 360);
colorMode(RGB, 100); // RGB değerleri 0-255 yerine 0-100 aralığında
rectMode(CENTER);    // Şekiller merkeze göre çizilir

background(100, 0, 50); // Koyu kırmızımsı arka plan

// Daire: kalın kontur, yarı saydam dolgu
strokeWeight(8);
stroke(0, 100, 150);
fill(99, 50, 200, 50);
circle(140, 180, 100);

// Kare: daha ince kontur
strokeWeight(4);
stroke(100, 150, 200);
fill(255, 255, 0, 50);
square(100, 180, 100);
