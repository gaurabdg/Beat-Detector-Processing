int currentValue = 0;
int values[]={0,0,0};
int Rled = 3;
int Gled = 6;
int Bled = 10;


void setup() {
  Serial.begin(115200);
  pinMode(Rled, OUTPUT);
  pinMode(Gled, OUTPUT);
  pinMode(Bled, OUTPUT);
}


void loop() {
  //Scan serial to obtain RGB values from processing.
if(Serial.available()){
    int incomingValue = Serial.read();
    
    values[currentValue] = incomingValue;

    currentValue++;
    if(currentValue > 2){
      currentValue = 0;
    }
    analogWrite(Rled, values[2]);
    analogWrite(Gled, values[1]);
    analogWrite(Bled, values[0]);
  } 
} 
