import java.io.*;
import java.lang.*;

class IndexCreator {
	
	public static void main(String[] args){
	
	double[][] selected;
	double[][] normal;
	String filename = args[1];
	String support = args[0];
	String maxapriori;
	int index1=0;
	int index2=0;
	char c;
	int data=0;

	//System.out.println(filename);
	Runtime r = Runtime.getRuntime();
	try{
	  Process proc = r.exec("apriori -tm -s" +support+" "+ filename + " maxapriori");
	  
	  try{
	      proc.waitFor();
	  }catch(InterruptedException e){}

	}catch(IOException e){System.out.println("Execute error");}

	selected = new double[100][500];
	normal = new double[21][200];
	try{
	    StreamTokenizer in = new StreamTokenizer(
				 new FileReader("maxapriori"));
	    
	    in.ordinaryChar(')');

	    data = in.nextToken();

	    while(data != in.TT_EOF) {
		while(true){
		    if(data == in.TT_NUMBER) {
			selected[index2][index1] = in.nval;
			index1++;
		    }
		    else if( data == in.TT_WORD)
			System.out.println(in.sval);
		    else {
			if( in.ttype == 41)
			    break;
		    }

		    data = in.nextToken();
		}

		index2++;
		index1 = 0;
		data = in.nextToken();
	    }

	    index1=0;
	    index2=0;
	    
	    try{
		Process proc = r.exec("apriori -tm -s10 " + filename + " normal");
		
		try{
		    proc.waitFor();
		}catch(InterruptedException e){}
		
	    }catch(IOException e){System.out.println("Execute error");}

	    StreamTokenizer inn = new StreamTokenizer(
				  new FileReader("normal"));
	  
	    data = inn.nextToken();
	    
	    while(data != inn.TT_EOF) {
		while(true){
		    if(data == inn.TT_NUMBER) {
			normal[index2][index1] = inn.nval;
			index1++;
		    }
		    else if( data == inn.TT_WORD)
			System.out.println(inn.sval);
		    else {
			if( inn.ttype == 41)
			    break;
		    }
		    
		    data = inn.nextToken();
		}
		
		index2++;
		index1 = 0;
		data = inn.nextToken();
	    }


	    System.out.println("Suggested Indexes");

	    index1 = 0;
	    index2 = 0;
	    while(selected[index1][index2] != 0) {
		System.out.print( "{ ");
		    while(selected[index1][index2+1] != 0) {
			System.out.print((int) selected[index1][index2]);
			System.out.print(" ");
			index2++;
		    }
		    System.out.println("}");
		    index1++;
		    index2 =0;
	    }

	    /*index1 = 0;
	    index2 = 0;
	    while(normal[index1][index2] != 0) {
		System.out.print( "{ ");
		while(selected[index1][index2+1] != 0) {
		    System.out.print((int) normal[index1][index2]);
		    System.out.print(" ");
		    index2++;
		}
		System.out.println("}");
		index1++;
		index2 =0;
	    }*/
	    
	}catch(IOException e){System.out.println("Error Opening Input");}
	
	}
}
