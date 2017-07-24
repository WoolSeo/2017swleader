
PImage img;
void setup() {
  img = loadImage("seoul.jpg");
  size(800, 534);
  
}
void draw() {
  loadPixels(); 
  img.loadPixels(); 
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = x + y*width;
      color c = img.pixels[loc];
      pixels[loc] =  color(red(c)*0.299+green(c)*0.587+blue(c)*0.114);          
    }
  }
  updatePixels();
}