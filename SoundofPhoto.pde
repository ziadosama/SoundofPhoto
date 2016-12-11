import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//image loading
PImage reference;
String format=".jpeg";
String name="Darth";
String loadPath="data/"+name+format;

//scales
String scale1[]={"G", "A", "Bb", "C", "D", "Eb", "F", "G"};  //G minor
String scale2[]={"C", "D", "Eb", "F", "G", "Ab", "Bb", "C"};  //C minor
String scale3[]={"A", "B", "C", "D", "E", "F", "G", "A"};  //A minor
String notes[]=new String[8];
/*
Color ranges
 0->21 Red
 21->51 Orange
 51->66 Yellow
 66->155 Green
 155->190 Cyan
 190->260 BLue
 260->288 purple
 288->325 Pink
 325->360 Red
 */

Minim minim;
AudioOutput out;
AudioRecorder recorder;

void setup()
{
  size( 100, 100 );
  colorMode(HSB);
  reference = loadImage(loadPath);
  minim=new Minim(this);
  // get a stereo line-in: sample buffer length of 2048
  // default sample rate is 44100, default bit depth is 16
  out= minim.getLineOut(Minim.STEREO);
  out.setTempo(220);
  int scaleChoose=int(random(3));
  if (scaleChoose==1)
    for (int i=0; i<8; i++)
      notes[i]=scale1[i];
  else if (scaleChoose==2)
    for (int i=0; i<8; i++)
      notes[i]=scale2[i];
  else    
  for (int i=0; i<8; i++)
    notes[i]=scale3[i];

  recorder = minim.createRecorder(out, "myrecording.wav");
}
int k=0;
void draw() {
  out.pauseNotes();
  recorder.beginRecord();
  seperate(k);
  out.resumeNotes();
  k++;
}


void stop()
{
  out.close();
  minim.stop();
  super.stop();
}

void seperate(int i)
{
  float x=random(reference.width);
  float y=random(reference.height);
  String note;
  int tbp;//to be played
  color c = reference.get(int(x), int(y));
  float huee=hue(c);

  if (huee<21 &&huee>=325)
    note=notes[7];
  else if (huee>=21 && huee<51)
    note=notes[6];
  else if (huee>=51 && huee<66)
    note=notes[5];
  else if (huee>=66 && huee<155)
    note=notes[4];
  else if (huee>=155 && huee<190)
    note=notes[3];
  else if (huee>=190 && huee<260)
    note=notes[1];
  else if (huee>=260 && huee<288)
    note=notes[0];
  else if (huee>=288 && huee<325)
    note=notes[2];
  else note ="";

  tbp=findN(note);

  float sat=saturation(c);
  if (sat<=0 &&sat>25)
    note+="1";
  else if (sat<=25 &&sat>50)
    note+="4";
  else if (sat<=50 &&sat>=75)
    note+="6";
  else if (sat<=75 &&sat>=100)
    note+="8";
  float bri=brightness(c);
  if (bri<=75)
  {
    out.playNote(i, 2, new SineInstrument(Frequency.ofPitch(notes[tbp]).asHz()));
    out.playNote(i, 2, new SineInstrument(Frequency.ofPitch(notes[((tbp+2)%8)]).asHz()));
    out.playNote(i, 2, new SineInstrument(Frequency.ofPitch(notes[((tbp+4)%8)]).asHz()));
  } else
    out.playNote(i, 1,new SineInstrument(Frequency.ofPitch(note).asHz()));
}
int findN(String note)
{
  for (int i=0; i<8; i++)
  {
    if (note==notes[i])
      return i;
  }
  return 0;
}

void keyReleased()
{
  if (key=='r')
  {
    recorder.endRecord();
    recorder.save();
  }
}