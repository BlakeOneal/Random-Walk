import controlP5.*;

ControlP5 cp5;
Button start;
boolean started = false;
Toggle colorToggle;
Toggle gradualToggle;
Slider iteration;
Slider stepCounter;
boolean Color;
boolean gradual;


void setup() {
  size(800, 800);
  colorMode(RGB, 1.0);
  background(0.43, 0.56, 0.95);
  cp5 = new ControlP5(this);
  start = cp5.addButton("Start");
  start.setWidth(75);
  start.setHeight(25);
  colorToggle = cp5.addToggle("Color");
  colorToggle.setHeight(25);
  colorToggle.setWidth(25);
  gradualToggle = cp5.addToggle("gradual");
  gradualToggle.setHeight(25);
  gradualToggle.setWidth(25);
  gradualToggle.setPosition(120, 30);
  iteration = cp5.addSlider("iterations", 1000, 500000);
  iteration.setDefaultValue(1000);
  iteration.setHeight(25/2);
  iteration.setPosition(150, 30);
  iteration.setWidth(200);
  stepCounter = cp5.addSlider("stepCount", 1, 1000).setLabel("Step Count");
  stepCounter.setDefaultValue(1);
  stepCounter.setHeight(25/2);
  stepCounter.setWidth(200);
  stepCounter.setPosition(150, 43);
}
int iterations = 1000;
int stepCount = 1;
float xPos = width/2;
float yPos = height/2;
int randomNum;
int tempIterations = iterations;
int numDone = 0;
boolean inCurrentRun = false;
float currColor = 0;


void draw() {
  colorMode(RGB, 1.0);
  int numLoops = tempIterations / stepCount;
  if (started) {
    if (Color) {
      currColor = map(numDone, 0, iterations, 0, 1);
    }
    if (gradual) {
      for (int i = 0; i < stepCount; i++) {
        randomNumGen();
        stroke(currColor);
        point(xPos, yPos);
        numDone++;
      }
      tempIterations = tempIterations - stepCount;
      numLoops--;
      if (numLoops < 0) {
        started = false;
      }
    }
    if (!gradual) {
      for (int i = 0; i < iterations; i++) {
        randomNumGen();
        numDone++;
        if (Color) {
          currColor = map(numDone, 0, iterations, 0, 1);
        }
        stroke(currColor);
        point(xPos, yPos);
      }
      started = false;
    }
  }
}

void Start() {
  background(0.43, 0.56, 0.95);
  started = true;
  numDone = 0;
  xPos = width/2;
  yPos = height/2;
  tempIterations = iterations;
  currColor = 0;
}

void randomNumGen() {
  randomNum = int(random(0, 4));
  switch(randomNum) {
  case 0:
    yPos++;
    break;
  case 1:
    yPos--;
    break;
  case 2:
    xPos--;
    break;
  case 3:
    xPos++;
    break;
  }
  if (xPos > width) {
    xPos = width;
    randomNumGen();
  } else if (xPos < 0) {
    xPos = 0;
    randomNumGen();
  }
  if (yPos > height) {
    yPos = height;
    randomNumGen();
  } else if (yPos < 0) {
    yPos = 0;
    randomNumGen();
  }
}
