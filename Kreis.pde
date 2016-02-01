class Kreis{
  float kreisX;
  float kreisY;
  float kreisDurchmesser;
  color kreisFarbe;
  
  Kreis(float x, float y, float e, color f){
    kreisX = x;
    kreisY = -y; //Negativ weil das Bild von der Kinect falschrum ist
    kreisDurchmesser = 5000/e; //Umrechnung von Entfernung in Durchmesser (dasselbe wie in der Klasse Linie)
    kreisFarbe = f;
  }
  
  void zeichnen(){
    smooth();
    stroke(kreisFarbe);
    strokeWeight(0);
    fill(kreisFarbe);
    ellipse(kreisX, kreisY, kreisDurchmesser, kreisDurchmesser);
  }
  
  void verschieben(float moveX, float moveY){
    kreisX = kreisX + moveX;
    kreisY = kreisY + moveY;
  }
  
  void skalieren(float faktor){
    kreisX = kreisX * faktor;
    kreisY = kreisY * faktor;
    kreisDurchmesser = kreisDurchmesser * faktor;
  }
}
