class Dropdown {
  String title, body;
  PImage icon;
  int x, y, w, h, hSmall, hLarge; // hSmall is the height of the box when compressed, hLarge is the full height
  boolean hovered, toggled;
  
  public Dropdown(String title, String body, int x, int w, int hSmall, int hLarge) {
    this.title = title;
    this.body = body;
    this.x = x;
    this.w = w;
    this.hSmall = hSmall;
    this.hLarge = hLarge;
    icon = loadImage("");
    this.h = hSmall; // starts off compressed
    this.y = 0;
  }
  
  public void setY(int y) {
    this.y = y;
  }
  
  public void display() {
    rectMode(CORNER);
    textFont(loadFont("HelveticaNeue-Light-25.vlw"));
    this.hoverState(mouseX, mouseY);
    if (this.toggled) { // draws the body rect and body text BEFORE the title stuff (so it goes on the bottom of it)
      // larger rectangle
      fill(250);
      stroke(150, 150, 150, 50);
      strokeWeight(1);
      rect(this.x, this.y, this.w, this.hLarge, 5);
      
      // the body text
      fill(50);
      noStroke();
      textAlign(LEFT);
      textSize(14);
      text(this.body, this.x + 10, this.y + this.hSmall + 10, this.w - 10, this.y + this.hLarge - 10);
    }
    if (this.hovered) {
      fill(240);
    }
    else {
      fill(255);
    }
    stroke(150, 150, 150, 50);
    strokeWeight(1);
    rect(this.x, this.y, this.w, this.hSmall, 5);
    fill(50);
    noStroke();
    textAlign(LEFT, CENTER);
    textSize(18);
    text(this.title, this.x + 10, this.y + this.hSmall/2);
  }
  
  // tells if something is within the button
  public boolean contains(int x, int y) {
    return (x > this.x && (x < this.x + this.w ) &&
           (y > this.y && (y < this.y + this.h ) ) );
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
  
  public boolean getToggled() {
    return this.toggled;
  }
  
  public void changeToggle(boolean b) {
    toggled = b;
    if (this.toggled) {
      this.h = hLarge;
    }
    else {
      this.h = hSmall;
    }
  }
  
}