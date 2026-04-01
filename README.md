# 🌌 Processing Taslak Defteri (Processing Sketchbook)

**Processing (Java)** ile oluşturulmuş yüksek performanslı üretken sistemler ve görsel deneyler koleksiyonu. Bu çalışma alanı, standart Processing IDE'sinin ötesine geçerek profesyonel bir **VS Code** geliştirme iş akışı için optimize edilmiştir.

## 📂 Proje Mimarisi

Depo, temiz bir geliştirme hattı sağlamak için proje kaynağına ve render moduna göre düzenlenmiştir:

- **`LilacSketchbook`**: Temel orijinal projeler ve tescilli üretken sistemler. Yaratıcı kodlama çalışmalarımın ana merkezidir.
- **`AI-Research`**: Karmaşık geometriyi, özyinelemeli (recursive) mantığı ve ajan tabanlı iş akışlarını keşfetmek için yapay zeka desteğiyle geliştirilen iş birlikçi deneyler.
- **`2D`**: İki boyutlu vektör matematiği, fizik tabanlı hareket ve biyolüminesans estetiği üzerine çalışmalar.
- **`3D`**: P3D işleme (rendering), özel koordinat sistemleri ve GLSL shader entegrasyonu keşifleri.

## 🛠️ Ortam ve İş Akışı

Bu depo, daha sağlam bir geliştirme deneyimi için özel olarak **Visual Studio Code** için yapılandırılmıştır:

- **Motor:** Processing 4.x (Java)
- **Eklenti:** VS Code üzerinden Processing Foundation tarafından yayınlanan **"Processing Language"** eklentisini kurmanız gerekmektedir.
- **İşleme:** `pixelDensity(2)` ile yüksek çözünürlüklü (High-DPI / Retina) ekranlar için optimize edilmiştir.
- **Kısayollar:** Eklenti kurulduktan sonra herhangi bir `.pde` dosyasını anında çalıştırmak için `Cmd + Shift + B` (macOS) veya `Ctrl + Shift + B` (Windows) kullanabilirsiniz.

## ✨ Yaratıcı Yön

Çalışmalarım, **organik "büyülü" estetik** ile **katı teknik mantığın** kesişimine odaklanır.

- **Ana Temalar:** Özyinelemeli geometri, ruhani parıltılar ve sıvı benzeri hareketler.
- **Teknik Odak:** `LilacSketchbook` projeleri dahilinde özel raster işleme sistemleri ve modüler sınıflar geliştirmek.

---

### 🚀 Nasıl Çalıştırılır?

Bu çizimleri (sketches) çalıştırabilmek için sisteminizde **Processing 4**'ün yüklü olduğundan emin olun.

#### Yöntem 1: Visual Studio Code (Önerilen)

1. VS Code içerisinde eklentiler (Extensions) sekmesine gidin ve **Processing Language** eklentisini kurun.
2. Bu ana klasörü VS Code'da açın.
3. Herhangi bir `.pde` dosyasını açın ve sağ üstteki **Run** simgesine tıklayın veya derleme kısayolunu kullanın.

#### Yöntem 2: Processing IDE

1. **Processing IDE**'yi açın.
2. `File > Open` yolunu izleyerek çalıştırmak istediğiniz projenin klasörüne gidin ve `.pde` dosyasını seçin.

> **⚠️ Dosya Yapısı Uyarısı:**
> Processing kuralları gereği, ana `.pde` dosyasının adı ile içinde bulunduğu klasörün adı **birebir aynı** olmalıdır (Örn: `LilacSketchbook/ParlayanKanatlar/ParlayanKanatlar.pde`). Eğer dosyayı yeniden adlandırırsanız, klasörü de değiştirmeyi unutmayın, aksi takdirde proje çalışmaz.

---

### 🏳️‍⚧️ Trans hakları insan haklarıdır.

**Onur ve sevgiyle yapıldı.**
