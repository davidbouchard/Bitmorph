//Processing app using Google QR Code api to batch create QR Codes based on 4-letter configurations
//Code by Bram

ArrayList<PImage> images = new ArrayList(); 
ArrayList<String> accountCodes = new ArrayList();

PImage average;

int currentCode = 0;

void setup()
{
  size(600, 600);

  average = createImage(150, 150, RGB);

  thread("loadImages"); // run it on the side
}

void draw()
{
  background(0);
  if (images.size() > 0)
  {
    image(images.get(currentCode), width/2-50, height/2-50);
    textSize(21);
    text("Account# " + currentCode + " Account Code: "+ accountCodes.get(currentCode), width/4, 20);
  }

  //for(int i = 0; i < images.size(); i++)
  //{
  //  int tempint = int(random(0,images.size()));
  //  image(images.get(tempint),0,0);
  //}
}


void loadImages()
{
  for (int a = 0; a < 26; a++)
  {
    for (int b = 0; b < 26; b++)
    {
      for (int c = 0; c < 26; c++)
      {
        for (int d = 0; d < 26; d++)
        {
          String query = "https://chart.googleapis.com/chart?"; 
          query += "chs=100x100";
          query += "&cht=qr";
          query += "&chl=";
          String accountCode = "";
          switch(a)
          {
          case 0:
            accountCode+="a";
            break;
          case 1:
            accountCode += "b";
            break;
          case 2:
            accountCode += "c";
            break;
          case 3:
            accountCode += "d";
            break;
          case 4:
            accountCode += "e";
            break;
          case 5:
            accountCode += "f";
            break;
          case 6:
            accountCode += "g";
            break;
          case 7:
            accountCode += "h";
            break;
          case 8:
            accountCode += "i";
            break;
          case 9:
            accountCode += "j";
            break;
          case 10:
            accountCode += "k";
          case 11:
            accountCode += "l";
            break;
          case 12:
            accountCode += "m";
            break;
          case 13:
            accountCode += "n";
            break;
          case 14:
            accountCode += "o";
            break;
          case 15:
            accountCode += "p";
            break;
          case 16:
            accountCode += "q";
            break;
          case 17:
            accountCode += "r";
            break;
          case 18:
            accountCode += "s";
            break;
          case 19:
            accountCode += "t";
            break;
          case 20:
            accountCode += "u";
            break;
          case 21:
            accountCode += "v";
            break;
          case 22:
            accountCode += "w";
            break;
          case 23:
            accountCode += "x";
            break;
          case 24:
            accountCode += "y";
            break;
          case 25:
            accountCode += "z";
            break;
          default:
            accountCode +="a";
            break;
          }

          switch(b)
          {
          case 0:
            accountCode+="a";
            break;
          case 1:
            accountCode += "b";
            break;
          case 2:
            accountCode += "c";
            break;
          case 3:
            accountCode += "d";
            break;
          case 4:
            accountCode += "e";
            break;
          case 5:
            accountCode += "f";
            break;
          case 6:
            accountCode += "g";
            break;
          case 7:
            accountCode += "h";
            break;
          case 8:
            accountCode += "i";
            break;
          case 9:
            accountCode += "j";
            break;
          case 10:
            accountCode += "k";
          case 11:
            accountCode += "l";
            break;
          case 12:
            accountCode += "m";
            break;
          case 13:
            accountCode += "n";
            break;
          case 14:
            accountCode += "o";
            break;
          case 15:
            accountCode += "p";
            break;
          case 16:
            accountCode += "q";
            break;
          case 17:
            accountCode += "r";
            break;
          case 18:
            accountCode += "s";
            break;
          case 19:
            accountCode += "t";
            break;
          case 20:
            accountCode += "u";
            break;
          case 21:
            accountCode += "v";
            break;
          case 22:
            accountCode += "w";
            break;
          case 23:
            accountCode += "x";
            break;
          case 24:
            accountCode += "y";
            break;
          case 25:
            accountCode += "z";
            break;
          default:
            accountCode +="a";
            break;
          }

          switch(c)
          {
          case 0:
            accountCode+="a";
            break;
          case 1:
            accountCode += "b";
            break;
          case 2:
            accountCode += "c";
            break;
          case 3:
            accountCode += "d";
            break;
          case 4:
            accountCode += "e";
            break;
          case 5:
            accountCode += "f";
            break;
          case 6:
            accountCode += "g";
            break;
          case 7:
            accountCode += "h";
            break;
          case 8:
            accountCode += "i";
            break;
          case 9:
            accountCode += "j";
            break;
          case 10:
            accountCode += "k";
          case 11:
            accountCode += "l";
            break;
          case 12:
            accountCode += "m";
            break;
          case 13:
            accountCode += "n";
            break;
          case 14:
            accountCode += "o";
            break;
          case 15:
            accountCode += "p";
            break;
          case 16:
            accountCode += "q";
            break;
          case 17:
            accountCode += "r";
            break;
          case 18:
            accountCode += "s";
            break;
          case 19:
            accountCode += "t";
            break;
          case 20:
            accountCode += "u";
            break;
          case 21:
            accountCode += "v";
            break;
          case 22:
            accountCode += "w";
            break;
          case 23:
            accountCode += "x";
            break;
          case 24:
            accountCode += "y";
            break;
          case 25:
            accountCode += "z";
            break;
          default:
            accountCode +="a";
            break;
          }

          switch(d)
          {
          case 0:
            accountCode+="a";
            break;
          case 1:
            accountCode += "b";
            break;
          case 2:
            accountCode += "c";
            break;
          case 3:
            accountCode += "d";
            break;
          case 4:
            accountCode += "e";
            break;
          case 5:
            accountCode += "f";
            break;
          case 6:
            accountCode += "g";
            break;
          case 7:
            accountCode += "h";
            break;
          case 8:
            accountCode += "i";
            break;
          case 9:
            accountCode += "j";
            break;
          case 10:
            accountCode += "k";
          case 11:
            accountCode += "l";
            break;
          case 12:
            accountCode += "m";
            break;
          case 13:
            accountCode += "n";
            break;
          case 14:
            accountCode += "o";
            break;
          case 15:
            accountCode += "p";
            break;
          case 16:
            accountCode += "q";
            break;
          case 17:
            accountCode += "r";
            break;
          case 18:
            accountCode += "s";
            break;
          case 19:
            accountCode += "t";
            break;
          case 20:
            accountCode += "u";
            break;
          case 21:
            accountCode += "v";
            break;
          case 22:
            accountCode += "w";
            break;
          case 23:
            accountCode += "x";
            break;
          case 24:
            accountCode += "y";
            break;
          case 25:
            accountCode += "z";
            break;
          default:
            accountCode +="a";
            break;
          }
          accountCodes.add(accountCode);
          query += accountCode;
          PImage img = loadImage(query, "png");
          images.add(img);
          PImage localCopy = createImage(100,100,RGB);
          localCopy = img.get();
          String filename = "C:\\Users\\Bram\\Desktop\\qrGoogleTest\\" + accountCode + ".jpg";
          
          localCopy.save(filename);
          
        }
      }
    }
  }
}

void mousePressed()
{
  //tint(255, 128); 
  //int tempint = int(random(0, images.size()));
  //image(images.get(tempint), 0, 0);

  if (mouseButton == LEFT)
  {
    currentCode++;
    if (currentCode > images.size())
    {
      currentCode = 0;
    }
  }

  if (mouseButton == RIGHT)
  {
    currentCode--;
    if (currentCode < 0)
    {
      currentCode = images.size()-1;
    }
  }
}