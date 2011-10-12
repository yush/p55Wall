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
ObjHWCollection HWList = new ObjHWCollection();
ObjHW selectedObj;
PGraphics backBuffer;

void setup() {
  smooth();
  size(800,400);
  controlP5 = new ControlP5(this);
  aGUICtrl = new GUICtrl(controlP5, this.g);
  aGUICtrl.createInterface(controlP5);
  backBuffer = createGraphics(400,400,JAVA2D); 
  HWList.add( new ObjHW(aGUICtrl.ctrlControlP5(), this.g, backBuffer) );
  stroke(0,0,0);
}

void draw() {
  ObjHW anObj;
  int i;
  background(100);
  backBuffer.background(255);
  //HWList.sort();
  for(i=0; i < HWList.size(); i++) {
    anObj = (ObjHW)HWList.get(i);
    anObj.drawObj();
    anObj.drawObjInBuffer();
  }
  //image(backBuffer, 400, 0);
}

void mousePressed() {
  ObjHW anObj;
  lPressed = true;
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
  aGUICtrl.dispatchEvent(theEvent);
}

