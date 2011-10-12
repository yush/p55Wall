class ObjHWCollection extends ArrayList {
  public String toString() {
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
}
