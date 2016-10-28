import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PImage reference;
String format=".jpg";
String name="ziad2";
String loadPath="data/"+name+format;
String notes []={"D", "E", "F", "G", "A", "Bb", "C", "D"};
/*
Color ranges
 0->21 Red C4
 21->51 Orange Bb
 51->66 Yellow Ab
 66->155 Green G
 155->190 Cyan F
 190->260 BLue Db
 260->288 purple C3
 288->325 Pink Eb
 325->360 Red C4
 */

Minim minim;
AudioOutput out;

void setup()
{
  size( 500, 500 );
  colorMode(HSB);
  reference = loadImage(loadPath);
  minim=new Minim(this);
  out= minim.getLineOut();
  out.setTempo(200); 
  out.pauseNotes();
  for (int i=0; i<500; i++)
  {
    seperate(i);
  }
  out.resumeNotes();
  noLoop();
}

void draw() {
}

void stop()
{
  out.close();
  minim.stop();
}

void seperate(int i)
{
  float x=random(reference.width);
  float y=random(reference.height);
  String note;
  int tbp;//to be played
  color c = reference.get(int(x), int(y));
  float hew=hue(c);

  if (hew<21 &&hew>=325)
    note=notes[7];
  else if (hew>=21 && hew<51)
    note=notes[6];
  else if (hew>=51 && hew<66)
    note=notes[5];
  else if (hew>=66 && hew<155)
    note=notes[4];
  else if (hew>=155 && hew<190)
    note=notes[3];
  else if (hew>=190 && hew<260)
    note=notes[1];
  else if (hew>=260 && hew<288)
    note=notes[0];
  else if (hew>=288 && hew<325)
    note=notes[2];
  else note ="";

  tbp=findN(note);

  float sat=saturation(c);
  if (sat<=0 &&sat>25)
    note+="2";
  else if (sat<=25 &&sat>50)
    note+="4";
  else if (sat<=50 &&sat>=75)
    note+="6";
  else if (sat<=75 &&sat>=100)
    note+="8";
  float bri=brightness(c);
  if (bri<=50)
  {
    out.playNote(i, 3,notes[tbp]);
    out.playNote(i, 3,notes[((tbp+2)%8)]);
    out.playNote(i, 3,notes[((tbp+4)%8)]);
  } else
    out.playNote(i, note);
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
