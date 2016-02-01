class Linie{
  float linieStartX;
  float linieStartY;
  float linieEndeX;
  float linieEndeY;
  float linieStaerke;
  color linieFarbe;
  
  Linie(float sx, float sy, float ex, float ey, float e, color f){
    linieStartX = sx;
    linieStartY = -sy; //Negativ weil das Bild von der Kinect falschrum ist
    linieEndeX = ex;
    linieEndeY = -ey; //Negativ weil das Bild von der Kinect falschrum ist
    linieStaerke = 5000/e; //Umrechnung von Entfernung in Durchmesser (dasselbe wie in der Klasse Kreis + ein bisschen größer machen um 2)
    linieFarbe = f;
  }
  
  void zeichnen(){
    smooth();
    strokeWeight(linieStaerke);
    stroke(linieFarbe);
    line(linieStartX, linieStartY, linieEndeX, linieEndeY);
  }
    
  void verschieben(float moveX, float moveY){
    linieStartX = linieStartX + moveX;
    linieStartY = linieStartY + moveY;
    linieEndeX = linieEndeX + moveX;
    linieEndeY = linieEndeY + moveY;
  }
  
  void skalieren(float faktor){
    linieStartX = linieStartX * faktor;
    linieStartY = linieStartY * faktor;
    linieEndeX = linieEndeX * faktor;
    linieEndeY = linieEndeY * faktor;
    linieStaerke = linieStaerke * faktor;
  }
}
