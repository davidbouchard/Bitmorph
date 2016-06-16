
// This class animates the pixelation masks used by the Model objects
class MaskAnimator {

  int row = 49;
  int span = 4;
  boolean done = false;

  //int fillRate = 5;
  //int rowChangeAmount = 15;

  int fillRate = 25;
  int rowChangeAmount = 5;


  void reset() {
    row = 49;
    done = false;
  }

  void pixelateIn(float[][] mask) {  
    ArrayList<PVector> blackOnes = new ArrayList(); 
    for (int j=row-span; j <= row; j++) { 
      for (int i=0; i < 50; i++) {      
        if (mask[j][i] == 0) blackOnes.add(new PVector(j, i));
      }
    }  
    if (blackOnes.size() < rowChangeAmount && row-span > 0) {
      // fill the bottom row 
      for (int i=0; i < 50; i++) {
        if (mask[row][i] == 0) mask[row][i] = 1;
        if (mask[row][i] == -1) mask[row][i] = -2; 
      }
      row--;
    } else {
      if (blackOnes.size() > 0) {
        int n = (int)random(min(blackOnes.size(), fillRate)) + 1;
        for (int i=0; i < n; i++) {
          int r = (int)random(blackOnes.size());
          PVector c = blackOnes.get(r);
          mask[(int)c.x][(int)c.y] = 1;
        }
      } else {
        if (row-span==0) done = true;
      }
    }
  }
  
  void reverse(float[][] target, float [][] src) {
    for (int i=0; i < 50; i++) { 
      for (int j=0; j < 50; j++) { 
         if (src[i][j] == 1) target[i][j] = 0;
         if (src[i][j] == -2) target[i][j] = 0;
      }
    }
    
  }
}