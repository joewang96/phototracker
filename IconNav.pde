class IconNav {
  private String desc;
  private int x, y, w, h;
  private PImage image;
  boolean hovered;
  
  public IconNav(String desc, int x, int y, int w, int h, PImage image) {
    this.desc = desc;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.image = image;
  }
  
  public void display() {
    imageMode(CENTER);
    this.image.resize(this.w, this.h);
    if (this.hovered) {
      this.drawTooltip();
      tint(255, 100);
    }
    image(this.image, this.x, this.y);
    noTint();
  }
  
  private void drawTooltip() { // draws the "instagram card" above the data point on hover
    rectMode(CENTER);
    noStroke();
    fill(230);
    rect(this.x, this.y + 50, this.h * 4, this.h, 12);
    triangle(this.x, this.y + 20,
             this.x + 10, this.y + 35,
             this.x - 10, this.y + 35);
    fill(50);
    textAlign(CENTER, CENTER);
    textFont(loadFont("Helvetica-Light-48.vlw"));
    textSize(12);
    text(this.desc, this.x, this.y+50);
  }
  
  // tells if something is within the button
  public boolean contains(int x, int y) {
    return (x > this.x - (this.image.width/2)) && (x < this.x + (this.image.width/2)) &&
           (y > this.y - (this.image.height/2)) && (y < this.y + (this.image.height/2));
  }
  
  // handles the hover state (used in conjunction with the mouseX and mouseY)
  public void hoverState(int x, int y) {
    if (this.contains(x, y)) {
      this.hovered = true;
    }
    else {
      this.hovered = false;
    }
  }
}