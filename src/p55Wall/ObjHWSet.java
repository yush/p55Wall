package p55Wall;

class ObjHWSet {

	  public LinkedList theList;
	  public ArrayList HWList;
	  
	  ObjHWSet() {
	    theList = new LinkedList();
	    HWList = new ArrayList();
	  }
	  
	  public void add(ObjHW anObj) {
	    if (HWList.add(anObj) != true) {
	      println("erreur lors de l'ajout");
	    }
	    println(anObj.head.compareTo(anObj.queue));
	    anObj.aLink.center.z = 1;
	   
	    theList.add(anObj.head);
	    theList.add(anObj.queue);
	    theList.add(anObj.aLink); 

	  }
	  
	  //dessiner tous les sous-objet pour recomposer ObjHW
	  public void draw() {
	    ObjTemplate anObj;
	    ObjHW anObjHW;
	    int i;
	    Iterator it = theList.iterator();
	    println("Details du Set:"+theList.size()); 
	    while (it.hasNext()) { // Get element 
	      anObj = (ObjTemplate)it.next();
	      anObjHW = anObj.parent;
	      println("obj:"+anObj);
	      println("objParent:"+anObjHW);
	      anObj.render();
	      //anObj.toXml();
	    }
	    
	  }
	  
	  public void toXml() {
	    StringBuilder aXml = new StringBuilder();
	    ObjHW anHWObj;
	    aXml.append("<HWList numObject=\""+HWSet.HWList.size()+"\">");
	    for(int i=0; i<HWSet.HWList.size(); i++) {
	      anHWObj = (ObjHW)HWSet.HWList.get(i);
	      anHWObj.xml(aXml);
	    }
	    aXml.append("</HWList>");
	    println(aXml.toString());  
	  }
	 */ 
	}