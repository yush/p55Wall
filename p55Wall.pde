import controlP5.*;

ControlP5 controlP5;
public boolean lPressed=false;
ArrayList HWList = new ArrayList();
ObjHW selectedObj;
PGraphics backBuffer;

void createInterface(ControlP5 controller) {
  controller.addSlider("headRadius",0,255,100,10,10,100,14).setId(0); 
  controller.addSlider("queueRadius",0,255,100,10,30,100,14).setId(1);
  controlP5.addButton("addObject",128,10,110,80,20).setId(2);
  
  controller.addSlider("red",0,255,100,10,50,100,14).setId(3);
  controller.addSlider("green",0,255,100,10,70,100,14).setId(4);
  controller.addSlider("blue",0,255,100,10,90,100,14).setId(5);
  
  controlP5.addButton("print",128,10,130,80,20).setId(6);
}


void setup() {
  smooth();
  size(800,400);
  controlP5 = new ControlP5(this);
  createInterface(controlP5);
  backBuffer = createGraphics(400,400,JAVA2D); 
  HWList.add( new ObjHW(controlP5, this.g, backBuffer) );
  stroke(0,0,0);
}

void draw() {
  ObjHW anObj;
  int i;
  background(100);
  backBuffer.background(255);
  for(i=0; i < HWList.size(); i++) {
    anObj = (ObjHW)HWList.get(i);
    anObj.drawObj();
    anObj.drawObjInBuffer();
  }
  image(backBuffer, 400, 0);
}

void mousePressed() {
  ObjHW anObj;
  lPressed = true;
  println("mousePressedr");
  int i;
  println("HWList size:"+HWList.size() );
  for (i =0; i < HWList.size(); i++ ) {
    anObj = (ObjHW)HWList.get(i);
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
  lPressed = false;
  while (i < HWList.size() ) {
    anObj = (ObjHW)HWList.get(i);
    anObj.setUnselected();
    i++;  
  }
}

public void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.controller().id());
  switch(theEvent.controller().id()) {
    case(0):
      if (selectedObj != null) {
        selectedObj.head.radius = theEvent.controller().value();
      }
      break;  
    case(1):
      if (selectedObj != null) {
        selectedObj.queue.radius = theEvent.controller().value();
      }
      break;  
    case(2):
      println("add HWObj");
      HWList.add( new ObjHW(controlP5, this.g, backBuffer) );
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
      StringBuilder aXml = new StringBuilder();
      ObjHW anHWObj;
      aXml.append("<HWList numObject=\""+HWList.size()+"\">");
      for(int i=0; i<HWList.size(); i++) {
        anHWObj = (ObjHW)HWList.get(i);
        anHWObj.xml(aXml);
      }
      aXml.append("</HWList>");
      println(aXml.toString());
      break;
  }
}

