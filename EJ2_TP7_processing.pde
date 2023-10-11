import processing.serial.*;

Serial puerto;

int entrada1 = 1;  // Estado inicial de entrada 1 (por ejemplo, alto)
int entrada2 = 0;   // Estado inicial de entrada 2 (por ejemplo, bajo)
int salida1 = 0;    // Estado inicial de salida 1 (apagado)
int salida2 = 0;    // Estado inicial de salida 2 (apagado)

void setup() {
  size(400, 200);
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
  puerto = new Serial(this, "COM3", 9600); // Reemplazar "COM3" con el puerto correcto de Arduino
  puerto.bufferUntil('\n');
}

void draw() {
  background(255);  // Fondo blanco

  // Dibuja las entradas y salidas
  drawInput(100, 100, "Entrada 1", entrada1);
  drawOutput(300, 100, "Salida 1", salida1);
  drawInput(100, 150, "Entrada 2", entrada2);
  drawOutput(300, 150, "Salida 2", salida2);
}

void drawInput(float x, float y, String label, int state) {
  fill(state == 1 ? color(0, 255, 0) : color(255, 0, 0));  // Verde para alto, rojo para bajo
  ellipse(x, y, 40, 40);  // Círculo
  fill(0);  // Texto en negro
  textSize(12);
  textAlign(CENTER, CENTER);
  text(label, x, y + 30);
}

void drawOutput(float x, float y, String label, int state) {
  fill(state == 1 ? color(0, 255, 0) : color(255, 0, 0));  // Verde para alto, rojo para bajo
  rect(x, y, 40, 40);  // Rectángulo
  fill(0);  // Texto en negro
  textSize(12);
  textAlign(CENTER, CENTER);
  text(label, x, y + 30);
}

void enviarEstadoSalida(int numeroSalida, int estado) {
  puerto.write("Salida" + numeroSalida + ":" + estado + "\n");
}

void serialEvent(Serial p) {
  String mensaje = p.readStringUntil('\n');
  if (mensaje != null) {
    // Procesar el mensaje recibido de Arduino
    if (mensaje.startsWith("Entrada1:")) {
      entrada1 = Integer.parseInt(mensaje.substring(9).trim());
    } else if (mensaje.startsWith("Entrada2:")) {
      entrada2 = Integer.parseInt(mensaje.substring(9).trim());
    }
  
  }
}

void mousePressed() {
  // Enviar mensaje a Arduino para activar una salida
  if (mouseX < width / 2) {
    // Controlar la salida correspondiente
    puerto.write("Salida1\n");
  } else {
    puerto.write("Salida2\n");
  }
}
