int num,xSize, ySize;
int scale = 1;
Dot[] dot;
int circleX,circleY;
int Velx, Vely;
float dotSizeX,dotSizeY;
class Dot{
 float x, y;
 boolean status;
  Dot(float x, float y){
   this.x = x;
   this.y = y;
   dotSizeX=3.5;
   dotSizeY = 4.5;
   status = false;
 }
 
 void drawDot(){
   if (status){
    fill(255); 
   } else {
   fill(0,0,255);
   }
   strokeWeight(0.1*scale);
   rect(x,y, dotSizeX*scale, dotSizeY* scale);
   strokeWeight(0);
 }
}

void move(){
  if (circleX - 5 + Velx > 115) Velx *= -1;
  if (circleX - 5 + Velx < 1 ) Velx *= -1;
  if (circleY + 5 + Vely > 64) Vely *= -1;
  if (circleY - 5 + Vely < 1)  Vely *= -1;
  circleX+=Velx;
  circleY+=Vely;
}

void setup(){
  xSize = scale * 509;
  ySize = scale * 324;
 //size(2036,1296);//1018,648 //ratio 4992x3136
 size(509,324);
 //fullScreen();
 background(0,0,255);
 strokeWeight(0);
 fill(255);
 num = 0;
 circleX = 30;
 circleY = 30;
 Velx = 3;
 Vely = 5;
 dot = new Dot[8192];
  for(int i = 0; i < 64; i++){
    for (int j = 0; j < 128; j++){
    dot[num] = new Dot((j*(dotSizeX+0.4)+5)*scale,(i*(dotSizeY+0.4)+5)*scale);
    num ++;
    }
  }
  //dot[128*(y-1)+(x-1)].status = true;  
}

void draw(){
  //myLine(0, 20, 127, 0,true);
  //myLine(0, 0, 127, 63,true);
  myEllipse(80,30,20,15,true);
  rasterCircle(circleX,circleY,5,false);
  //move();
  rasterCircle(circleX,circleY,5,true);
  for(int i = 0; i < 8192; i++){
    dot[i].drawDot();
  }
  myLine(10, 0, 20, 0,true);
  myLine(10, 5, 20, 5,true);
  if (mouseX >= 30 && mouseX <= width && 
      mouseY >= 30 && mouseY <= height) {
      move();
  } else {
  }
}

void myLine(int x0, int y0, int x1, int y1, boolean value)
{
  int dx =  abs(x1-x0), sx = (x0<x1) ? 1 : -1;
  int dy = -abs(y1-y0), sy = (y0<y1) ? 1 : -1;
  int err = dx+dy, e2; /* error value e_xy */

  while (true) {
    dot[128*(y0)+(x0)].status = value;
    if (x0==x1 && y0==y1) break;
    e2 = 2*err;
    if (e2 > dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
    if (e2 < dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
  }
}

void setPixel(int x, int y, boolean value){
  if(128 * y + x < 8192)dot[128 * y + x].status = value; 
}

void rasterCircle(int x0, int y0, int radius, boolean value)
  {
    int f = 1 - radius;
    int ddF_x = 0;
    int ddF_y = -2 * radius;
    int x = 0;
    int y = radius;

    setPixel(x0, y0 + radius, value);
    setPixel(x0, y0 - radius, value);
    setPixel(x0 + radius, y0, value);
    setPixel(x0 - radius, y0, value);

    while(x < y)
    {
      if(f >= 0)
      {
        y--;
        ddF_y += 2;
        f += ddF_y;
      }
      x++;
      ddF_x += 2;
      f += ddF_x + 1;

      setPixel(x0 + x, y0 + y, value);
      setPixel(x0 - x, y0 + y, value);
      setPixel(x0 + x, y0 - y, value);
      setPixel(x0 - x, y0 - y, value);
      setPixel(x0 + y, y0 + x, value);
      setPixel(x0 - y, y0 + x, value);
      setPixel(x0 + y, y0 - x, value);
      setPixel(x0 - y, y0 - x, value);
    }
  }
  
void myEllipse(int xm, int ym, int a, int b, boolean value){
   int dx = 0, dy = b; /* im I. Quadranten von links oben nach rechts unten */
   long a2 = a*a, b2 = b*b;
   long err = b2-(2*b-1)*a2, e2; /* Fehler im 1. Schritt */

   do {
       setPixel(xm+dx, ym+dy, value); /* I. Quadrant */
       setPixel(xm-dx, ym+dy, value); /* II. Quadrant */
       setPixel(xm-dx, ym-dy, value); /* III. Quadrant */
       setPixel(xm+dx, ym-dy, value); /* IV. Quadrant */

       e2 = 2*err;
       if (e2 <  (2*dx+1)*b2) { dx++; err += (2*dx+1)*b2; }
       if (e2 > -(2*dy-1)*a2) { dy--; err -= (2*dy-1)*a2; }
   } while (dy >= 0);

   while (dx++ < a) { /* fehlerhafter Abbruch bei flachen Ellipsen (b=1) */
       setPixel(xm+dx, ym, value); /* -> Spitze der Ellipse vollenden */
       setPixel(xm-dx, ym, value);
   }
}
