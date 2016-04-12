class Timer {
 int savedTime;
 int totalTime;

 Timer(int tempTotalTime) {
   totalTime = tempTotalTime;
 }

 //changeTime(int tempTime) {
 //  totalTime = tempTime;
 //}

 //start the timer
 void start() {
   savedTime = millis();
 }

 boolean isFinished() {
   //check how much time has passed
   int passedTime = millis() - savedTime;
   //has 5 seconds passed?
   if (passedTime > totalTime) {
     return true;
   } else {
     return false;
   }
 }
}