class IconButton {
  private float x, y;
  private int w, h;
  private PImage image;
  private PImage imageToggled;
  boolean hovered;
  boolean toggled;
  
  public IconButton(float x, float y, int w, int h, PImage image, PImage imageToggled) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.image = image;
    this.imageToggled = imageToggled;
    this.toggled = false;
  }
  
  public void update(float y) {
    this.y = y;
  }
  
  public void display() {
    imageMode(CENTER);
    PImage temp = this.image;
    if (this.toggled) {
      temp = this.imageToggled;
    }
    else if (this.hovered) {
      tint(255, 200, 200, 200);
    }
    else {
      tint(255, 100);
    }
    temp.resize(this.w, this.h);
    image(temp, this.x, this.y);
    noTint();
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
  
  public boolean getToggled() {
    return this.toggled;
  }
  
  public void changeToggle() {
    this.toggled = !this.toggled;
  }
}