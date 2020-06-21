class player {
  FBox shape;

  int lastJumpFrame;
  int jumpPassedTime;
  int lastShootFrame;
  int shootPassedTime;
  int jumpCoolDown = 100;
  float jumpForce = 8000;
  float moveSpeed = 100;
  float healthBar = 100;
  
  player(PVector position, PVector colour) {
    this.shape = new FBox(20,20);
    this.shape.setFill(colour.x, colour.y, colour.z);
    this.shape.setPosition(position.x, position.y);
    world.add(this.shape);
  }
  
  PVector setMovementVector() {
    return new PVector(1,0);
  }
  
  void jump() {
    if(this.readyToJump()) {
      this.shape.addForce(0,-this.jumpForce);
      lastJumpFrame = frameCount;
    }
  }
 
  void readMovementVector(PVector movementVector) {
    if(movementVector.x > 0) {
      this.shape.addForce(this.moveSpeed,0);
    }
    else if(movementVector.x < 0) {
      this.shape.addForce(-this.moveSpeed,0);
    }
  }
  

  boolean readyToJump() {
    jumpPassedTime = frameCount - lastJumpFrame;
    
    if(jumpPassedTime > jumpCoolDown) {
      lastJumpFrame = frameCount;
      return true;
    }
    return false;
  }
  
  void run() {
    this.readMovementVector(this.setMovementVector());
    this.jump();
  }
}
