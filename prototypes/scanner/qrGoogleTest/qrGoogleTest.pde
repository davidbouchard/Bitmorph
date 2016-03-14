//Processing app using Google QR Code api to batch create QR Codes based on 4-letter configurations
//Code by Bram

//Arraylists for storing the images and accountCodes
ArrayList<PImage> images = new ArrayList(); 
ArrayList<String> accountCodes = new ArrayList();

//integer to store which code is currently displayed
int currentCode = 0;

int totalAccountNumb = 456976; ///26*26*26*26
int totalAccountsSaved = 0;

File fChecker;
String filename; 
PImage img;
PImage localCopy;

//setup function
void setup()
{
  size(600, 600);

  //use seperate thread to speed up QR creation
  thread("loadImages"); // run it on the side
}

//draw function
void draw()
{
  background(0);

  //make sure there is atleast one image to be displayed before displaying anything
  if (images.size() > 0)
  {
    //allows for previewing the QR code
    image(images.get(currentCode), width/2-50, height/2-50);
    textSize(21);
    text("Account# " + currentCode + " Account Code: "+ accountCodes.get(currentCode), width/4, 20);
  }

  text("Saving Account " + totalAccountsSaved + " of " + totalAccountNumb + "...", width/3, height-30);    //display the number of QR Codes currently saved
}

//loadImages function
//this function does the bulk of the work
//it dynamically creates a query for the google api to generate a QR Code based on a 4-letter configuration
// i.e. aaaa
//      aaab
//      aaac
//      ..etc..
//
// the 4-letter configuration allows for the hundreds of thousands of user accounts and QR codes to be made
void loadImages()
{
  //Four nested for-loops allows for the letter combinations
  for (int a = 0; a < 26; a++)
  {
    for (int b = 0; b < 26; b++)
    {
      for (int c = 0; c < 26; c++)
      {
        for (int d = 0; d < 26; d++)
        {
          //the line of code we run to retrieve the QR code
          String query = "https://chart.googleapis.com/chart?";   //main url of the link
          query += "chs=100x100";                                //size of the image
          query += "&cht=qr";                                    //type of image we want (QR code)
          query += "&chl=";                                      //attribute for the characters we want to store in the QR code
          String accountCode = "";

          //four seperate switch cases adds the characters we need based on the for-loop iterators
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

          accountCodes.add(accountCode);    //store the account code so we can preview it

          query += accountCode;              //add the code to the query

          img = loadImage(query, "jpg");  //store the image we get from the query as a jpg
          images.add(img);

          filename = sketchPath()+ "\\QR Codes\\" + accountCode + ".jpg";
          fChecker = new File(filename);
          if (fChecker.exists() == false) {    //check to see if the file exists or not
            //save it in to the QR Codes folder in the sketch directory
            localCopy = createImage(100, 100, RGB);    //save a local copy
            localCopy = img.get();
            localCopy.save(filename);
          }  
          totalAccountsSaved++;
        }
      }
    }
  }
}

//overloaded mousePressed eventHandler
//LMB and RMB cycles through the QR Code previews
void mousePressed()
{
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