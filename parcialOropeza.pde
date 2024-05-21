import processing.core.PApplet;
import processing.core.PImage;
import java.util.ArrayList;

PImage fondo;
PImage imgMoneda;
ArrayList<Moneda> monedas;
int contador;

void setup() {
  size(800, 600);
  fondo = loadImage("fondo.png");
  imgMoneda = loadImage("moneda.png");

  monedas = new ArrayList<Moneda>();
  contador = 0;
}

void draw() {
  background(fondo);

  // crear monedas
  if (frameCount % 60 == 0) {
    monedas.add(new Moneda(random(width), 0, 2, imgMoneda));
  }

  // que se muestren y muevan las monedas
  for (int i = monedas.size() - 1; i >= 0; i--) {
    Moneda moneda = monedas.get(i);
    moneda.caer();
    moneda.mostrar(this);

    // borrar las monedas que lleguen al piso
    if (moneda.getY() > height) {
      monedas.remove(i);
      contador++;
    }
  }

  // contador de monedas
  fill(255);
  textSize(24);
  text("Contador: " + contador, 10, 30);
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

  public void caer() {
    y += velocidad;
  }

  public void mostrar(PApplet app) {
    app.image(imagen, x, y);
  }

  public float getY() {
    return y;
  }
}
