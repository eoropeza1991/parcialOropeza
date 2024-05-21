import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;
boolean juegoIniciado = false;

PImage fondo;
PImage imgMoneda;
ArrayList<GameObject> objetos;
ArrayList<GameObject> objetosAEliminar;
int contador;

void setup() {
  size(800, 600);
  fondo = loadImage("fondo.png");
  imgMoneda = loadImage("moneda.png");

  objetos = new ArrayList<GameObject>();
  objetosAEliminar = new ArrayList<GameObject>();
  objetos.add(new Spawner(width/2, 2, imgMoneda));
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
    for (int i = 0; i < objetos.size(); i++) {
      GameObject obj = objetos.get(i);
      obj.update();
      obj.display();

      if (obj instanceof Spawner) {
        Spawner spawner = (Spawner) obj;
        spawner.spawn();
      }
    }


    for (GameObject obj : objetosAEliminar) {
      objetos.remove(obj);
    }
    objetosAEliminar.clear();
  }

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

class GameObject {
  protected float x, y;
  protected PImage imagen;

  public GameObject(float x, float y, PImage imagen) {
    this.x = x;
    this.y = y;
    this.imagen = imagen;
  }

  public void update() {

  }

  public void display() {

  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
}

class Moneda extends GameObject {
  protected float velocidad;

  public Moneda(float x, float y, float velocidad, PImage imagen) {
    super(x, y, imagen);
    this.velocidad = velocidad;
  }

  @Override
  public void update() {
    y += velocidad;
  }

  @Override
  public void display() {
    image(imagen, x, y);
  }
}

class Spawner extends GameObject {
  public Spawner(float x, float y, PImage imagen) {
    super(x, y, imagen);
  }

  public void spawn() {
    if (frameCount % 60 == 0) {
      float offScreenY = -50; // Posición fuera de la pantalla
      float randomX = random(width); // Posición aleatoria en el eje x
      objetos.add(new Moneda(randomX, offScreenY, 2, imagen)); // Generar moneda fuera de la pantalla
    }
  }
}
