import controlP5.*;

/*
 * TODO:
 * HW ou Obj possede methode qui retourne l'obj selectionne
 *  1. selection: 
 *  2. Multi-nodes
 *  3. Better XML
 *  4. Sauvegarde
 *  1. Z-Buffer 
 *
 * rq: utiliser arc de cercle pour faire de la bi-matiere
 *     
 */

ControlP5 controlP5;
GUICtrl aGUICtrl;
public boolean lPressed=false;
ObjHWCollection theHWList;
ObjTemplate selectedObj;
PGraphics backBuffer;

void setup() {
  smooth();
  size(800,400);
  controlP5 = new ControlP5(this);
  backBuffer = createGraphics(400,400,JAVA2D); 
  aGUICtrl = new GUICtrl(controlP5, this.g, backBuffer);
  aGUICtrl.createInterface(controlP5);
  theHWList = new ObjHWCollection(aGUICtrl);
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
  }
  image(backBuffer, 600, 0);
}

void mousePressed() {
  ObjHW aHWObj;
  lPressed = true;
  int i;
  /*
  selectedObj = theHWList.getSelectedObject();
  if ( selectedObj != null ) {   
    selectedObj.loadParametersUI();
  }
  else {
    println("no selection");
  }
  */
}

void mouseReleased() {
  ObjHW anObj;
  int i=0;
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
