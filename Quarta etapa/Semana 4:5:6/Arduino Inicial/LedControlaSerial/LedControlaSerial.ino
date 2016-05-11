
void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

void loop() {
//  digitalWrite(13, HIGH);
//  Serial.println("1");
//  delay(1000);
//  
//  digitalWrite(13, LOW);
//  Serial.println("0");
//  delay(1000);
}

void serialEvent(){

  char value = (char)Serial.read();
  if(value == '1'){
    digitalWrite(13, HIGH);  
  } else {
    digitalWrite(13, LOW);  
  }
}
