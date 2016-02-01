class Zeichnung {
  //Variablen:
  ArrayList kreisListe;
  ArrayList linienListe;
  float[]   vorherigerpunkt;
  float     faktor;
  float     moveX;
  float     moveY;
  float     tempDiagonal = 1;
  float     altX = 0;
  float     altY = 0;
  Kreis     EinKreis;
  Linie     EineLinie;
  int ebene;

  Zeichnung() {
    //Constructorcode:
    kreisListe = new ArrayList();
    linienListe = new ArrayList();
    vorherigerpunkt = new float[2];
    vorherigerpunkt[0] = 999999990;
  }


  //Funktionen:
  void start() {
    this.zeichnen();
//1.EBENE
    if (handPos.z > 800 && kopfPos.z > 800 && kopfPos.z < 1700) {
        DasUI.DerFarbbalken.zeigen();
        DasUI.ebene(2);
      
//      DasUI.ebene(1);
//      ebene=1;
//      this.hinzufuegen(handPos.x, handPos.y, handPos.z, ausgewaehlteFarbe);
//      println("E1");
      vorherigerpunkt[0] = 999999990;
    } else {
//2.EBENE
      if (kopfPos.z > 1900 && kopfPos.z < 2400) {
        DasUI.ebene(1);
        ebene=1;
        this.hinzufuegen(handPos.x, handPos.y, handPos.z, ausgewaehlteFarbe);
        
//        DasUI.DerFarbbalken.zeigen();
//        DasUI.ebene(2);
//        println("E2");
      } else {
        vorherigerpunkt[0] = 999999990;
//3.EBENE
        //Skalieren-Werte speichern
        if (kopfPos.z > 2500 && kopfPos.z < 3200) {
          float neuX = handPos.x + (handPos.x - handPosL.x) / 2;
          float neuY = handPos.y + (handPos.y - handPosL.y) / 2;
          float diagonal1 = sqrt( sq(handPosL.x) + sq(handPosL.y) );
          
//          println("E3");
//4.EBENE
          //skalieren
          if (kopfPos.z > 2600 && kopfPos.z < 3100) {
            DasUI.ebene(4);
            //          println("TempDiagonal: " + tempDiagonal);
            //          println("Diagonal1: " + diagonal1);
            moveX = neuX - altX;
            moveY = altY - neuY;
            faktor = diagonal1 / tempDiagonal; 
            this.skalieren(faktor);
            this.verschieben(moveX, moveY);
//            println("E4");
            record = 0; //dass man wieder speichern kann
          } else {
            DasUI.ebene(3);
          }
          tempDiagonal = diagonal1;
          altX = neuX;
          altY = neuY;
        } else { 
//5.EBENE
          //speichern
          if(kopfPos.z > 3200){
            DasUI.ebene(5);
            this.speichern();
//            println("E5");
          } else {
            DasUI.ebene(0);
            DasFoto.zuschneiden();
          }
        } 
      }
    }
  }




  void hinzufuegen(float xPosition, float yPosition, float entfernung, color farbe) { 
    //fügt der ArrayList neue Kreise und Linien hinzu      
    //Linien*********
    if ( vorherigerpunkt[0] < 99999999) { //ueberpruefen ob ein der vorhergehende Punkt innerhalb des Zeichenabstands war
      EineLinie = new Linie(vorherigerpunkt[0], vorherigerpunkt[1], xPosition, yPosition, entfernung/2, farbe);
      linienListe.add(EineLinie);
    }

    //Kreise*********
    EinKreis = new Kreis(xPosition, yPosition, entfernung/2, farbe);
    kreisListe.add(EinKreis);

    vorherigerpunkt[0] = xPosition;
    vorherigerpunkt[1] = yPosition;
  }


  void zeichnen() { 
    //gibt die ganze Zeichnung aus
    if (kreisListe.size() > 0) {
      for (int i = 0; i < kreisListe.size(); i++) { 
        Kreis AktuellerKreis = (Kreis)kreisListe.get(i);
        AktuellerKreis.zeichnen();
      }  
      for (int i = 0; i < linienListe.size(); i++) {
        Linie AktuelleLinie = (Linie)linienListe.get(i);
        AktuelleLinie.zeichnen();
      }
    }
  }


  void verschieben(float moveX, float moveY) {
    //alle Daten müssen neu in die ArrayList geschrieben werden
    //kreisListe & linienListe Zwischenspeichern & leeren, Positionen verschieben und wieder neu in die Ursprüngliche Liste speichern

    //Daten kopieren:
    ArrayList kreisZwischenListe = kreisListe;
    ArrayList linienZwischenListe = linienListe;
    //Alte Löschen bzw. mit leerer Liste uberschreiben:
    kreisListe = new ArrayList();
    linienListe = new ArrayList();
    //Verschieben & neu speichern:
    if (kreisZwischenListe.size() > 0) {
      for (int i = 0; i < kreisZwischenListe.size(); i++) { 
        Kreis AktuellerKreis = (Kreis)kreisZwischenListe.get(i);
        AktuellerKreis.verschieben(moveX, moveY);
        kreisListe.add(AktuellerKreis);
      }  
      for (int i = 0; i < linienZwischenListe.size(); i++) {
        Linie AktuelleLinie = (Linie)linienZwischenListe.get(i);
        AktuelleLinie.verschieben(moveX, moveY);
        linienListe.add(AktuelleLinie);
      }
    }
  }


  void skalieren(float faktor) {
    //alle Daten müssen neu in die ArrayList geschrieben werden
    //kreisListe & linienListe Zwischenspeichern & leeren, Positionen verändern und wieder neu in die Ursprüngliche Liste speichern

    //Daten kopieren:
    ArrayList kreisZwischenListe = kreisListe;
    ArrayList linienZwischenListe = linienListe;
    //Alte Löschen bzw. mit leerer Liste uberschreiben:
    kreisListe = new ArrayList();
    linienListe = new ArrayList();
    //skalieren & neu speichern:
    if (kreisZwischenListe.size() > 0) {
      for (int i = 0; i < kreisZwischenListe.size(); i++) { 
        Kreis AktuellerKreis = (Kreis)kreisZwischenListe.get(i);
        AktuellerKreis.skalieren(faktor);
        kreisListe.add(AktuellerKreis);
      }  
      for (int i = 0; i < linienZwischenListe.size(); i++) {
        Linie AktuelleLinie = (Linie)linienZwischenListe.get(i);
        AktuelleLinie.skalieren(faktor);
        linienListe.add(AktuelleLinie);
      }
    }
  }

  void speichern() {
    record = record + 1;
    if (record == 1) {
      
      beginRecord(PDF, "Bilder/Zeichnung " + day() + "." + month() + ". - " + hour() + " Uhr " + minute() + ".pdf"); //PDF speichern
      
      pushMatrix(); 
      translate(width/2, height/2);
      DasFoto.zeigen();
      this.zeichnen();
      
      endRecord(); //Aufzeichnung beenden
      popMatrix();
      record = 2;
    }
  }
}

