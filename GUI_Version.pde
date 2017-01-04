// Joseph Wang
// ARTG 2260: Programming Basics
// Final Project GUI Version

PImage map;
ArrayList<Post> posts = new ArrayList();
JSONObject masterJSON;
JSONArray postJList;
ArrayList<Button> buttons = new ArrayList();
State currentState;
TextField userText;
TagWidget tagDisplay;
ArrayList<String> tags = new ArrayList();
// Typography
PFont helNeuLight25;
PFont avenNextUL48;
PFont avenNextReg48;
PFont stxScBold;
PImage logo;
PImage logoWater;
float scroll;
PImage home;
PImage marker;
PImage qa;
ArrayList<IconNav> iconNavs = new ArrayList();
PImage heartOut;
ArrayList<IconButton> iconButtons = new ArrayList();
PImage heartFill;
PImage post1;
PImage postNav;
PImage postTips;
PImage postQA;
PImage postSearch;
ListOfDropdowns dropdowns;
String body1 = "In the search bar users can filter by Instagram tags, by typing in the" + 
               "desired tag which they would like to be shown. Users can view their" + 
               " current searches in the pop up menu on the left hand side of the screen." + 
               " Additionally, the user could just have all recent Instagram posts displayed" + 
               " by pressing the 'Display All' button the right side of the screen. " + 
               "To clear the existing search tags the user can press the 'Clear Tags' button under 'Display All'.";
String body2 = "Current searches can be seen in the pop up window on the left hand side of the " + 
               "screen. When the user has exisiting tags being used for filter criteria, the button" + 
               " will change colors to notify the user. The user can toggle the expanded view of the listing" + 
               " at any time by clicking on the button.";
String body3 = "Tag filters are additive in nature, rather than exclusive. This means that the tags the user" +
                " inputs are the ones which will be displayed on screen. To quickly view all of the recent Instagram" +
                " posts in the area just click on the 'Display All' button on the right side of the screen.";
String body4 = "The user can interact with the PhotoTracker in a variety of ways. First, the user can enter tags " + 
               "to search for and view nearby Instagram posts. Additionally, the user can hover over the points" + 
               " on the screen to pull up more information regarding the post. If the user would like to see the " + 
               " Instagram post, the user can click on the point to link them to the Instagram post on" + 
               " Instagram itself. Keep in mind to be able to view the post the user must either be logged into " + 
               "Instagram and be following the user, or the user's account must be public.";


void loadType() {
  helNeuLight25 = loadFont("HelveticaNeue-Light-25.vlw");
  avenNextUL48 = loadFont("AvenirNext-UltraLight-48.vlw");
  avenNextReg48 = loadFont("AvenirNext-Regular-48.vlw");
  stxScBold = loadFont("STXingkai-SC-Bold-80.vlw");
}

public enum State {
  START, // the start screen, with the instructions and info
  MAIN, // the main screen, with the program actually running
  QUESTION // the question screen to help the user with more info
}

void loadJSON() {
  // something with loadJSONObject to load the initial JSON file
  masterJSON = loadJSONObject("test.json");
  //masterJSON = loadJSONObject("https://api.instagram.com/v1/users/self/media/recent/?access_token=YOUR_ACCESS_TOKEN_HERE");
  // something with loadJSONArray to set the postJList
  //print(masterJSON);
  postJList = masterJSON.getJSONArray("data");
  //println(postJList);
  //println(postJList.size());
  //println(postJList.getJSONObject(0).getJSONObject("caption").getString("text"));
}

void loadPosts() {
  for (int i = 0; i < postJList.size(); i++) {
    JSONObject temp = postJList.getJSONObject(i);
    float lat;
    float lon;
    if (temp.isNull("location")) { // checks to make sure the location isn't null
      lat = 0;
      lon = 0;
    }
    else {
      lat = temp.getJSONObject("location").getFloat("latitude");
      lon = temp.getJSONObject("location").getFloat("longitude");
    }
    int likes = temp.getJSONObject("likes").getInt("count");
    String user = temp.getJSONObject("user").getString("username");
    String imageURL = 
    temp.getJSONObject("images").getJSONObject("thumbnail").getString("url");
    //for (int j = 0; j < temp.
    ArrayList<String> tags = new ArrayList();
    JSONArray tempTag = temp.getJSONArray("tags");
    for (int j = 0; j < tempTag.size(); j++) {
      tags.add(tempTag.getString(j));
    }
    String caption = temp.getJSONObject("caption").getString("text");
    Post toAdd = new Post(lat, lon, likes, user, imageURL, tags, caption);
    toAdd.setLink(temp.getString("link"));
    posts.add(toAdd);
  }
}

void loadButtons() {
  // main tracker buttons
  buttons.add(new Button("Display All", 1280 - Button.w/2 - 10, 100));
  buttons.add(new Button("Clear Tags", 1280 - Button.w/2 - 10, 150));
  
  // icon buttons now
  iconButtons.add(
      new IconButton(425.0, 320 + 205 - this.scroll, 25, 23, this.heartOut, this.heartFill));
  iconButtons.add(
      new IconButton(425.0, 810 + 205 - this.scroll, 25, 23, this.heartOut, this.heartFill));
  iconButtons.add(
      new IconButton(425.0, 1300 + 205 - this.scroll, 25, 23, this.heartOut, this.heartFill));
  iconButtons.add(
      new IconButton(425.0, 1790 + 205 - this.scroll, 25, 23, this.heartOut, this.heartFill));
  iconButtons.add(
      new IconButton(425.0, 2280 + 205 - this.scroll, 25, 23, this.heartOut, this.heartFill));
}

void loadImages() {
  this.map = loadImage("bostonmap2.png");
  this.logo = loadImage("working-logo.png");
  this.logoWater = loadImage("working-logo.png");
  this.home = loadImage("home.png");
  this.marker = loadImage("marker.png");
  this.qa = loadImage("qa.png");
  this.heartOut = loadImage("heart-outline.png");
  this.heartFill = loadImage("heart-fill.png");
  this.post1 = loadImage("post1.png");
  this.postNav = loadImage("post-nav.png");
  this.postTips = loadImage("post-tips.png");
  this.postQA = loadImage("post-qa.png");
  this.postSearch = loadImage("post-search.png");
}

void loadNavs() {
  this.iconNavs.add(new IconNav("Return Home", 1030, 30, 30, 30, this.home)); // id = 0
  this.iconNavs.add(new IconNav("Launch Tracker", 1100, 30, 25, 30, this.marker)); // id = 1
  this.iconNavs.add(new IconNav("Got Questions?", 1170, 30, 30, 30, this.qa)); // id = 2
}

void loadDropdowns() {
  this.dropdowns.add(new Dropdown("What do I search for in the search bar?", this.body1, 300, /*150,*/ 680, 50, 160) );
  this.dropdowns.add(new Dropdown("Where can I see what my current searches are?", this.body2, 300, /*240,*/ 680, 50, 120) ); // add 90 to prev y
  this.dropdowns.add(new Dropdown("Are the tag filters additive or exclusive?", this.body3, 300, /*330,*/ 680, 50, 120) ); // add 90 to prev y
  this.dropdowns.add(new Dropdown("What interactions are there?", this.body4, 300, /*420,*/ 680, 50, 170) ); // add 90 to prev y
}

void setup() {
  size(1280, 700);
  this.loadImages();
  map.resize(1280, 700);
  this.loadJSON();
  this.loadPosts();
  this.loadButtons();
  this.loadType();
  userText = new TextField(width/2 , height - 80, "");
  tagDisplay = new TagWidget(this.tags, 10, 80);
  this.currentState = State.START;
  this.scroll = 0;
  this.loadNavs();
  this.dropdowns = new ListOfDropdowns(150);
  this.loadDropdowns();
}

void draw() {
  switch (currentState) {
    case START:
      this.displayStart();
      break;
    case MAIN:
      this.displayMain();
      break;
    case QUESTION:
      this.displayQuestions();
      break;
  }
}

void displayNavbar() { // displays the navbar at the top of the start screen
  rectMode(CENTER);
  stroke(150, 150, 150, 150);
  strokeWeight(1);
  fill(255, 255, 255, 200);
  rect(width/2 , 30 , 1282, 60);
  stroke(5);
  strokeWeight(1.25);
  line(150, 15, 150, 45);  // 220 before
  noStroke();
  fill(10);
  textFont(this.avenNextReg48);
  textSize(35);
  textAlign(LEFT, CENTER);
  text("PhotoTracker", width/5.3 - 70, 30); // no -70 before
  imageMode(CENTER);
  this.logo.resize(30, 30);
  image(this.logo, 110 , 29); // 180 before
  this.displayIconNavs();
}

void displayIconNavs() {
  for (int i = 0; i < this.iconNavs.size(); i++) {
    this.iconNavs.get(i).hoverState(mouseX, mouseY);
    this.iconNavs.get(i).display();
  }
}

void displayHearts() {
  for (int i = 0; i < this.iconButtons.size(); i++) {
    this.iconButtons.get(i).update(320 + 205 + (i * 490) - this.scroll);
    this.iconButtons.get(i).hoverState(mouseX, mouseY);
    this.iconButtons.get(i).display();
  }
}

void displayContent() { // displays the content depending on the current y position
  textSize(20);
  fill(15);
  textAlign(LEFT);
  //text(scroll + "", 50, 100); // was to check to see if the scrolling worked
  textFont(helNeuLight25);
  
  // ------------------------ First Instagram box of content ------------------------
  int h1 = 320;
  // main card
  rectMode(CENTER);
  fill(255);
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  rect(width/2, h1 - this.scroll, width/2.5 /*512px*/, height/1.5, 5);
  fill(0);
  noStroke();
  // user info
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Admin", 440, h1 - 205 - this.scroll);
  // line dividers
  noFill();
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  line(385, h1 - 180 - this.scroll, 895, h1-180 - this.scroll); // top line
  line(405, h1 + 180 - this.scroll, 875, h1+180 - this.scroll); // bottom line
  
  //fill(255, 200, 200);
  //rect(width/2, h1 - this.scroll, 512, 360);
  image(this.post1, width/2, h1-this.scroll);
  // -----------------------------------------------------------------------------
  
  // ---------------------- Second Instagram box of content ----------------------
  int h2 = 810;
  // main card
  rectMode(CENTER);
  fill(255);
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  rect(width/2, h2 - this.scroll, width/2.5 /*512px*/, height/1.5, 5);
  fill(0);
  noStroke();
  // user info
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Admin", 440, h2 - 205 - this.scroll);
  // line divider
  noFill();
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  line(385, h2 - 180 - this.scroll, 895, h2-180 - this.scroll);
  line(405, h2 + 180 - this.scroll, 875, h2+180 - this.scroll); // bottom line
  // heart - like - icon, may make it clickable
  this.postTips.resize(512, 360);
  image(this.postTips, width/2, h2-this.scroll);
  // -----------------------------------------------------------------------------
  
  // ---------------------- Third Instagram box of content ----------------------
  int h3 = 1300;
  // main card
  rectMode(CENTER);
  fill(255);
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  rect(width/2, h3 - this.scroll, width/2.5 /*512px*/, height/1.5, 5);
  fill(0);
  noStroke();
  // user info
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Admin", 440, h3 - 205 - this.scroll);
  // line divider
  noFill();
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  line(385, h3 - 180 - this.scroll, 895, h3-180 - this.scroll);
  line(405, h3 + 180 - this.scroll, 875, h3+180 - this.scroll); // bottom line
  this.postNav.resize(511, 360);
  image(this.postNav, width/2, h3-this.scroll);
  // -----------------------------------------------------------------------------
  
  // ---------------------- Fourth Instagram box of content ----------------------
  int h4 = 1790;
  // main card
  rectMode(CENTER);
  fill(255);
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  rect(width/2, h4 - this.scroll, width/2.5 /*512px*/, height/1.5, 5);
  fill(0);
  noStroke();
  // user info
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Admin", 440, h4 - 205 - this.scroll);
  // line divider
  noFill();
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  line(385, h4 - 180 - this.scroll, 895, h4-180 - this.scroll);
  line(405, h4 + 180 - this.scroll, 875, h4+180 - this.scroll); // bottom line
  this.postSearch.resize(512, 360);
  image(this.postSearch, width/2, h4 - this.scroll);
  
  // -----------------------------------------------------------------------------
  
  // ---------------------- Fifth Instagram box of content ----------------------
  int h5 = 2280;
  // main card
  rectMode(CENTER);
  fill(255);
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  rect(width/2, h5 - this.scroll, width/2.5 /*512px*/, height/1.5, 5);
  fill(0);
  noStroke();
  // user info
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Admin", 440, h5 - 205 - this.scroll);
  // line divider
  noFill();
  stroke(150, 150, 150, 50);
  strokeWeight(1);
  line(385, h5 - 180 - this.scroll, 895, h5-180 - this.scroll);
  line(405, h5 + 180 - this.scroll, 875, h5+180 - this.scroll); // bottom line
  image(this.postQA, width/2, h5 - this.scroll);
  // -----------------------------------------------------------------------------
  
  this.displayHearts();
}

void displayStart() {
  background(248);
  this.displayContent();
  this.displayNavbar();
}

void displayMain() {
  this.displayMap();
  this.displayUI();
  this.displayBasedOnToggle();
  this.displayLogoWatermark();
}

void displayQuestions() {
  background(248);
  this.dropdowns.display(this.scroll);
  this.displayNavbar();
}

void displayLogoWatermark() { // displays a watermark of the logo on the bottom corner
  logoWater.resize(150, 150);
  imageMode(CENTER);
  tint(255, 100);
  image(this.logoWater, 85, height - 85);
  tint(255, 255); // resets the tint
}

void displayMap() { // draws the map of boston on the background
  imageMode(CENTER);
  image(map, width/2, height - map.height/2);
}

void displayUI() { // draws the UI for the program
  // draws the buttons
  this.displayButtons();
  
  // draws the text field and tagwidget
  this.userText.display();
  this.tagDisplay.hoverState(mouseX, mouseY);
  this.tagDisplay.display();
  
  // draws the navbar
  this.displayNavbar();
}

void displayButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    this.buttons.get(i).display();
  }
}

ArrayList<String> getToggledHashtags() {
  ArrayList<String> ans = new ArrayList();
  for (int i = 0; i < buttons.size(); i++) {
    if (buttons.get(i).getToggled()) {
      ans.add(buttons.get(i).text);
    }
  }
  return ans;
}

void displayBasedOnToggle() {
  ArrayList<String> loToggle = this.getToggledHashtags();
  if (loToggle.contains("Display All")) {
    this.displayAllPosts();
  }
  else {
    this.displayHashtag();
  }
}

void displayAllPosts() {
  for (int i = 0; i < posts.size(); i++) {
    posts.get(i).drawAll();
  }
}

void displayHashtag() {
  for (int i = 0; i < posts.size(); i++) {
    for (int j = 0; j < this.tags.size(); j++) {
      if (this.posts.get(i).tags.contains(this.tags.get(j) )) {
        this.posts.get(i).drawAll();
      }
    }
  }
}

/** ----------------------------- Button stuff -----------------------------**/

// determines if the player is on a button or not
boolean onButton() {
  for (int i = 0; i < this.buttons.size(); i++) {
    if (this.buttons.get(i).contains(mouseX, mouseY)) {
      return true;
    }
  }
  return false;
}

Button getClicked() {
  for (int i = 0; i < this.buttons.size(); i++) {
    if (this.buttons.get(i).contains(mouseX, mouseY)) {
      return this.buttons.get(i);
    }
  }
  throw new IllegalArgumentException("Error: detected a button that isn't there!");
}

// determines if the player is on a button or not
boolean onPost() {
  for (int i = 0; i < this.posts.size(); i++) {
    if (this.posts.get(i).contains(mouseX, mouseY)) {
      return true;
    }
  }
  return false;
}

Post clickedPost() {
  for (int i = 0; i < this.posts.size(); i++) {
    if (this.posts.get(i).contains(mouseX, mouseY)) {
      return this.posts.get(i);
    }
  }
  throw new IllegalArgumentException("Error: detected a post that isn't there!");
}

Button findButton(String text) {
  for (int i = 0; i < buttons.size(); i++) {
    if (this.buttons.get(i).text.equals(text)) {
      return this.buttons.get(i);
    }
  }
  throw new IllegalArgumentException("There is no button for with this text!");
}

// deals with navigation and stuff on the start page
void handleStartNav() {
  for (int i = 0; i < this.iconNavs.size(); i++) {
    if (this.iconNavs.get(i).contains(mouseX, mouseY)) {
      switch (i) {
        case 0:
          this.scroll = 0;
          this.currentState = State.START;
          break;
        case 1:
          this.currentState = State.MAIN;
          break;
        case 2:
          this.scroll = 0;
          this.currentState = State.QUESTION;
          //this.dropdowns.resetToggle();
          break;
      }
    }
  }
}

void handleIconButtons() {
  for (int i = 0; i < this.iconButtons.size(); i++) {
    if (this.iconButtons.get(i).contains(mouseX, mouseY)) {
      this.iconButtons.get(i).changeToggle();
    }
  }
}

void mouseReleased() {
  switch (currentState) {
    case START: 
      this.handleStartNav();
      this.handleIconButtons();
      break;
    case MAIN:
      this.handleStartNav();
      if (this.userText.getActive()) {
        if (!this.userText.contains(mouseX, mouseY)) {
          this.userText.setActive(false);
        }
      }
      if (this.userText.contains(mouseX, mouseY)) {
        this.userText.setActive(true);
      }
      /** ------ Button stuff -------- **/
      if (this.onButton()) {
        if (this.getClicked().text.equals("Clear Tags")) {
          this.tags.clear();
          this.getClicked().changeToggle();
        }
        else if (this.getClicked().text.equals("Display All")) {
          for (int i = 0; i < buttons.size(); i++) {
            if (!this.buttons.get(i).text.equals("Display All")) {
              this.buttons.get(i).toggled = false;
            }
          }
        }
        this.getClicked().changeToggle();
      }
      if (this.tagDisplay.contains(mouseX, mouseY)) {
        this.tagDisplay.changeToggle();
      }
      
      if (this.onPost()) {
        link(this.clickedPost().link);
      }
    break;
  case QUESTION:
    this.handleStartNav(); // ------------------- Don't forget to add dropdown stuff --
    this.dropdowns.handleDropdown();
    break;
  }
}

// in charge of working with the textfield to allow the user to type in tags to search for
void keyTyped() {
  if (this.userText.getActive()) {
    switch (key) {
      case ENTER:
        this.tags.add(this.userText.send() );
        this.userText.clear();
        this.userText.setActive(false);
        /*println(this.tags);*/
        break;
      case BACKSPACE:
        this.userText.back();
        break;
      default:
        this.userText.add(str(key));
    }
  }
}

// deals with handling scrolling of the main page
void mouseWheel(MouseEvent event) {
  if (this.currentState == State.START) {
    if (this.scroll < -5) {
      this.scroll = -5;
    }
    else if (this.scroll > 1900) {
      this.scroll = 1900;
    }
    else {
      this.scroll = this.scroll + (event.getCount() * 2);
    }
  }
  else if (this.currentState == State.QUESTION) {
    int maxScroll = this.dropdowns.returnMaxScroll();
    if (this.scroll < -5) {
      this.scroll = -5;
    }
    else if (this.scroll > maxScroll) {
      this.scroll = maxScroll;
    }
    else {
      this.scroll = this.scroll + (event.getCount() * 2);
    }
  }
}
