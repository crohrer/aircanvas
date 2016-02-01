class Foto{
  PImage userFoto;
  PImage maskiertesUserFoto;
  int vertikalZaehler = -2;
  int horizontalZaehler = -2;
  int k = 0;
//  PImage maske;
  
  Foto(){
    //Foto machen
    userFoto = context.rgbImage();
    maskiertesUserFoto = createImage(162, 176, RGB);
  }
  
  
  void zuschneiden(){
    for (int i = 0; i < 161920; i++) {
      if(i == 49280){
        vertikalZaehler=0;
        horizontalZaehler=0;
      }
      if(horizontalZaehler > -2) horizontalZaehler++;
      if(vertikalZaehler >= 0 && vertikalZaehler < 176 && horizontalZaehler > 243 && horizontalZaehler < 406 && k < 28512){
        maskiertesUserFoto.pixels[k] = userFoto.pixels[i];
//        println(k);
        maskiertesUserFoto.updatePixels();
        k++;
        
        
      } 
      if(horizontalZaehler == 639){
          horizontalZaehler = -1;
          vertikalZaehler++;
//          println("Vertikal " + vertikalZaehler); 

      }
    }  
  }
  
  void zeigen(){
//    userFoto.mask(maske);  
    image(maskiertesUserFoto, -width/2, -height/2);
  }
}
