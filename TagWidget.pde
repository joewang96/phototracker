class TagWidget {
  ArrayList<String> tags;
  private int x, y, w, h, iconW, iconH;
  private boolean toggled, hovered;
  private final PImage icon = loadImage("list.png");
  
  public TagWidget(ArrayList<String> tags, int x, int y) {
    this.tags = tags;
    this.x = x;
    this.y = y;
    this.w = 50;
    this.h = 50;
    this.iconW = 30;
    this.iconH = 30;
  }
  
  // draws the actual button (text and the button itself)
  protected void display() {
    if (this.toggled) {
      this.displayActive();
    }
    else {
      this.displayInactive();
    }
  }
  
  private void displayInactive() {
    rectMode(CORNER);
    fill(100, 100, 100, 150);
    noStroke();
    if (this.hovered) {
      //strokeWeight(3);
      //stroke(255, 150, 150, 240);
      fill(100, 100, 100, 240);
    }
    rect(x, y, w, h, 3);
    
    this.displayIcon();
  }
  
  private void displayIcon() {
    noStroke();
    PImage iconTemp = this.icon;
    iconTemp.resize(iconW, iconH);
    if (this.tags.size() > 0 && !this.toggled) {
      iconTemp = loadImage("list2.png");
      iconTemp.resize(iconW, iconH);
    }
    else if (this.toggled) {
      iconTemp = loadImage("arrow.png");
      iconTemp.resize(iconW * 3/4, iconH * 3/4);
    }
    int x2 = this.x + this.w/2;
    int y2 = this.y + this.h/2;
    imageMode(CENTER);
    //iconTemp.resize(iconW, iconH);
    image(iconTemp, x2, y2);
  }
  
  private void displayActive() {
    // overlay
    rectMode(CORNER);
    fill(100, 100, 100, 150);
    noStroke();
    rect(x, y, 300, 600, 12);
    
    this.displayIcon();
    
    // text and current list
    fill(255);
    textAlign(CENTER, CENTER);
    
    textFont(helNeuLight25);
    int y2 = this.y + this.h/2;
    text("Current Tags", 155, y2);
    
    if (this.tags.size() == 0) {
      textAlign(CENTER, CENTER);
      fill(255, 255, 255, 150);
      text("No tags to search for", this.x + 150, this.y + 300);
    }
    else {
      textAlign(LEFT, CENTER);
      //fill(252, 95, 95);
      fill(255);
      for (int i = 0; i < this.tags.size(); i++) {
        String temp = this.tags.get(i);
        if (textWidth(this.tags.get(i)) > 280) {
          float len = textWidth(temp);
          while (len > (270)) { // shortening to fit on the window
            temp = temp.substring(0, temp.length() - 1 );
            len = textWidth(temp);
          }
          text(temp + "...", 20, 140 + (i * 25));
        }
        else {
          text(this.tags.get(i), 20, 140 + (i * 25)); 
        }
      }
    }
  }
  
  // tells if something is within the button
  public boolean contains(int x, int y) {
    int x2 = this.x + this.w/2;
    int y2 = this.y + this.h/2;
    return (x > x2 - (w/2)) && (x < x2 + (w/2)) &&
           (y > y2 - (h/2)) && (y < y2 + (h/2));
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