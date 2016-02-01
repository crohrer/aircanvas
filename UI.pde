class UI {
  PImage posepng = loadImage("pose.png");
  Farbbalken DerFarbbalken;
  PImage e0 = loadImage("zwischenebene.png");
  PImage e1 = loadImage("zeichnen.png");
  PImage e2 = loadImage("farbe.png");
  PImage e4 = loadImage("skalieren.png");
  PImage m0 = loadImage("modi_zwischenebene.png"); //NULL
  PImage m1 = loadImage("modi_zeichnen.png");
  PImage m2 = loadImage("modi_color.png");
  PImage m4 = loadImage("modi_skalieren.png");
  PImage m5 = loadImage("modi_save.png");
  float alphaWert;
  boolean spitzeErreicht = false;
  PImage altesFadeBild;


  
  UI(){
    DerFarbbalken = new Farbbalken();
  }
  
  
  void ebene(int ebene){
    zeiger(ebene);
    //Modi-Einblendungen:
    switch(ebene){
      case 1:
        fade(m1);
        break;   
      case 2:
        fade(m2);
        break;
      case 4:
        fade(m4);
        break;
      case 5:
        fade(m5);
        break;
      default:
        fade(m0);
        break;
    }
  }
  
  void zeiger(int ebene){
    PImage cursorbild;
   
    //Cursor-Punkt anzeigen
//    fill(0, 100, 100);
//    strokeWeight(0);
//    ellipse(handPos.x, -handPos.y, 10, 10);
    
    switch(ebene) {
      case 1: 
        cursorbild = e1;
        break;
      case 2: 
        cursorbild = e2; 
        break;
      case 4:
        cursorbild = e4;
        DasUI.zeigerLinks();
        break;
      case 3:
        cursorbild = e0; 
        break;
      default:
        cursorbild = e0; 
        break;
    }
    image(cursorbild, handPos.x-cursorbild.width/2, -handPos.y-cursorbild.height/2);
  }
  
  void zeigerLinks(){
    image(e4, handPosL.x-e4.width/2, -handPosL.y-e4.height/2);
  }
  
  void pose() {
//    image(posepng, -80, -128);
    PImage kalibrierungBild = context.rgbImage();
    PImage maske = loadImage("maske.jpg");
    kalibrierungBild.mask(maske);
    image(kalibrierungBild, -kalibrierungBild.width/2, -kalibrierungBild.height/2);

  }
  
  void fade(PImage fadeBild){ //muss einmal pro Frame mit dem betreffenden Bild aufgerufen werden
    if(fadeBild == altesFadeBild){
      alphaWert = (spitzeErreicht) ? alphaWert-10 : alphaWert+20;
      if(alphaWert > 255) {spitzeErreicht = true;}
      pushStyle();
      tint(255, alphaWert);
      image(fadeBild, -fadeBild.width/2, -fadeBild.height/2);
      popStyle();
    } else {
      spitzeErreicht = false;
      alphaWert = 0;      
    }
    altesFadeBild = fadeBild;
  }
}
