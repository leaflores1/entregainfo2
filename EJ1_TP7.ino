int entrada1 = 2;
int entrada2 = 3;
int salida1 = 4;
int salida2 = 5;

void setup() {
  pinMode(entrada1, INPUT);
  pinMode(entrada2, INPUT);
  pinMode(salida1, OUTPUT);
  pinMode(salida2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int estado1 = digitalRead(entrada1);
  int estado2 = digitalRead(entrada2);
  
  if (estado1 == HIGH) {
    digitalWrite(salida1, HIGH);
    Serial.println("Entrada1 alta");
  } else {
    digitalWrite(salida1, LOW);
    Serial.println("Entrada1 baja");
  }

  if (estado2 == HIGH) {
    digitalWrite(salida2, HIGH);
    Serial.println("Entrada2 alta");
  } else {
    digitalWrite(salida2, LOW);
    Serial.println("Entrada2 baja");
  }
  
  delay(100);
}
