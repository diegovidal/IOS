void setup() {
  // put your setup code here, to run once:
  pinMode(2, INPUT); //Echo (branco)
  pinMode(4, OUTPUT); //Trigger (cinza)
  pinMode(11, OUTPUT); //Enable right (verde)
  pinMode(10, OUTPUT); //Direction right (azul)
  pinMode(6, OUTPUT); //Enable left (verde)
  pinMode(5, OUTPUT); //Direction left (azul)
//  digitalWrite(10, HIGH);
//  digitalWrite(5, HIGH);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  startMeasuringDistance();
  int distance = readSensor();
  Serial.println(distance);
  if(distance <= 35 && distance > 0){
    turn45degreesLeft(true);
    int leftDistance = readSensor();
    turn90degreesLeft(false);
    int rightDistance = readSensor();
    if(leftDistance > rightDistance){
      turn90degreesLeft(true);
    }
  }
  else{
    //moveForward();
    pwm50();
  }
}

int readSensor(){
  int duration = pulseIn(2, HIGH);
  return duration/58;
}

void moveForward(){
  Serial.println("FRENTE");
  digitalWrite(11, LOW);
  digitalWrite(6, LOW);
  delay(10);
  
  digitalWrite(10, LOW);
  digitalWrite(5, LOW);
  digitalWrite(11, HIGH);
  digitalWrite(6, HIGH);
}

void moveBackwards(){
  digitalWrite(10, HIGH);
  digitalWrite(5, HIGH);
  digitalWrite(11, HIGH);
  digitalWrite(6, HIGH);
}

void turn90degreesLeft(bool dir){
  stopMotors();
  
  if(dir){
    digitalWrite(10, HIGH);
    digitalWrite(5, LOW);
  }
  else{
    digitalWrite(10, LOW);
    digitalWrite(5, HIGH);
  }
  
  digitalWrite(11, HIGH);
  digitalWrite(6, HIGH);

  delay(250);
  digitalWrite(11, LOW);
  digitalWrite(6, LOW);
}

void turn45degreesLeft(bool dir){
    stopMotors();
  if(dir){
    digitalWrite(10, HIGH);
    digitalWrite(5, LOW);
  }
  else{
    digitalWrite(10, LOW);
    digitalWrite(5, HIGH);
  }
  
  digitalWrite(11, HIGH);
  digitalWrite(6, HIGH);

  delay(125);
  digitalWrite(11, LOW);
  digitalWrite(6, LOW);
}

void stopMotors(){
  digitalWrite(11, LOW);
  digitalWrite(6, LOW);
  delay(10);
}

void pwm50(){
  //stopMotors();
  digitalWrite(10, LOW);
  digitalWrite(5, LOW);
  digitalWrite(11, HIGH);
  digitalWrite(6, HIGH);
  
  delayMicroseconds(250);
  
  digitalWrite(11, LOW);
  digitalWrite(6, LOW);
  
  delayMicroseconds(250);
}

void startMeasuringDistance(){
  digitalWrite(4, HIGH);
  delay(100);
  digitalWrite(4,LOW);
}

