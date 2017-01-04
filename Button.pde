class Button {
  
  boolean toggled; // tells if the button is being hovered on or not
  boolean hovered;
  String text; // what the text of the button will read
  int x, y; // the position of the button, its width, and its height
  
  static final int w = 150;
  static final int h = 40;
  
  // the constructor for the button class
  public Button(String text, int x, int y) {
    this.text = text;
    this.x = x;
    this.y = y;
    this.hovered = false;
    this.toggled = false;
  }
  
  // draws the actual button (text and the button itself)
  protected void display() {
    this.hoverState(mouseX, mouseY);
    rectMode(CENTER);
    noStroke();
    if (this.toggled) {
      fill(255, 150, 150, 240);
    }
    else if (this.hovered) { // draws the hover state of the button
      fill(100, 100, 100, 240);
    }
    else { // draws the normal state of the button
      fill(100, 100, 100, 150);
    }
    rect(this.x, this.y, w, h, 10);
    
    // -- the text --
    fill(255);
    textSize(20);
    textAlign(CENTER);
    PFont font = loadFont("HelveticaNeue-Thin-20.vlw");
    textFont(font);
    text(this.text, this.x, this.y+7);
  }
  
  // tells if something is within the button
  public boolean contains(int x, int y) {
    return (x > this.x - (w/2)) && (x < this.x + (w/2)) &&
           (y > this.y - (h/2)) && (y < this.y + (h/2));
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
  
  public void changeToggle() {
    this.toggled = !this.toggled;
  }
  
}