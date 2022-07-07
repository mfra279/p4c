import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//  --- vars with hardcoded values
final color buttonTextColor = color(0);
final color buttonClickedColor = color(0, 255, 0);
final color buttonDefaultColor = color(0, 0, 255);
final color visButtonDefaultColor = color(0, 0, 0);
final color buttonBorder = color(random(255), random(255), random(255));
final float buttonBorderWidth = 2;
final float buttonMarginRight = 2; // # of pixels between one top/bottom button and the next
final float buttonMarginBottom = 2; // # of pixels between one left/right button and the next
final color backgroundMainMenu = color(255);
final color backgroundVisualiser = color(24);

// --- keeping track of application state
boolean isMainMenu = true;
boolean isLissajous = false;
boolean isEllipse = false;
boolean isRect = false;
// --- vars with values assigned during program use
float winDivX;
float winDivY;
float shapeWidth = 300;
float shapeHeight = 300;
ArrayList<Button> buttons = new ArrayList<Button>();
VibButton vibButtonOne;

Button btnTopOne;
Button btnTopTwo;
Button btnTopThree;

Button btnBottomOne;
Button btnBottomTwo;
Button btnBottomThree;
Button btnBottomFour;

Button btnLeftOne;
Button btnLeftTwo;
Button btnRightOne;
Button btnRightTwo;

Minim minim;
AudioPlayer player;
AudioInput input;
FFT fft;

ArrayList<String> audioFiles = new ArrayList<String>();
boolean btnOn = false;
int audioIndex = 0;
void setup() {
  size(800, 800, P2D);
  winDivX = width/10;
  winDivY = height/10;
  
  //  -- Buttons (label,  x-pos, y-pos, width, height, border width, text color, background color when not clicked)
  // Buttons for Main Menu UI
  vibButtonOne = new VibButton("", width/2 - 1, height/2 - 1, 400, 2, buttonTextColor, buttonDefaultColor);
  // Buttons for visualiser UI
  btnTopOne = new Button("Mic", winDivX*2 - 1, 0, winDivX*2, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnTopOne);
  btnTopTwo = new Button("File", winDivX*4 - 1, 0, winDivX*2, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnTopTwo);
  btnTopThree = new Button("Stop", winDivX*6 - 1, 0, winDivX*2, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnTopThree);
  btnBottomOne = new Button("Lissajous", winDivX*2 - 1, winDivY*9 - 1, winDivX*2, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnBottomOne);
  btnBottomTwo = new Button("Ellipse", winDivX*4 - 1, winDivY*9 - 1, winDivX*2, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnBottomTwo);
  btnBottomThree = new Button("Rectangle", winDivX*6 - 1, winDivY*9 - 1, winDivX*2, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnBottomThree);
  btnLeftOne = new Button("btnLeftOne", 0, winDivY*4 - 1, winDivX, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnLeftOne);
  btnLeftTwo = new Button("btnLeftTwo", 0, winDivY*5 - 1, winDivX, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnLeftTwo);
  btnRightOne = new Button("Zoom In", winDivX*9 - 1, winDivY*4 - 1, winDivX, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnRightOne);
  btnRightTwo = new Button("Zoom Out", winDivX*9 - 1, winDivY*5 - 1, winDivX, winDivY, 2, buttonTextColor, buttonDefaultColor);
  buttons.add(btnRightTwo);
  
  minim = new Minim(this);
  
  audioFiles.add("fg.wav");
  audioFiles.add("vr.wav");
  audioFiles.add("hh.wav");
  audioFiles.add("mw.wav");
  audioFiles.add("oi.wav");
  audioFiles.add("sgls.wav");
  audioFiles.add("st.wav");
}


void draw() {
  winDivX = width/10;
  winDivY = height/10;
  renderUI();
  renderVisualisation();
}


void renderUI() {
  if (isMainMenu) {
    background(backgroundMainMenu);
    strokeWeight(1);
    stroke(0);
    fill(100);
    vibButtonOne.renderBtn();
    if(dist(mouseX, mouseY, vibButtonOne.centerX, vibButtonOne.centerY) <= vibButtonOne.diameter/2){
       vibButtonOne.vibrate(); 
    }
  } else { // Render buttons for visualiser if not in main menu
    background(backgroundVisualiser);
    for (Button thisBtn : buttons) {
      thisBtn.renderButton();
    }
    push();
    fill(color(255));
    strokeWeight(2);
    stroke(8);
    rect(winDivX*2 - 1, winDivY*2 - 1, winDivX*6, winDivY*6);
    pop();
  }
}


void renderVisualisation() {
  if (isLissajous) {
  }

  if (isRect) {
  }

  if (isEllipse) {
  }
}

void mousePressed() {
  if (isMainMenu) {
    if (dist(mouseX, mouseY, vibButtonOne.centerX, vibButtonOne.centerY) <= vibButtonOne.diameter/2) {
      isMainMenu = false;
    }
  } else { // Not in main menu, so dealing with main UI buttons
    for (Button thisBtn : buttons) {
      if (mouseWithinBounds(thisBtn)) {
        thisBtn.active = true;
        buttonAction(thisBtn);
      } else {
        thisBtn.active = false;
      }
    }
  }
}


void buttonAction(Button clickedBtn) { // Functionality of each button when clicked
  switch(clickedBtn.label) {
  case "Mic":
    println("mic clicked");
    micMode();
    break;
  case "File":
    println("file clicked");
    fileMode();
    break;
  case "Stop":
    break;
  case "Lissajous":
    isEllipse = false;
    isRect = false;
    isLissajous = true;
    break;
  case "Ellipse":
    isRect = false;
    isLissajous = false;
    isEllipse = true;
    break;
  case "Rectangle":
    isLissajous = false;
    isEllipse = false;
    isRect = true;
    break;
  case "btnBottomFour":
    break;

  case "Zoom In":
    break;
  case "Zoom Out":
    break;

  case "btnLeftOne":
    break;
  case "btnLeftTwo":
    break;
  default:
  }
}


boolean mouseWithinBounds(Button btn) {
  return (mouseX <= btn.endX() && mouseX >= btn.startX() && mouseY <= btn.endY() && mouseY >= btn.startY());
}


void micMode() {
  if (player != null && player.isPlaying()) {
    player.pause();
  }
}


void fileMode() {
  if (audioIndex >= audioFiles.size()-1) {
    audioIndex = 0;
  } else {
    audioIndex++;
  }
  if (player != null && player.isPlaying()) {
    player.pause();
  }
  player = minim.loadFile(audioFiles.get(audioIndex));
  player.loop();
}
