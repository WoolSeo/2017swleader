Box box;
int i = 10;
float s = PI / i;//45degree radian
float mu = tan(s)-0.5;//최대 정지 마찰 계수//-0.3;//0.1;//tan(s);//0.5;
//float mu = 0.5;

void setup() {
  println("s= "+s);
println("tan(s)= "+tan(s));

  size(600,600);
  
  box = new Box(width, height-width*tan(s));
}
void draw() {
  background(255);
  //stroke(0);
  //strokeWeight(2);
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

  if (box.position.x < 0) {
    println("new box generate");
    i--;
    s = PI / i;
    box = new Box(width, height-width*tan(s));
  }
  if (i == 3)
    noLoop();

}