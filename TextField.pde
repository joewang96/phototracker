class TextField {
  private boolean active; // tells if the user is currently selecting the text field
  private boolean hovered; // tells if the player is hovering over it
  private String current; // the current text that is in the box
  private int x, y; // the location of the text field
  
  static final int w = 300; // the width of the text field
  static final int h = 30;  // the height of the text field
  static final int textSize = 20;  // the size of the font to use
  
  public TextField(int x, int y, String current) {
    this.x = x;
    this.y = y;
    this.current = current;
    this.active = false;
    this.hovered = false;
  }
  
  public void display() {
    this.hoverState(mouseX, mouseY);
    rectMode(CENTER);
    noStroke();
    if (this.active) {
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
    textSize(textSize);
    textAlign(LEFT, CENTER);
    PFont font = loadFont("HelveticaNeue-Thin-20.vlw");
    textFont(font);
    String temp = this.current;
    
    if (!this.active && (this.current.equals("")) ) {
      text("Search tags here", (this.x - w/2) + 20, this.y);
    }
    
    if (textWidth(this.current) < (w - 40) ) {
      text(this.current, (this.x - w/2) + 20, this.y);
    }
    else {
      float len = textWidth(temp);
      while (len > (w - 40)) {
        temp = temp.substring(1, temp.length() );
        len = textWidth(temp);
      }
      text(temp, (this.x - w/2) + 20, this.y);
    }
    
    // The cursor for the text field
    if (this.active) {
      stroke(255, 255, 255);
      strokeWeight(1);
      float xLoc = (this.x - w/2) + 20 + textWidth(temp);
      line(xLoc, y - h/2 + 5, xLoc, y + h/2 - 5);
    }
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
  
  public boolean getActive() {
    return this.active;
  }
  
  public void setActive(boolean act) {
    this.active = act;
  }
  
  public String send() {
    return this.current;
  }
  
  public void clear() {
    this.current = "";
  }
  
  public void back() {
    if (this.current.length() > 0) {
      this.current = this.current.substring(0, this.current.length() - 1);
    }
  }
  
  public void add(String text) {
    this.current = this.current + text;
  }
  
}