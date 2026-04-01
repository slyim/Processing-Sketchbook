// 1. Import the core Processing library
import processing.core.PApplet;

// 2. Extend PApplet to inherit all the Processing commands
public class MainApp extends PApplet {

    // 3. size() MUST go in settings() when writing pure Java
    public void settings() {
        size(800, 600, P3D);
    }

    // Standard setup (notice it needs the 'public' access modifier now)
    public void setup() {
        // No size() here! Just initialization.
        background(15, 10, 30);
    }

    // Standard draw
    public void draw() {
        background(15, 10, 30);
        
        // Add some basic 3D lights
        lights();
        
        translate(width / 2, height / 2, 0);
        
        // 5. Notice the 'f' at the end of the decimals!
        rotateX(frameCount * 0.02f);
        rotateY(frameCount * 0.03f);
        
        fill(255, 150, 200);
        noStroke();
        box(150);
    }

    // 4. The JRE Entry Point
    public static void main(String[] args) {
        // The string here MUST perfectly match the name of your class
        PApplet.main("MainApp");
    }
}