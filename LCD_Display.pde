int num,xSize, ySize;
int scale = 2;
Dot[] dot;
int circleX,circleY;
int Velx, Vely;

void move(){
  circleX+=Velx;
  circleY+=Vely;
}

void setup(){
  xSize = scale * 509;
  ySize = scale * 324;
 //size(2036,1296);//1018,648 //ratio 4992x3136
 size(1018,648);
 //fullScreen();
 background(0,0,255);
 strokeWeight(0);
 fill(255);
 num = 0;
 circleX = 10;
 circleY = 10;
 Velx = 2;
 Vely = 2;
 dot = new Dot[8192];
  for(int i = 0; i < 64; i++){
    for (int j = 0; j < 128; j++){
    dot[num] = new Dot((j*3.9+5)*scale,(i*4.9+5)*scale);
    num ++;
    }
  }
  //dot[128*(y-1)+(x-1)].status = true;  
}

void draw(){
  //myLine(0, 20, 127, 0);
  //myLine(0, 0, 127, 63);
  myEllipse(80,30,20,15);
  //move();
  rasterCircle(30,30,15);
  for(int i = 0; i < 8192; i++){
    dot[i].drawDot();
  }
}

void myLine(int x0, int y0, int x1, int y1)
{
  int dx =  abs(x1-x0), sx = (x0<x1) ? 1 : -1;
  int dy = -abs(y1-y0), sy = (y0<y1) ? 1 : -1;
  int err = dx+dy, e2; /* error value e_xy */

  while (true) {
    dot[128*(y0)+(x0)].status = true;
    if (x0==x1 && y0==y1) break;
    e2 = 2*err;
    if (e2 > dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
    if (e2 < dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
  }
}

void setPixel(int x, int y){
  dot[128 * y + x].status = true; 
}

void rasterCircle(int x0, int y0, int radius)
  {
    int f = 1 - radius;
    int ddF_x = 0;
    int ddF_y = -2 * radius;
    int x = 0;
    int y = radius;

    setPixel(x0, y0 + radius);
    setPixel(x0, y0 - radius);
    setPixel(x0 + radius, y0);
    setPixel(x0 - radius, y0);

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

      setPixel(x0 + x, y0 + y);
      setPixel(x0 - x, y0 + y);
      setPixel(x0 + x, y0 - y);
      setPixel(x0 - x, y0 - y);
      setPixel(x0 + y, y0 + x);
      setPixel(x0 - y, y0 + x);
      setPixel(x0 + y, y0 - x);
      setPixel(x0 - y, y0 - x);
    }
  }
  
void myEllipse(int xm, int ym, int a, int b){
   int dx = 0, dy = b; /* im I. Quadranten von links oben nach rechts unten */
   long a2 = a*a, b2 = b*b;
   long err = b2-(2*b-1)*a2, e2; /* Fehler im 1. Schritt */

   do {
       setPixel(xm+dx, ym+dy); /* I. Quadrant */
       setPixel(xm-dx, ym+dy); /* II. Quadrant */
       setPixel(xm-dx, ym-dy); /* III. Quadrant */
       setPixel(xm+dx, ym-dy); /* IV. Quadrant */

       e2 = 2*err;
       if (e2 <  (2*dx+1)*b2) { dx++; err += (2*dx+1)*b2; }
       if (e2 > -(2*dy-1)*a2) { dy--; err -= (2*dy-1)*a2; }
   } while (dy >= 0);

   while (dx++ < a) { /* fehlerhafter Abbruch bei flachen Ellipsen (b=1) */
       setPixel(xm+dx, ym); /* -> Spitze der Ellipse vollenden */
       setPixel(xm-dx, ym);
   }
}
