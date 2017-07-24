PImage img;
void setup() {
  img = loadImage("seoul.jpg");
  size(800, 534);  
}
void draw() {
  background(0);
  image(img, 0, 0);
}