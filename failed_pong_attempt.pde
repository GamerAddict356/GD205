float[] x = new float[0];
float[] y = new float[0];
float[] xSpeed = new float[0];
float[] ySpeed = new float[0];
float[] size = new float[0];
float[] r = new float[0];
float[] g = new float[0];
float[] b = new float[0];

void setup() {
  size(500, 500);
}

void draw() {

  background(200);

  for (int i = 0; i < x.length; i++) {

    x[i] += xSpeed[i];
    if (x[i] < 0 || x[i] > width) {
      xSpeed[i] *= -1;
    }

    y[i] += ySpeed[i];
    if (y[i] < 0 || y[i] > height) {
      ySpeed[i] *= -1;
    }

    fill(r[i], g[i], b[i]);
    ellipse(x[i], y[i], size[i], size[i]);
  }
}

void mousePressed() {
  x = append(x, mouseX);
  y = append(y, mouseY);
  xSpeed = append(xSpeed, random(-5, 5));
  ySpeed = append(ySpeed, random(-5, 5));
  size = append(size, random(5, 20));
  r = append(r, random(256));
  g = append(g, random(256));
  b = append(b, random(256));
}
