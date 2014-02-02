import spacebrew.*;

// import the beads library
import beads.*;

// create an audio context
AudioContext ac;

// declare the unit generators (Beads)
WavePlayer wp1;
Glide frequencyGlide1;
WavePlayer wp2;
Glide frequencyGlide2;
WavePlayer wp3;
Glide frequencyGlide3;
WavePlayer wp4;
Glide frequencyGlide4;

Gain g;
//Glide gainGlide;

int inputX = 0;
int inputY = 0;
int inputZ = 0;

int incomingx = 0;
int incomingy = 0;
int incomingz = 0;

String server="sandbox.spacebrew.cc";
//String server="54.201.24.223";
String name="additiveSynthesis";
String description ="This is an blank example client that publishes .... and also listens to ...";

Spacebrew sb;

void setup() {
  size(600, 600);
  background(0);

  // instantiate the sb variable
  sb = new Spacebrew( this );

  // add each thing you publish to
  sb.addPublish( "inputX", "range", 0 ); 
  sb.addPublish( "inputY", "range", 0 );
  sb.addPublish( "inputZ", "range", 0 );

  // add each thing you subscribe to
  sb.addSubscribe( "inputX", "range" );
  sb.addSubscribe( "inputY", "range" );
  sb.addSubscribe( "inputZ", "range" );

  // connect to spacebrew
  sb.connect(server, name, description );

  // initialize the AudioContext
  ac = new AudioContext();
  
  // create a gain Glide object
//  gainGlide = new Glide(ac, 0.0, 50);
  
  // create a frequency Glide object
  frequencyGlide1 = new Glide(ac, 20, 50);

  // create WavePlayers - WavePlayer objects generate a waveform
  wp1 = new WavePlayer(ac, frequencyGlide1, Buffer.SINE);
  
  // create second frequencyGlide and sine generator
  frequencyGlide2 = new Glide(ac, 20, 50);
  wp2 = new WavePlayer(ac, frequencyGlide2, Buffer.SINE);
  
  // create third frequencyGlide and sine generator
  frequencyGlide3 = new Glide(ac, 20, 50);
  wp3 = new WavePlayer(ac, frequencyGlide3, Buffer.SINE);
  
  // create third frequencyGlide and sine generator
  frequencyGlide4 = new Glide(ac, 20, 50);
  wp4 = new WavePlayer(ac, frequencyGlide4, Buffer.SINE);

  // create a Gain object which sets the volume
  g = new Gain(ac, 1, 0.5);
  
  // connect the WavePlayer output to the Gain input
  g.addInput(wp1);
  g.addInput(wp2);
  g.addInput(wp3);
  g.addInput(wp4);
  
  // connect the Gain output to the AudioContext
  ac.out.addInput(g);

  // connect the WavePlayer to the AudioContext
  ac.out.addInput(g);

  // start audio processing
  ac.start();
  
  background(0);
}

void draw(){
//  gainGlide.setValue(mouseX / (float)width);
//  frequencyGlide1.setValue(map (mouseY, 0, 300, 55, 880));
//  frequencyGlide2.setValue(map (mouseX, 0, 300, 55, 880));

  frequencyGlide1.setValue(incomingx);
  frequencyGlide2.setValue(incomingy);
  frequencyGlide3.setValue(55);
  frequencyGlide4.setValue(110);
  
}

void onRangeMessage( String name, int value ) {
  println("got range message " + name + " : " + value);

  if (name.equals("inputX")) {
    incomingx = value;
  } 
  else if (name.equals("inputY")) {
    incomingy = value;
  } 
  else if (name.equals("inputZ")) {
    incomingz = value;
  }
}

void onBooleanMessage( String name, boolean value ) {
  println("got boolean message " + name + " : " + value);
}

void onStringMessage( String name, String value ) {
  println("got string message " + name + " : " + value);
}

void onCustomMessage( String name, String type, String value ) {
  println("got " + type + " message " + name + " : " + value);
}



