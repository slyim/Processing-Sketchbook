float xspd, yspd;
float ballStroke, ballEye; 
int fillC;
float x = width/2;
float y = height/2;

void setup(){
    background(0);
    size(800, 640);
    noStroke();
    frameRate(60);
    xspd = 6;
    yspd = 4;
}


void draw(){
    ballStroke = random(75, 100);
    ballEye = random(25,100);
    fill(random(0, 255), random(0, 255), random(0, 255), 100);


    x += xspd;
    y += yspd;

    // Walls
    if (x >= width - 25 || x <= 25){
        xspd *= -1;     
    }
    if (y >= height - 25 || y <= 25){
        yspd *= -1;
    }


    // Mouse    
    if (dist(x, y, mouseX, mouseY) < ballStroke / 2) {
        xspd *= -1;
        yspd *= -1;
        x += xspd * 2; 
        y += yspd * 2;
    }

    x = constrain(x, 25, width - 25);
    y = constrain(y, 25, height - 25);

    circle(x, y, ballStroke);
    circle(x, y, ballEye);
    fill(255, 30);
}


/*
  When ball hits the mouse it doesn't go into the opposite direction of the point,
  instead it goes to the opposite direction of itself
  */

void mousePressed(){
    background(random(0,255), random(0,255), random(0,255));
    xspd = random(-12, 12);
    yspd = random(-8, 8);
}

// Lila Aydin 2308A025