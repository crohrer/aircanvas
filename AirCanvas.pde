
/* --------------------------------------------------------------------------
 * AirCanvas
 * Christoph Rohrer & Lena Dudarenko
 * --------------------------------------------------------------------------
 * basierend auf:
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
import fullscreen.*; 
import processing.pdf.*;


SimpleOpenNI  context;
SoftFullScreen fs; 
color  ausgewaehlteFarbe = color(0,0,0);
PVector handPos = new PVector();
PVector handPosL = new PVector();
PVector kopfPos = new PVector();
int record = 0; //fürs PDF 0 => nicht aufzeichnen, 1 => aufzeichnen, 2 => Aufzeichnung beendet



//eigenes Objekt
Zeichnung DieZeichnung;
Test DerTest;
UI DasUI;
Foto DasFoto;

void setup()
{
//  size(1920,1080,P2D); //Fullscreen für den HD-TV
  size(1250,800,P2D);

  colorMode(HSB, 360, 100, 100);

  context = new SimpleOpenNI(this);
  fs = new SoftFullScreen(this); 

  // mirror is by default enabled
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  
  // enable RGB-Pic
  context.enableRGB();


  frameRate(30);
  //stroke(0, 0, 0);
  strokeWeight(0);
  smooth();

  //neue Instanz
  DasUI = new UI(); //Farbbalken ist hier auch drin
  DieZeichnung = new Zeichnung();
//  fs.enter(); //Fullscreen starten - kann man auch manuell per CMD + F machen
}

void draw()
{
  background(0, 0, 100);
  translate(width/2, height/2);

  if(keyPressed){
    if(key == 's') DieZeichnung.speichern();
  }

  // update the cam
  context.update();
  
  //DerTest = new Test();
 
  // draw the skeleton if it's available
  if (context.isTrackingSkeleton(1)){
    drawSkeleton(1);
  } else {
    DasUI.pose();
  }
}
  


// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
   context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
   println(jointPos);
   */
   
   
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,handPos);
//  println("HandRight: " + handPos + " X: " + handPos.x + " Y: " + handPos.y +"Z: "+ handPos.z);
  
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,handPosL);
//  println("HandLeft: " + handPos + " X: " + handPosL.x + " Y: " + handPosL.y +"Z: "+ handPosL.z);

  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,kopfPos);
//  println("X: " + kopfPos.x + " Y: " + kopfPos.y + " Z: " +  kopfPos.z);
 
  
  //neue Daten hinzufügen
  DieZeichnung.start(); 
  
  
  

  /*  
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  */
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");

  context.startPoseDetection("Psi", userId);
}

void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
}

void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId);
    
    DasFoto = new Foto();
    
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId)
{
  println("onStartPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");

  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose, int userId)
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

