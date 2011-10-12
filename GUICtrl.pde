
class GUICtrl {
  ControlP5 ctrlControlP5;
  PGraphics tGBuf;
  
  
  GUICtrl(ControlP5 aControler, PGraphics aBuffer) {
    ctrlControlP5 = aControler;
    tGBuf = aBuffer;
  }
  
  public ControlP5 ctrlControlP5() {
    return ctrlControlP5; 
  }
  
  void createInterface(ControlP5 ctrlControlP5) {
    ScrollList l;
    controlP5.Button bt;
    
    ctrlControlP5.addSlider("headRadius",0,255,100,10,10,100,14).setId(0); 
    ctrlControlP5.addSlider("queueRadius",0,255,100,10,30,100,14).setId(1);
    
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
    
    l = controlP5.addScrollList("queueTypeList",10,210,80,100);
    bt = l.addItem("circle",0);
    bt.setId(110);
    bt = l.addItem("triangle",1);
    bt.setId(111);  
    
    /*
     * Boutons Z buffer
     */
     controlP5.addSlider("hwZBuffer",-100,100,0,10,250,80,14).setId(7);
  } 
  
  public void dispatchEvent(ControlEvent theEvent) {
    if (theEvent.isController()) {
      switch(theEvent.controller().id()) {
        case(0):
          if (selectedObj != null) {
            selectedObj.head.setObjSize( (int)theEvent.controller().value());
          }
          break;  
        case(1):
          if (selectedObj != null) {
            selectedObj.queue.setObjSize( (int)theEvent.controller().value());
          }
          break;  
        case(2):
          println("add HWObj");
          HWList.add( new ObjHW(controlP5, tGBuf, backBuffer) );
          break;
        case(3):
          int redValue = (int)theEvent.controller().value();
          selectedObj.objColor = color(redValue,green(selectedObj.objColor),blue(selectedObj.objColor));
          break;
        case(4):
          int greenValue = (int)theEvent.controller().value();
          selectedObj.objColor = color(red(selectedObj.objColor),greenValue,blue(selectedObj.objColor));
          break;
        case(5):
          int blueValue = (int)theEvent.controller().value();
          selectedObj.objColor = color(red(selectedObj.objColor),green(selectedObj.objColor),blueValue);
          break;
        case(6):
          HWList.toString();
  	break;
        case(7):
          selectedObj.queue.center.z = theEvent.controller().value();
          break;
        case(100):
          selectedObj.head = new ObjCir(selectedObj.head);
          break;
        case(101):
          selectedObj.head = new ObjArrow(selectedObj.head);
          break;
        case(110):
          selectedObj.queue = new ObjCir(selectedObj.queue);
          break;
        case(111):
          selectedObj.queue = new ObjArrow(selectedObj.head);
          break;
      }
    }
    if (theEvent.isGroup() ) {
      println("from group");
    }    
  }
  
}
