
PImage img;

void setup() {
  size(800, 534);
  img = loadImage("seoul.jpg");
  image(img, 0, 0);
  imageMode(CENTER);
  noStroke();
  
  
}

void draw() { 
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);
  fill(pix);
  ellipse(x, y, 8, 8);
}