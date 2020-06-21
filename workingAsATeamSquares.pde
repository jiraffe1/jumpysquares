import fisica.*;
FWorld world;

ArrayList<player> players = new ArrayList<player>();
ArrayList<gunType> typesOfGun = new ArrayList<gunType>();
ArrayList<gun> guns = new ArrayList<gun>();
ArrayList<damageEffect> effects = new ArrayList<damageEffect>();

void setup() {
  size(800,600);
  Fisica.init(this);  
  world = new FWorld();
  world.setEdges();
  
}

void draw() {
  background(255);

  fill(0);
  textSize(12);
  text(frameRate, 20, 20);
  text(players.size(), 20, 40);
  world.step();
  world.draw();
  allDamageEffects();
  displayWeapons();
  runAllPlayers();

}

void allDamageEffects() {
  for(int i = effects.size()-1; i >= 0; i--) {
    effects.get(i).run();
  }
}

void displayWeapons() {
  for(int i = guns.size()-1; i >= 0; i--) {
    guns.get(i).run();
  }
}

void runAllPlayers() {
  for(int i = players.size()-1; i >= 0; i--) {
    players.get(i).run();
  }
}

void mousePressed() {
  gunType pistol = new gunType(1, 5, new PVector(0,0), 30);
  players.add(new player(new PVector(mouseX, mouseY), new PVector(random(255), random(255), random(255))));
  guns.add(new gun(pistol, new PVector(mouseX, mouseY)));
}
