class Netz {
  float abstandX =10;
  float abstandY =10;

  Netz(){
    strokeWeight(5);
    fill(0);
    line(0,-1000,0,1000);
    line(-1000,0,1000,0);
    line(-1000,-1000,1000,1000);
    line(1000,1000,-1000,-1000);
  }

}
