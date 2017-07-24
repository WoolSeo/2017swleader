
PImage img;
void setup() {
  img = loadImage("seoul.jpg");
  size(800, 534);
  int resolution = 100;
  int xinc = width/resolution;
  int yinc = height/resolution;
  for (int x = 0; x < img.width; x+=xinc) {
    for (int y = 0; y < img.height; y+=yinc) {
      fill(img.get(x, y));
      rect(x, y, xinc, yinc);
    }
  }
}

void draw() {
}