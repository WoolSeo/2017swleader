class Box {
  
  PVector position;//위치 벡터
  PVector velocity;//속도 벡터
  PVector acceleration;//가속도 벡터
  float mass; //질량
  Box(float x, float y) {
    mass = 1;
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force) {//힘 적용
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void display(float s) {
    pushMatrix();
    translate(position.x,position.y);
    //println(position.x + ":"+position.y);
    stroke(0);
    rotate(-s);
    rect(0,0,15,-10);
    popMatrix();
  }
}