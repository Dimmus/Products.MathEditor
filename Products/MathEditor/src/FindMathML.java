import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import cnx.CacheReader;
import cnx.Module;
import cnx.CacheReader.IModuleVisitor;
import cnx.parse.CourseDownload;

public class FindMathML implements IModuleVisitor {
private static class EscapedOutputStream extends OutputStream {

	public final FileOutputStream wrapped;
	
	public EscapedOutputStream(FileOutputStream wrapped) {
		this.wrapped=wrapped;
	}
	
	boolean canStart = false;
	
	@Override
	public void write(int b) throws IOException {
		switch(b) {
		case '&' : 
			if(canStart)
				wrapped.write("&amp;".getBytes("UTF-8"));
			break;
		case '<' : 
			if(canStart)
				wrapped.write("&lt;".getBytes("UTF-8"));
			break;
		case '>' : 
			if(canStart)
				wrapped.write("&gt;".getBytes("UTF-8"));
			canStart = true;
			break;
		default:
			if(canStart)
				wrapped.write(b);
		}
	}	
}
private static class OmitXmlDeclarationOutputStream extends OutputStream {

	public final FileOutputStream wrapped;
	
	public OmitXmlDeclarationOutputStream(FileOutputStream wrapped) {
		this.wrapped=wrapped;
	}
	
	boolean canStart = false;
	
	@Override
	public void write(int b) throws IOException {
		switch(b) {
		case '>' : 
			if(!canStart) {
				canStart = true;
				//don't fall through
				break;
			}//else fall through
		default:
			if(canStart)
				wrapped.write(b);
		}
	}
	
}
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		FindMathML v = new FindMathML();
		PrintStream out = new PrintStream(v.fos);
		out.println("<root>");
		CacheReader.readModules(v);
		out.println("</root>");
	}

	private File dir = new File("../../Documents/workspace/cs590.cnx/orig-modules");
	static {
		CacheReader.MODULE_DIR = new File("../../Documents/workspace/cs590.cnx/cache-modules");
		CourseDownload.NS_CONTEXT.put("mml",
				"http://www.w3.org/1998/Math/MathML");
	}

	private Transformer t;
	private Transformer t2;
	FileOutputStream fos;
	public FindMathML() throws Exception{
		t = TransformerFactory.newInstance().newTransformer();//new StreamSource(new File("cnx/escape.xslt")));
		t2 = TransformerFactory.newInstance().newTransformer(new StreamSource(new File("xml/preview.xsl")));
		File out = new File("out.xml");
		fos = new FileOutputStream(out);
	}
	
	private int counter=0;
	public void visit(Module m) {
		File f = new File(dir, m.id + ".xml");
		XPath xpath = XPathFactory.newInstance().newXPath();
		xpath.setNamespaceContext(CourseDownload.NS_CONTEXT);
		try {
			XPathExpression allMathX = xpath
					.compile("//mml:math[.//mml:apply[mml:*/mml:*/mml:*/mml:*/mml:*/mml:*/mml:*/mml:*/mml:*/mml:*]]");
			InputSource source = new InputSource(new FileInputStream(f));
			NodeList nodes = (NodeList) allMathX.evaluate(source,
					XPathConstants.NODESET);
						
			if(nodes.getLength() == 0) { return; }
			PrintStream out = new PrintStream(fos);
			out.println("<h2 id='"+m.id+"'>"+m.id+"</h2>");
			out.println("<table style='width:100%;'>");
			for (int i = 0; i < nodes.getLength(); i++) {
				Node n = nodes.item(i);
				//ByteArrayOutputStream bos = new ByteArrayOutputStream();
				//StreamResult r = new StreamResult(new PrintStream(bos));
				StreamResult r1 = new StreamResult(new EscapedOutputStream(fos));
				StreamResult r = new StreamResult(new OmitXmlDeclarationOutputStream(fos));
				out.println("<tr><td><textarea id='editor-"+counter+"'>");
				t.transform(new DOMSource(n), r1);
				//Escape the resulting xml
				//String escaped = bos.toString("UTF-8").replace("&", "&amp;");
				//escaped = escaped.replace("<", "&lt;");
				//escaped = escaped.replace(">", "&gt;");
				//System.out.println(bos.toString("UTF-8"));

				
				out.println("</textarea></td><td><p>");
				//bos = new ByteArrayOutputStream();
				//r = new StreamResult(new PrintStream(bos));
				t2.transform(new DOMSource(n), r);
				//System.out.println(bos.toString("UTF-8"));
				out.println("</p></td></tr>");
				counter++;
				System.err.print("!");
			}
			out.println("</table>");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
