package phil;

public class Logic {

	public static final String A = "<m:ci>a</m:ci>\n";
	public static final String B = "<m:ci>b</m:ci>\n";
	public static final String Y = "<m:ci>y</m:ci>\n";
	public static final String Z = "<m:ci>z</m:ci>\n";

	public static void main(String[] args) {
		// From
		// http://en.wikipedia.org/wiki/Logical_connective#Order_of_precedence
		// permute all of the boolean logic operators
		String[] ops = { "not", "implies", "or", "and", "xor", "eq", "neq", "in" };
		for (String s1 : ops) {
			System.out.println("<section><title>Operations where the root is "+s1+"</title>");
			for (String s2 : ops) {
				for (String s3 : ops) {
					String out = "";
					
					//Don't print duplicate "not" (since it's unary)
					if(ops[0] == s1 && ops[0] != s3)
						continue;

					// Do only left-child
					out += ("<equation><title>"+s1+"( (A "+s2+" B), Z)</title><m:math>");
					out += makeChild(s1, makeChild(s2, A, B), Z);
					out += ("</m:math></equation>");

					// Do only right child
					out += ("<equation><title>"+s1+"(A, (Y "+s3+" Z) )</title><m:math>");
					out += makeChild(s1, A, makeChild(s3, Y, Z));
					out += ("</m:math></equation>");

					// do the full 2-child tree
					if(!"not".equals(s1)) {
						out += ("<equation><title>"+s1+"( (A "+s2+" B), (Y "+s3+" Z) )</title><m:math>");
						out += makeChild(s1, makeChild(s2, A, B), makeChild(s3, Y,
							Z));
						out += ("</m:math></equation>");
					}

					System.out.println(out);
				}
			}
			System.out.println("</section>");
		}
	}

	private static String makeChild(String op, String left, String right) {
		String out = "";
		out += ("<m:apply>");
		out += ("<m:" + op + "/>\n");
		out += left;
		if (!"not".equals(op))
			out += right;
		out += ("</m:apply>\n");
		return out;
	}
}
