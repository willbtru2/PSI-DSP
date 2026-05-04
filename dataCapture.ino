// Pins for photoresistors
const int sensor1Pin = A0;
const int sensor2Pin = A1;

// Simple low-pass filter variables
float alpha = 0.2;  // smoothing factor
float s1_filtered = 0;
float s2_filtered = 0;

void setup() {
  Serial.begin(115200);
}

void loop() {
  int s1_raw = analogRead(sensor1Pin);
  int s2_raw = analogRead(sensor2Pin);

  // Apply exponential moving average filter
  s1_filtered = alpha * s1_raw + (1 - alpha) * s1_filtered;
  s2_filtered = alpha * s2_raw + (1 - alpha) * s2_filtered;

  // Send data as CSV: time, sensor1, sensor2
  Serial.print(millis());
  Serial.print(",");
  Serial.print(s1_filtered);
  Serial.print(",");
  Serial.println(s2_filtered);

  delay(10);
}
