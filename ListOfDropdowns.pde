class ListOfDropdowns {
  private ArrayList<Dropdown> dropArray;
  private int firstY;
  
  // convienence constructor 
  public ListOfDropdowns(int y) {
    this.firstY = y;
    this.dropArray = new ArrayList();
  }
  
  // second constructor
  public ListOfDropdowns(ArrayList<Dropdown> dropArray, int y) {
    this.firstY = y;
    this.dropArray = dropArray;
  }
  
  public void display(float scrollOffset) {
    int upcomingY = 0 - int(scrollOffset);
    int buffer = 40;
    
    for (int i = 0; i < this.dropArray.size(); i++) {
      this.dropArray.get(i).setY(upcomingY + this.firstY);
      this.dropArray.get(i).display();
      
      if (this.dropArray.get(i).toggled) {
        upcomingY = upcomingY + this.dropArray.get(i).hLarge + buffer; // difference
      }
      else {
        upcomingY = upcomingY + this.dropArray.get(i).hSmall + buffer;
      }

    }
  }
  
  public void add(Dropdown d) {
    this.dropArray.add(d);
  }
  
  public Dropdown get(int index) {
    return this.dropArray.get(index);
  }
  
  public void handleDropdown() {
    for (int i = 0; i < this.dropArray.size(); i++) {
      if (this.dropArray.get(i).contains(mouseX, mouseY)) {
        if (this.dropArray.get(i).toggled) { // meaning that it goes from toggled to untoggled
          this.dropArray.get(i).changeToggle(false);
        }
        else {
          this.dropArray.get(i).changeToggle(true);
        }
      }
    }
  }
  
  public int returnMaxScroll() {
    return this.dropArray.get(this.dropArray.size() - 1).y + this.dropArray.get(this.dropArray.size() - 1).h;
  }
  
}