Box box;
float s = PI / 8;
float mu = 0.5;

void setup() {
  println("s= "+s);
println("tan(s)= "+tan(s));

  size(600,600);
  
  box = new Box(width, 0);
}
void draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
  line(0,height,width,height-width*tan(s));
 // println(width + ":"+(width*tan(s)));
  
  fill(0);
  PVector g = new PVector(0,0.1);
  float Nsize = g.mag()*cos(s);
  PVector N = new PVector(-sin(s), -cos(s));
  N.mult(Nsize);
  float Fsize = mu*N.mag();
  PVector F = new PVector(cos(s),-sin(s));
  F.mult(Fsize);
  
  box.applyForce(g);
  box.applyForce(N);
  box.applyForce(F);
  
  box.update();
  box.display(s);
  
  

}