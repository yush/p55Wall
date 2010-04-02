class ObjHW {
  //TODO: z buffer
  ControlP5 aController;
  PGraphics ptrScreen;
  private PGraphics _backBuffer;  //backbuffer a remonter dans objet controlleur (a creer?)
  private int selectionWeight= 2;
  private int contourWeight= 10;
  
  public boolean selected;
  public ObjCir head;
  public ObjArrow arrow;
  public ObjCir queue;
  public ObjLink aLink;
  public color objColor;
 
  ObjHW( ControlP5 tController, PGraphics aScreen, PGraphics aBackBuffer) {
    ptrScreen = aScreen;
    _backBuffer = aBackBuffer;
    aController = tController;
    arrow = new ObjArrow(200,200,200,250,40,aController);
    head = new ObjCir(200,200,50, aController);
    queue = new ObjCir(200,250,20, aController);
    aLink = new ObjLink(200,200,200,250,10);
    objColor = color(255,220,0);
  }
  
  /*
  * Private
  */
  private void _drawObj(PGraphics aBuffer, int contourWeight, int typeBuffer) {
    if (head.selected) {
      head.x = mouseX;
      head.y = mouseY;
      aLink.psrc1.x = mouseX;
      aLink.psrc1.y = mouseY;
      aLink.processed = false;
      arrow.p1.x = mouseX;
      arrow.p1.y = mouseY;      
      arrow.selected = false;
    }
    if (queue.selected) {
      queue.x = mouseX;
      queue.y = mouseY;
      aLink.psrc2.x = mouseX;
      aLink.psrc2.y = mouseY;
      aLink.processed = false;
    }
    
    if (arrow.selected) {
      arrow.p2.x = mouseX;
      arrow.p2.y = mouseY;
      aLink.psrc2.x = mouseX;
      aLink.psrc2.y = mouseY;
      arrow.processed = false;
    }
    aLink.drawIt(aBuffer, contourWeight, typeBuffer);    
    arrow.drawIt(aBuffer, contourWeight, typeBuffer);    
    head.drawIt(aBuffer, contourWeight, typeBuffer);
    //queue.drawIt(aBuffer, contourWeight, typeBuffer);
  } 
  
  private boolean _isSelectedBackBuffer(int x, int y) {
    color res;
    drawObjInBuffer();
    res = _backBuffer.get(x, y);
    //on parcourt la liste des composants
    println("_isSelectedBackBuffer");
    if ( color(head.id) == res ) {
      head.selected = true;
      println("head selected");
    }
    if ( color(queue.id) == res) {
      queue.selected = true;
      println("queue selected");
    }
    if ( color(arrow.id) == res) {
      arrow.selected = true;
    }
    selected = queue.selected | head.selected | arrow.selected;
    return selected;
  }

  private void _drawSelection(PGraphics aBuffer) {
    if(selected) {
      aBuffer.beginDraw();
      aBuffer.fill(255,0,0);
      _drawObj(aBuffer, contourWeight+selectionWeight, 0); 
      aBuffer.endDraw();
    }   
  }
  
  /*
  * Public
  */
  
  public boolean isSelected(int clickX, int clickY) {
    return _isSelectedBackBuffer(mouseX, mouseY);
  }
  
  public void drawIt(PGraphics aBuffer, color aColor, int typeBuffer) {    
    aBuffer.beginDraw();  
    aBuffer.pushStyle();
    aBuffer.noStroke();
    aBuffer.fill(0);
    _drawObj(aBuffer, contourWeight, typeBuffer);
    aBuffer.fill(aColor);
    _drawObj(aBuffer, 0, typeBuffer);
    aBuffer.popStyle();
    aBuffer.endDraw();
  }
  
  public void drawObj() {
    _drawSelection(ptrScreen);
    drawIt(ptrScreen, objColor, 0);
  }
  
  public void drawObjInBuffer() {
    drawIt(backBuffer, color(255) ,1);
  }
  
  public void setUnselected() {
    head.selected = false;
    queue.selected = false;
    arrow.selected = false;
  }
  
  public void loadParametersUI() {
     aController.controller("headRadius").setValue(head.radius);
     aController.controller("queueRadius").setValue(queue.radius);
     aController.controller("red").setValue(red(objColor));
     aController.controller("green").setValue(green(objColor));
     aController.controller("blue").setValue(blue(objColor));
  }
  
  public void xml(StringBuilder tStrXml) {
     tStrXml.append("<objHW id='test'>");
     head.xml(tStrXml);
     queue.xml(tStrXml);
     tStrXml.append("</objHW>");
  }
  
}
