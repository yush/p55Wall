class ObjHWCollection extends ArrayList {
  
  public GUICtrl tController;
  
  ObjHWCollection(GUICtrl aGUICtrl) {
    tController = aGUICtrl;
  }
  
  public String toXml() {
    StringBuilder aXml = new StringBuilder();
    ObjHW anHWObj;
    aXml.append("<HWList numObject=\""+theHWList.size()+"\">");
    for(int i=0; i<theHWList.size(); i++) {
      anHWObj = (ObjHW)theHWList.get(i);
      anHWObj.xml(aXml);
    }
    aXml.append("</HWList>");
    println(aXml.toString());
    return aXml.toString(); 
  }
  
  public ObjTemplate getSelectedObject(int x, int y) {
    ObjTemplate anObj;
    int i;
    drawObjInBuffer();
    res = tController.backBuf.get(x,y);
    for (i =0; i < theHWList.size(); i++ ) {
      aHWObj = (ObjHW)theHWList.get(i);
      println("==HWobj "+i);
      if ( anObj.isSelected(mouseX,mouseY) != null ) {
        selectedObj = aHWObj.theSelectedObj;     
        selectedObj.loadParametersUI();
        return aObjHW;
      }
      else {
        aHWObj.setUnselected();
        return null;
      }
    }
  }
  
  public void drawObjInBuffer() {
    for (i =0; i < theHWList.size(); i++ ) {
      aHWObj = (ObjHW)theHWList.get(i);
      aHWObj.drawObjInBuffer();
    }        
  }

}
