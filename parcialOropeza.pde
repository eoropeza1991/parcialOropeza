import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;
boolean juegoIniciado = false;

PImage fondo;
PImage imgMoneda;
ArrayList<Moneda> monedas;
Spawner spawner;
int contador;

void setup() {
  size(800, 600);
  fondo = loadImage("fondo.png");
  imgMoneda = loadImage("moneda.png");

  monedas = new ArrayList<Moneda>();
  spawner = new Spawner(width/2, 2, imgMoneda);
  contador = 0;

  cp5 = new ControlP5(this);
  cp5.addButton("comenzar")
     .setPosition(10, height - 50)
     .setSize(100, 40);
  cp5.addButton("terminar")
     .setPosition(120, height - 50)
     .setSize(100, 40);
}

void draw() {
  background(fondo);

  if (juegoIniciado) {
    spawner.update();
    spawner.display();

    //  crear monedas
    if (frameCount % 60 == 0) {
      spawner.setX(random(width)); // Cambiar la posición del spawner
      float offScreenY = -50; // Posición fuera de la pantalla
      monedas.add(new Moneda(spawner.getX(), offScreenY, 2, imgMoneda)); // Generar moneda fuera de la pantalla
    }

    // que se muestren y muevan las monedas
    for (int i = monedas.size() - 1; i >= 0; i--) {
      Moneda moneda = monedas.get(i);
      moneda.fall();
      moneda.display();

     // borrar las monedas que lleguen al piso
      if (moneda.getY() > height) {
        monedas.remove(i);
        contador++;
      }
    }
  }

  // contador de monedas
  fill(255);
  textSize(24);
  text("Contador: " + contador, 10, 30);
}

void comenzar() {
  if (!juegoIniciado) {
    juegoIniciado = true;
  }
}

void terminar() {
  if (juegoIniciado) {
    juegoIniciado = false;
  }
}

class Moneda {
  protected float x, y;
  protected float velocidad;
  protected PImage imagen;

  public Moneda(float x, float y, float velocidad, PImage imagen) {
    this.x = x;
    this.y = y;
    this.velocidad = velocidad;
    this.imagen = imagen;
  }

  public void fall() {
    y += velocidad;
  }

  public void display() {
    image(imagen, x, y);
  }

  public float getY() {
    return y;
  }
}

class Spawner {
  private float x;
  private float velocidad;
  private PImage imagen;

  public Spawner(float x, float velocidad, PImage imagen) {
    this.x = x;
    this.velocidad = velocidad;
    this.imagen = imagen;
  }

  public void setX(float x) {
    this.x = x;
  }

  public float getX() {
    return x;
  }

  public void update() {
    // Actualizar spawner si es necesario
  }

  public void display() {
    // Mostrar spawner si es necesario
  }
}
