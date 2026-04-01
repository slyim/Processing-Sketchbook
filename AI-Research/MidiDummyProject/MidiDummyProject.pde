import themidibus.*;
import processing.sound.*; // Import the audio engine

MidiBus myBus;
float magicRadius = 50;
float wobbleAmount = 0.5;
color fairyDust;

// Our magical chime synthesizer
SinOsc chime;
Env envelope;

void setup() {
  size(800, 800);
  background(0);
  fairyDust = color(150, 100, 255); 
  
  // Initialize the audio engine
  chime = new SinOsc(this);
  envelope = new Env(this);
  
  MidiBus.list();
  Object dummyParent = new Object();
  
  try {
    myBus = new MidiBus(dummyParent, "Minilab3 MIDI", -1);
    
    myBus.addMidiListener(new SimpleMidiListener() {
      
      public void noteOn(int channel, int pitch, int velocity) {
        // --- VISUALS ---
        magicRadius = map(velocity, 0, 127, 100, 400);
        colorMode(HSB, 360, 100, 100);
        float hue = map(pitch, 36, 96, 160, 280); 
        fairyDust = color(hue, 80, 100);
        colorMode(RGB, 255, 255, 255);
        
        // --- AUDIO ---
        // Convert MIDI pitch to Frequency (Hz)
        float freq = 440.0 * pow(2.0, (pitch - 69.0) / 12.0);
        
        // Map MIDI velocity to audio volume (amplitude)
        float amp = map(velocity, 0, 127, 0.0, 0.5);
        
        chime.freq(freq);
        chime.amp(amp);
        chime.play();
        
        // Trigger the envelope to shape the sound
        // Parameters: (oscillator, attackTime, sustainTime, sustainLevel, releaseTime)
        envelope.play(chime, 0.01, 0.05, 0.2, 0.8); 
      }
      
      public void noteOff(int channel, int pitch, int velocity) {
        // No action needed here, the envelope handles the fade out automatically
      }
      
      public void controllerChange(int channel, int number, int value) {
        // Twist a knob to change the visual chaos
        wobbleAmount = map(value, 0, 127, 0.5, 4.0);
      }
    });
    
    println("SUCCESS: Connected safely to Minilab3 MIDI!");
    
  } catch (Exception e) {
    println("=========================================");
    println("PORT BLOCKED: Ableton is holding the Minilab hostage.");
    println("=========================================");
    myBus = null; 
  }
}

void draw() {
  fill(0, 20); 
  rect(0, 0, width, height);

  if (myBus != null) {
    translate(width / 2, height / 2);
    noFill();
    stroke(fairyDust, 200);
    strokeWeight(2);

    beginShape();
    for (float a = 0; a < TWO_PI; a += 0.1) {
      float xoff = map(cos(a), -1, 1, 0, wobbleAmount);
      float yoff = map(sin(a), -1, 1, 0, wobbleAmount);
      
      float r = magicRadius + map(noise(xoff, yoff, frameCount * 0.02), 0, 1, -50, 50);
      float x = r * cos(a);
      float y = r * sin(a);
      vertex(x, y);
    }
    endShape(CLOSE);

    if (magicRadius > 50) magicRadius *= 0.95;
  } 
  else {
    fill(255, 50, 50);
    textAlign(CENTER, CENTER);
    textSize(16);
    text("CONNECTION BLOCKED BY DAW.\nPlease close Ableton or use loopMIDI.", width/2, height/2);
  }
}
