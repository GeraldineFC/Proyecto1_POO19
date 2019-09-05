int pantalla = 1;//indica la pantalla en vista

//Carga clases cartas

Bufandag bufandag;
Bufandas bufandas;
Anden934 anden934;
Cicatriz cicatriz;
Corbata corbata;
Jaula jaula;
Letrero letrero;
Lentes lentes;
Olla olla;
Quiditch quiditch;
Sobre sobre;
Sombrero sombrero;
Reliquias reliquias;
Varita varita;
Vacia vacia;

//Declaración Pantallas
Pantallainicio pantallainicio;
Pantallainstrucciones pantallainstrucciones;
Pantallajuego pantallajuego;
Pantallaresultado pantallaresultado;

Carta [] carta1 = new Carta[14];
Carta [] carta2 = new Carta[14];
Tablero [] tableros = new Tablero[28];
Carta [] cartas = new Carta[28];

int turno;
int turnop;
int vistas;

int npares=0;

int nparesj1;
int c1=-1;
int ci1;
int c2=-2;
int ci2;

int nparesj2=0;
int cc1=-1;
int cci1;
int cc2=-2;
int cci2;

void setup()
{
  size(1200, 800);
  background(255);
  pantallainicio = new Pantallainicio(color(195, 168, 102));
  pantallainstrucciones = new Pantallainstrucciones(color(195, 168, 102));
  pantallajuego = new Pantallajuego(color(195, 168, 102));
  pantallaresultado = new Pantallaresultado(color(195, 168, 102));

  bufandag = new Bufandag();
  bufandas = new Bufandas();
  anden934 = new Anden934();
  cicatriz = new Cicatriz();
  corbata = new Corbata();
  jaula = new Jaula();
  letrero = new Letrero();
  lentes = new Lentes();
  olla = new Olla();
  quiditch = new Quiditch();
  sobre = new Sobre();
  sombrero = new Sombrero();
  reliquias = new Reliquias();
  varita = new Varita();
  vacia = new Vacia();

  turnop=1;

  for (int i=0; i<28; i++)
  {
    tableros[i] = new Tablero(i);
  }

  for (int i=0; i<28; i++)
  {
    int npos = floor(random(28));
    int nposi = npos;
    boolean asignar = false;

    while (asignar == false)
    {

      if (tableros[npos].usado==false)
      {

        nposi = npos;
        tableros[nposi].usado=true;
        println("+"+i);
        asignar=true;
      } else {
        npos = floor(random(28));
        asignar=false;
      }
    }

    if (i<14)
    {
      cartas[i] = new Carta(tableros[nposi].px, tableros[nposi].py, 150, 200, i, i);
      println(cartas[i].nc, tableros[nposi].px, tableros[nposi].py);
    } else {
      cartas[i] = new Carta(tableros[nposi].px, tableros[nposi].py, 150, 200, i-14, i);
      println(cartas[i-14].nc, tableros[nposi].px, tableros[nposi].py);
    }
  }

  for (int i =0; i<14; i++)
  { 
    carta1[i] = new Carta(i*150, 0, 150, 200, i, i);
    carta2[i] = new Carta(i*150, 200, 150, 200, i, i);
  }
}

void draw()
{
  background(255);
  if (pantalla==1)
  {
    pushMatrix();
    scale(1.5);
    pantallainicio.display(255);
    popMatrix();
  }
  if (pantalla==2)
  {
    pantallainstrucciones.display(255);
  }

  if (pantalla==3)
  {
    pantallajuego.display(255);
  }

  if (pantalla==4)
  {
    pantallaresultado.display(255);
    pantallaresultado.reiniciar();
  }
}


//Pasarentrepantallas

void mouseClicked()
{
  if (pantalla==1 || pantalla ==2 )
  {
    pantalla++;
  }
}

//Clases de Pantallas

class Pantallainicio
{
  color fondo;
  float ycam;
  Pantallainicio(color fondo_)
  {
    fondo=fondo_;
  }

  void display(color texto)
  {
    noStroke();
    ycam+=0.05;
    fill(fondo);
    rect(0, 0, width, height);//colorfondopantalla
    /*fill(texto);//colortexto
     textSize(48);//tamañotexto
     textAlign(CENTER);
     text("HP Memoria",width/2,height/2);*/
    textSize(50);
    fill(0, 0, 0);

    text("HARRYRAMA", 350, 200 + (sin(ycam)*50));

    textSize(30);
    if (second()%3<1)
    {
      fill(0, 0, 0, 0);
    } else { 
      fill(0, 0, 0);
    }

    text("Click para iniciar", 350, 400);

    strokeWeight(1.5);
    fill(118, 30, 4);
    ellipse(150, 200, 200, 200);
    fill(213, 184, 132);
    textSize(100);
    text("9", 80, 240); 
    textSize(60);
    text("4", 160, 250); 
    textSize(60);
    text("3", 160, 190);
    fill(118, 30, 4);
    textSize(30);
    text("PLATAFORM", 65, 90);
    fill(213, 184, 132);
    line(160, 200, 200, 200);
  }
}

class Pantallainstrucciones
{
  color fondo;
  Pantallainstrucciones(color fondo_)
  {
    fondo = fondo_;
  }

  void display(color texto)
  {
    background(fondo);
    noStroke();
    fill(fondo);
    rect(0, 0, width, height);//colorfondopantalla
    stroke(texto);
    strokeWeight(5);
    fill(texto/2);
    rect(0, 100, width, height);
    fill (texto);
    textSize(48);
    textAlign(CENTER);
    text("INSTRUCCIONES", width/2, 50);
    text("Se enfrentaran dos jugadores para encontrar ell mayor número de objetos, por turnos darán clic a las cartas para descubrirlas, si son pares acumulan un punto, gana el jugador que al terminar de descubrir los 14 pares obtenga un mayor puntaje. Da clic para continuar.",50,100,1100,600);
    
  }
}

class Pantallajuego
{
  color fondo;
  Pantallajuego(color fondo_)
  {
    fondo = fondo_;
  }

  void display(color resaltar)
  {
    turno = vistas%3;
    if (npares>=14)
    {
      pantalla=4;
      npares=0;
    }
    stroke(resaltar);
    fill(fondo);
    rect(0, 0, 900, height);
    rect(900, 0, 300, height);
    for (int i =0; i<14; i++)
    {
      //carta1[i].display();

      //carta2[i].display();
    }

    for (int i=0; i<28; i++)
    {
      //tableros[i].display();
      stroke(0);
      cartas[i].display();
      if (turno==0 || turno==1)
      {
        cartas[i].voltear();
      }

      if (turno==2)
      {
        pushStyle();
        fill(0);
        rectMode(CENTER);
        rect(width/2, height/2, width/2, height/4);
        popStyle();
        fill(255);
        textAlign(CENTER);
        textSize(36);

        if (turnop==1)
        {
          if (c1==c2)
          {

            text("¡Correcto! + 1 punto", width/2, height/2);
          }
          if (c1!=c2)
          {
            text("¡Incorrecto! intenta otra vez", width/2, height/2);
          }

          if (mousePressed)
          {
            if (c1!=c2)
            {
              cartas[ci1].voltea=false;
              cartas[ci2].voltea=false;
              c1=-1;
              c2=-2;
              vistas++;
              turnop=2;
            }
            if (c1==c2)
            {
              npares++;
              nparesj1++;
              cartas[ci1].voltea=true;
              cartas[ci2].voltea=true;
              c1=-1;
              c2=-2;
              vistas++;
              turnop=1;
            }
            mousePressed=false;
          }
        }

        if (turnop==2)
        {
          if (cc1==cc2)
          {

            text("¡Correcto! + 1 punto", width/2, height/2);
          }
          if (cc1!=cc2)
          {
            text("¡Incorrecto! intenta otra vez", width/2, height/2);
          }

          if (mousePressed)
          {
            if (cc1!=cc2)
            {
              cartas[cci1].voltea=false;
              cartas[cci2].voltea=false;
              cc1=-1;
              cc2=-2;
              vistas++;
              turnop=1;
            }
            if (cc1==cc2)
            {
              npares++;
              nparesj2++;
              cartas[cci1].voltea=true;
              cartas[cci2].voltea=true;
              cc1=-1;
              cc2=-2;
              vistas++;
              turnop=2;
            }
            mousePressed=false;
          }
        }
      }
    }
    textAlign(CENTER);
    textSize(20);
    text("Carta Número", 1125, 50);
    if (turno<2)
    {
      text(turno+1, 1125, 100);
    }

    text("Pares", 1125, 200);
    text(npares, 1125, 250);

    text("Turno Jugador:", 1125, 350);
    text(turnop, 1125, 400);

    text("Puntos J1: "+ nparesj1, 1125, 500);
    text("Puntos J2: "+ nparesj2, 1125, 550);

    //text("Ncarta1: "+c1, 1125, 650);
    //text("Ncarta2: "+c2, 1125, 700);
  }
}

class Pantallaresultado
{
  color fondo;
  Pantallaresultado(color fondo_)
  {
    fondo = fondo_;
  }

  void display(color texto)
  {
    noStroke();
    fill(fondo);
    rect(0, 0, width, height);
    textSize(36);
    textAlign(CENTER);
    fill(texto);
    text("¡Ha ganado el jugador:!", width/2, 200);
    if (nparesj1>nparesj2)
    {
      text("1, ¡Felicidades!", width/2, 400);
    }
    if (nparesj1<nparesj2)
    {
      text("2, ¡Felicidades!", width/2, 400);
    }
    if (nparesj1==nparesj2)
    {
      text("¡Empate :/!", width/2, 400);
    }

    text("Presione cero para reiniciar", width/2, 600);
  }

  void reiniciar()
  {
    if (keyPressed && key == '0')
    {

      npares=0;
      turno=0;
      turnop=1;
      nparesj1=0;
      nparesj2=0;
      c1=-1;
      c2=-2;
      cc1=-1;
      cc2=-2;

      for (int i=0; i<28; i++)
      {
        tableros[i] = new Tablero(i);
      }

      for (int i=0; i<28; i++)
      {
        int npos = floor(random(28));
        int nposi = npos;
        boolean asignar = false;

        while (asignar == false)
        {

          if (tableros[npos].usado==false)
          {

            nposi = npos;
            tableros[nposi].usado=true;
            println("+"+i);
            asignar=true;
          } else {
            npos = floor(random(28));
            asignar=false;
          }
        }

        if (i<14)
        {
          cartas[i] = new Carta(tableros[nposi].px, tableros[nposi].py, 150, 200, i, i);
          println(cartas[i].nc, tableros[nposi].px, tableros[nposi].py);
        } else {
          cartas[i] = new Carta(tableros[nposi].px, tableros[nposi].py, 150, 200, i-14, i);
          println(cartas[i-14].nc, tableros[nposi].px, tableros[nposi].py);
        }
      }
      pantalla=1;
      keyPressed=false;
    }
  }
}

//Clases cartas

class Bufandag
{
  Bufandag()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(118, 30, 40);
    rect(80, 100, 70, 40);
    fill(237, 186, 61);
    rect(80, 100, 20, 40);
    rect(120, 100, 20, 40);
    rect(140, 100, 40, 150);
    fill(118, 30, 40);
    rect(140, 100, 40, 23);
    rect(140, 145, 40, 23);
    rect(140, 190, 40, 23);
    rect(140, 235, 40, 21);
  }
}

class Bufandas
{
  Bufandas()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(47, 105, 75);
    rect(80, 100, 70, 40);
    fill(189, 189, 189);
    rect(80, 100, 20, 40);
    rect(120, 100, 20, 40);
    rect(140, 100, 40, 150);
    fill(47, 105, 75);
    rect(140, 100, 40, 23);
    rect(140, 145, 40, 23);
    rect(140, 190, 40, 23);
    rect(140, 235, 40, 21);
  }
}

class Anden934
{
  Anden934()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    strokeWeight(1.5);
    fill(118, 30, 4);
    ellipse(150, 200, 200, 200);
    fill(213, 184, 132);
    textSize(100);
    text("9", 80, 240); 
    textSize(60);
    text("4", 160, 250); 
    textSize(60);
    text("3", 160, 190);
    fill(118, 30, 4);
    textSize(30);
    text("PLATAFORM", 65, 90);
    fill(213, 184, 132);
    line(160, 200, 200, 200);
  }
}

class Cicatriz 
{
  Cicatriz()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(0, 0, 0);
    beginShape();
    vertex(150, 50);
    vertex(140, 170);
    vertex(180, 170);
    vertex(135, 330);
    vertex(140, 195);
    vertex(100, 195);
    vertex(150, 50);
    endShape();
  }
}

class Corbata 
{
  Corbata ()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(237, 186, 61);
    beginShape();
    vertex(130, 60);
    vertex(170, 60);
    vertex(185, 85);
    vertex(170, 110);
    vertex(130, 110);
    vertex(115, 85);
    endShape(CLOSE);
    fill(118, 30, 40);
    beginShape();
    vertex(130, 110);
    vertex(170, 110);
    vertex(185, 270);
    vertex(150, 330);
    vertex(115, 270);
    endShape(CLOSE);
  }
}

class Jaula
{
  Jaula()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    strokeWeight(2);
    fill(213, 184, 132);
    ellipse(150, 150, 90, 90);
    rect(105, 150, 90, 90);
    ellipse(150, 100, 10, 10);
    line(150, 105, 125, 150);
    line(125, 150, 125, 240);
    line(150, 105, 150, 240);
    line(150, 105, 175, 150);
    line(175, 150, 175, 240);
  }
}

class Letrero
{
  Letrero()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(0, 0, 0);
    rect(140, 80, 15, 250);
    rect(100, 100, 80, 20);
    triangle(180, 120, 180, 100, 200, 110);
    rect(90, 140, 100, 22);
    triangle(70, 150, 90, 140, 90, 162);
    rect(80, 190, 100, 20);
    triangle(180, 210, 180, 190, 200, 200);
    rect(90, 250, 110, 22);
    triangle(50, 260, 90, 272, 90, 250);
    textSize(15);
    fill(255);
    text("Hogwarts", 110, 115);
    textSize(17);
    fill(255);
    text("Gringotts", 95, 157);
    textSize(15);
    fill(255);
    text("Hagrid's Hut", 90, 205);
    textSize(17);
    fill(255);
    text("Azkaban", 100, 267);
  }
}

class Lentes
{
  Lentes ()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(241, 232, 215);
    strokeWeight(2);
    line(100, 180, 200, 180);
    strokeWeight(2);
    line(100, 200, 50, 130);
    line(200, 200, 250, 130);
    strokeWeight(1);
    ellipse (100, 180, 60, 60);
    fill(241, 232, 215);
    ellipse (200, 180, 60, 60);
  }
}

class Olla
{
  Olla()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(0, 0, 0);
    ellipse(150, 200, 100, 70);
    strokeWeight(10);
    line(105, 165, 195, 165);
    line(120, 200, 110, 235);
    line(170, 200, 190, 235);
    strokeWeight(1);
    noFill();
    ellipse(130, 153, 10, 10);
    ellipse(150, 143, 15, 15);
    ellipse(150, 140, 5, 5);
    ellipse(160, 120, 20, 20);
    ellipse(157, 116, 5, 5);
  }
}

class Quiditch
{
  Quiditch()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    noFill();
    ellipse(150, 100, 50, 50);
    line(150, 125, 150, 300);
    ellipse(100, 150, 50, 50);
    line(100, 175, 100, 300);
    ellipse(200, 150, 50, 50);
    line(200, 175, 200, 300);
  }
}

class Sobre
{
  Sobre()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(241, 232, 215);
    rect(60, 130, 180, 115);
    line(60, 130, 150, 200);
    line(240, 130, 150, 200);
    fill(118, 30, 40);
    ellipse(150, 200, 40, 40);
    fill(213, 184, 132);
    textSize(25);
    text("H", 141, 210);
  }
}

class Sombrero
{
  Sombrero()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    stroke(1);
    fill(90, 68, 13);
    triangle(100, 210, 150, 90, 200, 210);
    ellipse(150, 210, 150, 50);
    noStroke();
    fill(78, 59, 11);
    ellipse(150, 210, 120, 30);
  }
}

class Reliquias
{
  Reliquias()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(241, 232, 215);
    strokeWeight(1.5);
    triangle(70, 250, 150, 130, 230, 250);
    ellipse(150, 208, 82, 82);
    line(150, 130, 150, 250);
  }
}

class Varita
{
  Varita()
  {
  }

  void display()
  {
    fill(213, 184, 132);
    rect(0, 0, 300, 400);
    fill(241, 232, 215);
    strokeWeight(1.5);
    fill(86, 60, 11);
    triangle(60, 280, 200, 80, 80, 290);
    ellipse(70, 290, 40, 30);
  }
}

class Vacia
{
  Vacia()
  {
  }

  void display()
  {
    stroke(255);
    fill(0);
    rect(0, 0, 300, 400);
    fill(255);
    ellipse(150, 200, 150, 200);
  }
}

class Carta
{
  int px;
  int py;
  int tx;
  int ty;
  int nc;
  int ntc;
  boolean voltea;
  boolean desc;

  Carta(int px_, int py_, int tx_, int ty_, int nc_, int ntc_)
  {
    px = px_;
    py = py_;
    tx = tx_;
    ty = ty_;
    nc = nc_;
    ntc = ntc_;
  }

  void display()
  {
    if (voltea)
    {
      pushMatrix();
      translate(px, py);
      scale(0.5);
      if (nc==0) {
        bufandag.display();
      } else if (nc==1) {
        bufandas.display();
      } else if (nc==2) {
        anden934.display();
      } else if (nc==3) {
        cicatriz.display();
      } else if (nc==4) {
        corbata.display();
      } else if (nc==5) {
        jaula.display();
      } else if (nc==6) {
        letrero.display();
      } else if (nc==7) {
        lentes.display();
      } else if (nc==8) {
        olla.display();
      } else if (nc==9) {
        quiditch.display();
      } else if (nc==10) {
        sobre.display();
      } else if (nc==11) {
        sombrero.display();
      } else if (nc==12) {
        reliquias.display();
      } else if (nc==13) {
        varita.display();
      } else {
        vacia.display();
      }
      popMatrix();
    } else {
      pushMatrix();
      translate(px, py);
      scale(0.5);
      vacia.display();
      popMatrix();
    }
  }

  void voltear()
  { 
    if (!voltea)
    {
      if (mouseX>px&&mouseX<px+tx&&mouseY>py&&mouseY<py+ty)
      {
        fill(213, 184, 132);
        ellipse((px+px+tx)/2, (py+py+ty)/2, 50, 50);
      }
      if (mousePressed&&(mouseX>px&&mouseX<px+tx&&mouseY>py&&mouseY<py+ty))
      {
        voltea=true;

        if (turnop==1)
        {
          if (turno==0)
          {
            c1=nc;
            ci1=ntc;
          }
          if (turno==1)
          {
            c2=nc;
            ci2=ntc;
          }
        }

        if (turnop==2)
        {
          if (turno==0)
          {
            cc1=nc;
            cci1=ntc;
          }
          if (turno==1)
          {
            cc2=nc;
            cci2=ntc;
          }
        }


        vistas++;
        mousePressed=false;
      }
    }
  }
}

//Tablero

class Tablero 
{
  int np;
  int px;
  int py;
  boolean usado;
  Tablero(int np_)
  {
    np = np_;
    usado = false;
    switch(np)
    {
    case 0:
      px=0;
      py=0;
      break;
    case 1:
      px=150;
      py=0;
      break;
    case 2:
      px=300;
      py=0;
      break;
    case 3:
      px=450;
      py=0;
      break;
    case 4:
      px=600;
      py=0;
      break;
    case 5:
      px=750;
      py=0;
      break;
    case 6:
      px=900;
      py=0;
      break;
    case 7:
      px=0;
      py=200;
      break;
    case 8:
      px=150;
      py=200;
      break;
    case 9:
      px=300;
      py=200;
      break;
    case 10:
      px=450;
      py=200;
      break;
    case 11:
      px=600;
      py=200;
      break;
    case 12:
      px=750;
      py=200;
      break;
    case 13:
      px=900;
      py=200;
      break;
    case 14:
      px=0;
      py=400;
      break;
    case 15:
      px=150;
      py=400;
      break;
    case 16:
      px=300;
      py=400;
      break;
    case 17:
      px=450;
      py=400;
      break;
    case 18:
      px=600;
      py=400;
      break;
    case 19:
      px=750;
      py=400;
      break;
    case 20:
      px=900;
      py=400;
      break;
    case 21:
      px=0;
      py=600;
      break;
    case 22:
      px=150;
      py=600;
      break;
    case 23:
      px=300;
      py=600;
      break;
    case 24:
      px=450;
      py=600;
      break;
    case 25:
      px=600;
      py=600;
      break;
    case 26:
      px=750;
      py=600;
      break;
    case 27:
      px=900;
      py=600;
      break;
    }
  }

  void display()
  {
    stroke(255);
    fill(0);
    rect(px, py, 150, 200);
  }
}
