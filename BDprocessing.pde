import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.serial.*;
Minim minim;
AudioInput in;
FFT fft;
Serial myPort;
int w;

PImage fade;

void setup() 
{
  //Change COM port accordingly
  myPort = new Serial(this, "/dev/ttyUSB0", 115200);
  size(640,480); 
  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO,1024); 

  fft = new FFT(in.bufferSize(),in.sampleRate());
  //fft.linAverages(60);
  fft.logAverages(30,5);

  stroke(255); 
  w=width/fft.avgSize();
  strokeWeight(w); 

  background(0);

}

int sum = 0;
int bass = 0;
int mid = 0;
int treble = 0;

void draw() 
{
  background(0);
  fft.forward(in.mix); 

  for(int i = 0; i < fft.avgSize(); i++) 
  {
    line((i*w)+(w/2),height, (i*w)+(w/2), height - fft.getAvg(i)*3);
    
  bass = int(fft.calcAvg(0,200));
  mid = int(fft.calcAvg(300,2000));
  treble = int(fft.calcAvg(3500,10000));
  
  int bassF = int(map(bass, 0, 125, 0,255 ));
  int midF = int(map(mid, 0, 20,0, 255));
  int trebleF = int(map(treble, 0, 10, 0, 255));
  
  print(bass + " ");
  print(mid + " ");
  println(treble);  
  
  //Dump to serial.
  byte out[] = new byte[3];
  out[0] = byte(bassF);
  out[1] = byte(midF);
  out[2] = byte(trebleF);
  myPort.write(out);
}
}
