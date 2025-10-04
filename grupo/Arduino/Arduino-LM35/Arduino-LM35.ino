const int PINO_SENSOR_TEMPERATURA = A0;
float temperaturaCelsius;
int temperatura_max = 30;
int temperatura_min = 20;

void setup() {
  Serial.begin(9600);
}
void loop() {
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);
  temperaturaCelsius = (valorLeitura * 5.0 / 1023.0) / 0.01;

  // Serial.print(temperatura_min);
  // Serial.print(temperatura_max);
  // Serial.print(",");
  Serial.println(temperaturaCelsius);


  delay(1000);
  //  delay(500);
  
}