class Farbbalken{
  float segmentbreite = width/400;
  float hoehe = 100;
  int hWert;
  PImage balkenbild;

  Farbbalken(){     
    //Balken vorbereiten*****************
      balkenbild = createImage(int(360*segmentbreite), int(hoehe), RGB);
      balkenbild.loadPixels();
      for (int i = 0; i < balkenbild.pixels.length; i++) {
        balkenbild.pixels[i] = color( int(float(i % balkenbild.width) / balkenbild.width * 360), 70, 100); 
      }
      balkenbild.updatePixels();
  }  

  void zeigen(){
    //Balken zeichnen*****************
      image(balkenbild, -width/2, -height/2);
      noStroke();
      fill(0,0,0);
      rect(360*segmentbreite-width/2, -height/2, 400*segmentbreite, hoehe);
      //*********************************
      
      
      //Farbe auswählen******************
      if(-handPos.y < hoehe-height/2){
        if(handPos.x > 360*segmentbreite-width/2){ //wenn SCHWARZ
          ausgewaehlteFarbe = color(0,0,0);
        }
        else {
          hWert = (int)Math.ceil((width/2+handPos.x)/segmentbreite); //Position wird in Hue umgerechnet & aufgerundet
          ausgewaehlteFarbe = color(hWert,70,100);
        }
      }
      //*********************************
      
      
      //immer Streifen mit Farbe unten anzeigen**********
      rectMode(CENTER);
      fill(ausgewaehlteFarbe);
      noStroke();
      rect(0,height/2-50,width,100);
      rectMode(CORNER); //center wieder ausschalten
      //*******************************************
  }
}
