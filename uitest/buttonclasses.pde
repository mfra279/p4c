class Button{
  
 float buttonWidth, buttonHeight, posX, posY, borderWidth;
 String label;
 color textColor, currentColor, activeColor, inactiveColor;
 boolean active;
 
 Button(String _label, float _posX, float _posY, float _buttonWidth, float _buttonHeight, float _borderWidth, color _textColor, color _currentColor){
   label = _label;
   posX = _posX;
   posY = _posY;
   buttonWidth = _buttonWidth;
   buttonHeight = _buttonHeight;
   borderWidth = _borderWidth;
   textColor = _textColor;
   currentColor = _currentColor;
   activeColor = color(0, 255, 0);
   inactiveColor = color(0, 0, 255);
   active = false;
 }
 
 void renderButton(){
  if(active){
   currentColor = activeColor; 
  }
  else{
   currentColor = inactiveColor; 
  }
  fill(currentColor);
  strokeWeight(borderWidth);
  stroke(0);
  rect(posX, posY, buttonWidth, buttonHeight);
  push();
  fill(textColor);
  text(label, posX+5, (posY+endY())/2, endX(), endY());
  pop();
 }
 float startX(){
   return posX;
 }
 
 
 float endX(){
   return posX + buttonWidth;
 }
 
 
 float startY(){
   return posY;
   
 }
 
 
 float endY(){
   return posY + buttonHeight;
 }
}


class VibButton{
 float centerX, centerY, diameter, radius, borderWidth;
 String label;
 color textColor, currentColor;
 
  
 VibButton(String _label, float _centerX, float _centerY, float _btnDiameter, float _borderWidth, color _textColor, color _currentColor){
   label = _label;
   centerX = _centerX;
   centerY = _centerY;
   diameter = _btnDiameter;
   radius = diameter/2;
   borderWidth = _borderWidth;
   textColor = _textColor;
   currentColor = _currentColor;
 }
 
 
 void renderBtn(){
   strokeWeight(borderWidth);
   stroke(0);
   fill(currentColor);
   ellipseMode(CENTER);
   ellipse(centerX, centerY, radius, radius);
 }
 
 
 void vibrate(){
   strokeWeight(borderWidth);
     stroke(random(255));
   strokeWeight(random(1,5));
   ellipseMode(CENTER);
   ellipse(centerX, centerY, radius, radius);
   noFill();
   stroke(128 );
   ellipse(centerX, centerY, radius + random(20), radius + random(20));
   ellipse(centerX, centerY, radius + random(20), radius + random(20));
 }
}
