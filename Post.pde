class Post {
  private float lat, lon;
  private int likes, x, y;
  private String user, imageURL, caption, link;
  ArrayList<String> tags;
  private PImage photo;
  private boolean hovered;
  private int rad;
  
  public Post(float lat, float lon, int likes, String user, String imageURL, 
              ArrayList<String> tags, String caption) {
    this.lat = lat;
    this.lon = lon;
    this.x = this.convertX();
    this.y = this.convertY();
    this.likes = likes;
    this.user = user;
    this.imageURL = imageURL;
    this.tags = tags;
    this.caption = caption;
    this.hovered = false;
    this.handleHover();
    this.setImage();
  }
  
  private int convertX() {
    float x1 = (this.lon - (-71.137215)) * (10512.91528);
    return int(x1);
  }
  
  private int convertY() {
    float y1 = (this.lat - 42.376902) * (-15524.85085);
    return int(y1);
  }
  
  public void drawAll() { // dfaws the point AND the card if hovered
    this.handleHover();
    if (this.hovered) { // draw the hover and card
      this.drawPoint();
      this.drawCard();
    }
    else {
      this.drawPoint();
    }
  }
  
  private void drawPoint() { // draws the specific point
    ellipseMode(CENTER);
    noStroke();
    if (this.hovered) { // draw the normal (point has opacity)
      fill(255, 92, 97);
      ellipse(x, y, rad, rad);
    }
    else { // draw the hovered state (point has NO opacity, it is darker)
      fill(255, 92, 97, 150);
      ellipse(x, y, rad, rad);
    }
  }
  
  public void setImage() { // uses the url to set the photo PImage
  }
  
  private void drawCard() { // draws the "instagram card" above the data point on hover
    int len = 150;
    int midYCard = this.y - len/2 - this.rad;
    rectMode(CENTER);
    noStroke();
    fill(100, 100, 100, 200);
    rect(this.x, midYCard, len, len, 7);
    
    triangle(this.x, this.y - this.rad/2, this.x - rad/2 , this.y - this.rad,
              this.x + rad/2, this.y - this.rad);
    fill(255);
    textAlign(CENTER);
    textFont(loadFont("Helvetica-Light-20.vlw"));
    
    text(this.user, this.x, midYCard - len/2 + 20, len, 30);
    textFont(loadFont("Helvetica-Light-15.vlw"));
    text("Likes: " + str(this.likes), this.x, midYCard - len/6, len, 30);
    textFont(loadFont("Helvetica-Light-10.vlw"));
    text(this.caption, this.x, midYCard + 20, len, len/2);
  }
  
  private boolean contains(int x, int y) {
    return (x > this.x - (this.rad/2)) && (x < this.x + (this.rad/2)) &&
           (y > this.y - (this.rad/2)) && (y < this.y + (this.rad/2));
  }
  
  private void handleHover() {
    if (this.contains(mouseX, mouseY)) {
      this.hovered = true;
      this.rad = 25;
    }
    else {
      this.hovered = false;
      this.rad = 15;
    }
  }
  
  public int getX() {
    return this.x;
  }
  
  public int getY() {
    return this.y;
  }
  
  public void setLink(String link) {
    this.link = link;
  }
  
  public String getLink() {
    return this.link;
  }
}