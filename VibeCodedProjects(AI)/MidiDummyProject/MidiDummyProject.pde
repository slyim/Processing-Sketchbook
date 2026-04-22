import themidibus.*;
import processing.sound.*;

MidiBus myBus;
float magicRadius = 50;
float wobbleAmount = 0.5;
float noteHue = 270; // stored as HSB hue, written by MIDI thread, read in draw()

SinOsc chime;
Env envelope;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 255);
  background(0);

  chime = new SinOsc(this);
  envelope = new Env(this);

  MidiBus.list();

  try {
    myBus = new MidiBus(this, "Minilab3 MIDI", -1);

    myBus.addMidiListener(new SimpleMidiListener() {

      public void noteOn(int channel, int pitch, int velocity) {
        noteHue = map(pitch, 36, 96, 160, 280);
        magicRadius = map(velocity, 0, 127, 100, 400);

        float freq = 440.0 * pow(2.0, (pitch - 69.0) / 12.0);
        float amp  = map(velocity, 0, 127, 0.0, 0.5);
        chime.freq(freq);
        chime.amp(amp);
        chime.play();
        envelope.play(chime, 0.01, 0.05, 0.2, 0.8);
      }

      public void noteOff(int channel, int pitch, int velocity) {}

      public void controllerChange(int channel, int number, int value) {
        wobbleAmount = map(value, 0, 127, 0.5, 4.0);
      }
    });

    println("SUCCESS: Connected to Minilab3 MIDI!");

  } catch (Exception e) {
    println("PORT BLOCKED: Close Ableton or use loopMIDI.");
    myBus = null;
  }
}

void draw() {
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);

  if (myBus != null) {
    translate(width / 2, height / 2);
    noFill();
    stroke(noteHue, 80, 100, 200);
    strokeWeight(2);

    beginShape();
    for (float a = 0; a < TWO_PI; a += 0.1) {
      float xoff = map(cos(a), -1, 1, 0, wobbleAmount);
      float yoff = map(sin(a), -1, 1, 0, wobbleAmount);
      float r = magicRadius + map(noise(xoff, yoff, frameCount * 0.02), 0, 1, -50, 50);
      vertex(r * cos(a), r * sin(a));
    }
    endShape(CLOSE);

    if (magicRadius > 50) magicRadius *= 0.95;
  } else {
    fill(0, 80, 100);
    textAlign(CENTER, CENTER);
    textSize(16);
    text("CONNECTION BLOCKED BY DAW.\nClose Ableton or use loopMIDI.", width / 2, height / 2);
  }
}
