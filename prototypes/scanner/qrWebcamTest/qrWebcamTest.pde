//processing program to use webcam to read QR Code once every second
//based on QR Code Webcam example
//code by Bram

import processing.video.*;
import qrcodeprocessing.*;

Capture video;

String status;

Decoder decoder;

int timer = 0;
int timerDelay = 1000;

void setup()
{
  size(400, 320);
  video = new Capture(this, 320, 240);
  video.start();

  status = "Waiting for an QR Code";

  decoder = new Decoder(this);

  timer = millis();
}

void draw()
{
  background(0);

  image(video, 0, 0);

  textSize(20);
  text(status, 10, height-20);

  if (decoder.decoding())
  {
    PImage show = decoder.getImage();
    image(show, 0, 0, show.width/4, show.height/4); 
    status = "Decoding image";
    for (int i = 0; i < (frameCount/2) % 10; i++) 
    {
      status += ".";
    }

    if (millis() > timer)
    {
      PImage savedFrame = createImage(video.width, video.height, RGB);
      savedFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
      savedFrame.updatePixels();
      decoder.decodeImage(savedFrame);

      timer = millis()+timerDelay;
    }
  }
}

void decoderEvent(Decoder decoder)
{
  status = decoder.getDecodedString();
}


void captureEvent(Capture video)
{
  video.read();
}