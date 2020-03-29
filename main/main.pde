import ddf.minim.*;

Minim minim;
AudioPlayer player;
PImage bg;
PImage flowers;

void setup()
{
  size(768, 576, P2D);
  bg = loadImage("campo.jpg");
  bg.resize(width, height);
  flowers = loadImage("flowers.png");
  smooth(4);

  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("soft.mp3");
}

void draw()
{
  background(bg);
  stroke(255);
  fill(255);

  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  for (int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    line( x1, height + player.left.get(i)*100, x2, height + player.left.get(i+1)*100 );
    line( x1, height + player.right.get(i)*100, x2, height + player.right.get(i+1)*100 );
  }

  // draw a line to show where in the song playback is currently located
  float posx = map(player.position(), 0, player.length(), 0, width);
  stroke(0, 200, 0);
  line(posx, 0, posx, height);

  if ( player.isPlaying() )
  {
    text("Press any key to pause playback.", 10, 20 );
  } else
  {
    text("Press any key to start playback.", 10, 20 );
  }
  
  imageMode(CENTER);
  float v = player.left.get(0)*100;
  flowers.resize((int) (flowers.width + ), (int) (flowers.height + player.left.get(0)*100));
  image(flowers, width/2, height/2);
}

void keyPressed()
{
  if ( player.isPlaying() )
  {
    player.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  } else
  {
    player.play();
  }
}
