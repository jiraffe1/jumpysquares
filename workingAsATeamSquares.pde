import fisica.*;
FWorld world;
int toSpawnOnClick = 50;
ArrayList<player> players = new ArrayList<player>();

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
  runAllPlayers();

}

void runAllPlayers() {
  for(int i = players.size()-1; i >= 0; i--) {
    players.get(i).run();
  }
}

void mousePressed() {
  for(int i = 0; i < toSpawnOnClick; i++){
  players.add(new player(new PVector(mouseX, mouseY), new PVector(random(255), random(255), random(255))));
  }
}
