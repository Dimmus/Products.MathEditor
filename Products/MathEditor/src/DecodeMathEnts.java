import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.xml.transform.Transformer;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class DecodeMathEnts {

	private static final String ENTS_FILE = "xml/originals/ents.txt";
	private static final String FILE = "xml/templates";

	private static class EscapedOutputStream extends OutputStream {

		public final FileOutputStream wrapped;

		public EscapedOutputStream(FileOutputStream wrapped) {
			this.wrapped = wrapped;
		}

		boolean canStart = false;

		public void write(byte b[], int off, int len) throws IOException {
			String s = new String(b,off,len,"UTF-8");
			StringBuilder sb = new StringBuilder(s.length());
			for(char c : s.toCharArray()) {
				if(c > 126) {
					sb.append("&#"+((int) c)+";");
//				} else if(c == '&') {
//					sb.append("&amp;");
//				} else if(c == '<') {
//					sb.append("&lt;");
//				} else if(c == '>') {
//					sb.append("&gt;");
				} else {
					sb.append(c);
				}
			}
			wrapped.write(sb.toString().getBytes("UTF-8"), 0, sb.length());
		}

		@Override
		public void write(int b) throws IOException {
			wrapped.write(b);
		}
		
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		StreamSource s = new StreamSource(new File("make-special-templates.xsl"));
		Transformer t = javax.xml.transform.TransformerFactory.newInstance()
				.newTransformer(s);
		File f = new File("xml/templates.xml");
		f = new File("templates2.xml");
		File outF = new File("templates3.txt");
		t.transform(new StreamSource(f), new StreamResult(new EscapedOutputStream(new FileOutputStream(outF))));

	}

}
