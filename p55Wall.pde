/*
 * TODO:
 *  1. Z-Buffer
 *  2. selection: 
 *  3. Better XML
 *  4. Sauvegarde
 *  5. Multi-nodes
 *
 * rq: ameliorer interface
 *     utiliser arc de cercle pour faire de la bi-matiere
 *     
 */

import controlP5.*;


ControlP5 controlP5;
public boolean lPressed=false;
public boolean lReleased=false;
ObjHWSet HWSet;
ObjHW selectedObj;
PGraphics imageBuffer, backBuffer;
color CONTOUR_COLOR;

void createInterface(ControlP5 controller) {
  ScrollList l;
  controlP5.Button bt;
  
  controller.addSlider("headRadius",0,255,100,10,10,100,14).setId(0); 
  controller.addSlider("queueRadius",0,255,100,10,30,100,14).setId(1);
  
  controlP5.addButton("addObject",128,10,110,80,20).setId(2);
  
  controller.addSlider("red",0,255,100,10,50,100,14).setId(3);
  controller.addSlider("green",0,255,100,10,70,100,14).setId(4);
  controller.addSlider("blue",0,255,100,10,90,100,14).setId(5);
  
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

void setup() {
  CONTOUR_COLOR = color(0,0,0);
  smooth();
  size(800,400);
  frameRate(20);
  RG.init(this);
  controlP5 = new ControlP5(this);
  createInterface(controlP5);
  imageBuffer = this.g;
  backBuffer = createGraphics(400,800,JAVA2D);   
  HWSet = new ObjHWSet();
  HWSet.add( new ObjHW(controlP5, this.g, backBuffer) );
  stroke(0,0,0);
}

void draw() {
  if (lReleased == false) {
    println("draw");
    background(100);
    backBuffer.background(255);
    HWSet.draw();
    image(backBuffer, 400, 0);
  }
}

void mousePressed() {
  ObjHW anObj;
  lPressed = true;
  lReleased = false;
  println("mousePressedr");
  int i;
  println("HWList size:"+HWSet.HWList.size() );
  for (i =0; i < HWSet.HWList.size(); i++ ) {
    anObj = (ObjHW)HWSet.HWList.get(i);
    if ( anObj.isSelected(mouseX,mouseY) ) {
      println("selected & break");
      selectedObj = anObj;
      anObj.loadParametersUI();
    }
    else {
      anObj.setUnselected();
    }
  }
}

void mouseReleased() {
  ObjHW anObj;
  int i=0;
  println("mouse released");
  while (i < HWSet.HWList.size() ) {
    anObj = (ObjHW)HWSet.HWList.get(i);
    anObj.setUnselected();
    i++;  
  }
  lReleased = true;
  lPressed = false;
}

public void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.controller().id());
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
        HWSet.add( new ObjHW(controlP5, this.g, backBuffer) );
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
        HWSet.toXml();
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

