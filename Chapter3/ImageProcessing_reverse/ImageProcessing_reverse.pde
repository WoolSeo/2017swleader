
PImage img;
void setup() {
  img = loadImage("seoul.jpg");
  size(800, 534);
  println(img.width);
  println(img.height);
  
}
void draw() {
  loadPixels(); 
  img.loadPixels(); 
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = y + x*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = 255-red(img.pixels[loc]);
      float g = 255-green(img.pixels[loc]);
      float b = 255-blue(img.pixels[loc]);
      
      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.
      
      // Set the display pixel to the image pixel
      pixels[loc] =  color(r,g,b);          
    }
  }
  updatePixels();
}