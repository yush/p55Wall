import controlP5.*;

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

ControlP5 controlP5;
GUICtrl aGUICtrl;
public boolean lPressed=false;
ObjHWCollection theHWList = new ObjHWCollection();
ObjHW selectedObj;
PGraphics backBuffer;

void setup() {
  smooth();
  size(800,400);
  controlP5 = new ControlP5(this);
  backBuffer = createGraphics(400,400,JAVA2D); 
  aGUICtrl = new GUICtrl(controlP5, this.g, backBuffer);
  aGUICtrl.createInterface(controlP5);
  theHWList.add(new ObjHW(aGUICtrl));
  stroke(0,0,0);
}

void draw() {
  ObjHW anObj;
  int i;
  //HWList.sort();
  aGUICtrl.drawBackground();
  for(i=0; i < theHWList.size(); i++) {
    anObj = (ObjHW)theHWList.get(i);
    anObj.drawObj();
    anObj.drawObjInBuffer();
  }
  //image(backBuffer, 400, 0);
}

void mousePressed() {
  ObjHW anObj;
  lPressed = true;
  int i;
  println("HWList size:"+theHWList.size() );
  for (i =0; i < theHWList.size(); i++ ) {
    anObj = (ObjHW)theHWList.get(i);
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
  while (i < theHWList.size() ) {
    anObj = (ObjHW)theHWList.get(i);
    anObj.setUnselected();
    i++;  
  }
}

public void controlEvent(ControlEvent theEvent) {
  aGUICtrl.dispatchEvent(theEvent);
}
