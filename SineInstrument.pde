class SineInstrument implements Instrument
{
  Oscil wave;
  ADSR adsr;
  SineInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 1, Waves.SINE  );
    adsr =new ADSR(0.5, 0.01, 0.05, 0.5, 0.5);
    wave.patch( adsr );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
     // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
      // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease( out );
    // call the noteOff 
    adsr.noteOff();
  }
}