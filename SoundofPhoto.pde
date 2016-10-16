import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PImage reference;
String format=".jpg";
String name="ziad";
String loadPath="data/"+name+format;
String notes []={"C4", "Db4", "Eb4", "F4", "G4", "Ab4", "Bb4", "C5"};
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
  out.setTempo(140);
  out.pauseNotes();
  for (int i=0; i<500; i++)
  {
    String note;
    float x=random(reference.width);
    float y=random(reference.height);
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
    out.playNote(i, note);
  }
  out.resumeNotes();
}
void draw() {
  image(reference, 0, 0);
}
void stop()
{
  out.close();
  minim.stop();
}