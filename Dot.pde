class Dot{
 float x, y;
 boolean status;
  Dot(float x, float y){
   this.x = x;
   this.y = y;
   status = false;
 }
 
 void drawDot(){
   if (status){
    fill(255); 
   } else {
   fill(0,0,255);
   }
   strokeWeight(0.1*scale);
   rect(x,y, 3.5*scale, 4.5* scale);
   strokeWeight(0);
 }
  
}
