PImage goku;
ArrayList<Particle> particles;

void setup() {
  size(800, 600);
  goku = loadImage("goku.png");
  particles = new ArrayList<Particle>();
  imageMode(CENTER); // Centraliza a imagem nos pontos de referência
}

void draw() {
  background(0);
  
  drawGlow(width/2, height/2, 180, color(255, 220, 0, 20));
  
  if (frameCount % 2 == 0) {
    for (int i = 0; i < 3; i++) {
      float angle = random(TWO_PI);
      float distance = random(100, 150);
      float x = width/2 + cos(angle) * distance;
      float y = height/2 + sin(angle) * distance;
      particles.add(new Particle(x, y));
    }
  }
  
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.isDead()) {
      particles.remove(i);
    }
  }
  
  image(goku, width/2, height/2, 300, 400);
}

void drawGlow(float x, float y, float radius, color c) {
  noStroke();
  for (float r = radius; r > 0; r -= 2) {
    float alpha = map(r, 0, radius, 40, 0);
    fill(c, alpha);
    ellipse(x, y, r*2, r*2);
  }
}

class Particle {
  float x, y;
  float vx, vy;
  float size;
  float lifespan;
  color col;
  
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    
    float dx = x - width/2;
    float dy = y - height/2;
    float dist = sqrt(dx*dx + dy*dy);
    
    vx = dx/dist * random(0.3, 1.2);
    vy = dy/dist * random(0.3, 1.2);
    
    size = random(3, 10);
    lifespan = random(150, 255);
    
    float r = random(220, 255);
    float g = random(180, 255);
    float b = random(0, 30);
    col = color(r, g, b);
  }
  
  void update() {
    x += vx;
    y += vy;
    lifespan -= random(1, 3);
    size *= 0.99; 
  }
  
  void display() {
    noStroke();
    
    float glow = size * 2;
    fill(col, lifespan * 0.2);
    ellipse(x, y, glow, glow);
    
    fill(col, lifespan);
    ellipse(x, y, size, size);
  }
  
  boolean isDead() {
    return lifespan < 0 || size < 0.5;
  }
}
