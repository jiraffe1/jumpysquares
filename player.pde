class player {
  FBox shape;
  gun myGun = null;
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
  
  void shootGun(player target) {
    if(readyToShoot(myGun) && target != this) {
      myGun.shoot(target);
    }
  }
  
  void grabGun(gun gunToGrab) {
    myGun = gunToGrab;
    gunToGrab.setHolder(this);
  }
  
  boolean readyToJump() {
    jumpPassedTime = frameCount - lastJumpFrame;
    
    if(jumpPassedTime > jumpCoolDown) {
      lastJumpFrame = frameCount;
      return true;
    }
    return false;
  }
  
  boolean readyToShoot(gun gunToCheck) {
    if(gunToCheck != null) {
      int passedShootTime = frameCount - lastShootFrame;
      if(passedShootTime > gunToCheck.reloadFrames) {
        return true;
      }
      return false;
    }
    return false;
  }
  
  PVector getPosition() {
    return new PVector(this.shape.getX(),this.shape.getY());
  }
  
  player findNearestEnemy(ArrayList<player> enemies) {
     float minDist = 694201337;
     int foundIndex = 0;
     if(enemies.size() != 1 && enemies.size() != 0) {
       for(int i = enemies.size(); i >= 0; i--) {
         if(enemies.get(i) != this) {
           player enemy = enemies.get(i);
           PVector myPos = this.getPosition();
           PVector enemyPos = enemy.getPosition();
           float thisDist = PVector.dist(myPos, enemyPos);
           
           if(thisDist < minDist) {
             minDist = thisDist;
             foundIndex = i;
           }
         }
       }
     }    
     return enemies.get(foundIndex);
  }
  
  void checkForDeath() {
    if(this.healthBar <= 0) {
      players.remove(this);
    }
  }
  
  void run() {
    this.checkForDeath();
    this.readMovementVector(this.setMovementVector());
    this.jump();
  }
}
