
class GUICtrl {
  public ControlP5 ctrlControlP5;
  public PGraphics screenBuf;
  public PGraphics backBuf;
  
  GUICtrl(ControlP5 aControler, PGraphics aBuffer, PGraphics aBackBuffer) {
    ctrlControlP5 = aControler;
    screenBuf = aBuffer;
    backBuf = aBackBuffer;
  }
  
  public ControlP5 ctrlControlP5() {
    return ctrlControlP5; 
  }
  
  void createInterface(ControlP5 ctrlControlP5) {
    ScrollList l;
    controlP5.Button bt;
    
    ctrlControlP5.addSlider("size",0,255,100,10,270,100,14).setId(8);
    
    controlP5.addButton("addObject",128,10,110,80,20).setId(2);
    
    ctrlControlP5.addSlider("red",0,255,100,10,50,100,14).setId(3);
    ctrlControlP5.addSlider("green",0,255,100,10,70,100,14).setId(4);
    ctrlControlP5.addSlider("blue",0,255,100,10,90,100,14).setId(5);
    
    controlP5.addButton("print",128,10,140,80,20).setId(6);
    /*
     * Boutons changement forme
     */
    l = controlP5.addScrollList("headTypeList",10,180,80,100);
    bt = l.addItem("circle",0);
    bt.setId(100);
    bt = l.addItem("triangle",1);
    bt.setId(101);   
    
    /*
     * Boutons Z buffer
     */
     controlP5.addSlider("hwZBuffer",-100,100,0,10,250,80,14).setId(7);
  } 
  
  public void drawBackground() {
    fill(0);
    rect(0,0,200,400);
    fill(100);
    rect(200,0,400,400);
    backBuffer.background(255);  
  }
  
  public void dispatchEvent(ControlEvent theEvent) {
    ObjHW tParent;
    if (theEvent.isController()) {
      switch(theEvent.controller().id()) {
        case(2):
          theHWList.add( new ObjHW(this));
          break;
        case(3):
          int redValue = (int)theEvent.controller().value();
          selectedObj.setObjColor(color(redValue,green(selectedObj.getObjColor()),blue(selectedObj.getObjColor())));
          break;
        case(4):
          int greenValue = (int)theEvent.controller().value();
          selectedObj.setObjColor(color(red(selectedObj.getObjColor()),greenValue,blue(selectedObj.getObjColor())));
          break;
        case(5):
          int blueValue = (int)theEvent.controller().value();
          selectedObj.setObjColor(color(red(selectedObj.getObjColor()),green(selectedObj.getObjColor()),blueValue));
          break;
        case(6):
          theHWList.toString();
  	break;
  /*
        case(7):
          selectedObj.queue.center.z = theEvent.controller().value();
          break;
          */
        case(8):
          selectedObj.setObjSize((int)theEvent.controller().value());
          break;
        case(100):
          tParent = selectedObj.parent;
          tParent.head = new ObjArrow(selectedObj);
          break;
        case(101):
          tParent = selectedObj.parent;
          tParent.head = new ObjCir(selectedObj);
          break;
      }
    }
  }
  
}

