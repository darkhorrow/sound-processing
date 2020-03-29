import ddf.minim.*;

Minim minim;
AudioPlayer player;
PImage bg;
PImage flowers;
float interpolation = 0;

void setup() {
  size(768, 576);
  bg = loadImage("campo.jpg");
  bg.resize(width, height);
  flowers = loadImage("flowers.png");

  minim = new Minim(this);
  player = minim.loadFile("soft.wav");
}

void draw() {
  background(bg);
  stroke(255);
  fill(255);

  float mean = 0;
  for (int i = 0; i < player.bufferSize() - 1; i++) {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    line( x1, height + player.left.get(i)*100, x2, height + player.left.get(i+1)*100 );
    line( x1, height + player.right.get(i)*100, x2, height + player.right.get(i+1)*100 );
    mean += player.left.get(i);
  }

  mean /= player.bufferSize();

  mean = map(mean, -1*player.bufferSize(), player.bufferSize(), 1, 100);

  float posx = map(player.position(), 0, player.length(), 0, width);
  stroke(0, 200, 0);
  line(posx, 0, posx, height);

  textSize(15);
  if (player.isPlaying()) {
    fill(255, 0, 0);
    text("Press any key to pause playback.", 10, 20);
  } else {
    fill(0, 200, 0);
    text("Press any key to start playback.", 10, 20);
  }

  int value = (int) (mean + player.left.get((int)random(0, player.bufferSize()-1))*100);

  imageMode(CENTER);
  image(flowers, width/2, height - 150, value, value);
  image(flowers, width/2 - 150, height - 120, value, value);
  image(flowers, width/2 + 200, height - 75, value, value);
  image(flowers, width/2 - 50, height - 130, value, value);
  image(flowers, width/2 + 250, height - 55, value, value);
  image(flowers, width/2 - 10, height - 150, value, value);

}

void keyPressed() {
  if (player.isPlaying()) {
    player.pause();
  } else if (player.position() == player.length()) {
    player.rewind();
    player.play();
  } else {
    player.play();
  }
}
