class ObjHWCollection extends ArrayList {
	public String toString() {
	StringBuilder aXml = new StringBuilder();
        ObjHW anHWObj;
        aXml.append("<HWList numObject=\""+HWList.size()+"\">");
        for(int i=0; i<HWList.size(); i++) {
          anHWObj = (ObjHW)HWList.get(i);
          anHWObj.xml(aXml);
        }
        aXml.append("</HWList>");
        println(aXml.toString());
	return aXml.toString(); 
}
}
