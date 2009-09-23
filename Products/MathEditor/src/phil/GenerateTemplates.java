package phil;

public class GenerateTemplates extends MathmMaker {

	static int indent = 0;

	public static void main(String[] argsUnused) throws Exception {
		loadOps();
		PRINT_TABLE = false;

		// for each op, print a tempalte
		for (Op op : ops) {
			indent = 0;
			String args = "";
			args += " type='" + op.returnType + "'";
			//args += " constructor='" + op.isConstructor + "'";
			//args += " expands='" + (op.arity == 4) + "'";
			 
			println(indent++, "<mmled:template id='template-" + op.name + "'" + args + ">");
			if (!op.isConstructor) {
				println(indent++, "<apply>");
				println(indent, "<" + op.name + "/>");
			} else {
				println(indent++, "<" + op.name + ">");
			}

			String[] argTypes = op.getArgTypes();
			for(String argType : argTypes) {
				printStuff(argType);
			}

			if (!op.isConstructor) {
				println(--indent, "</apply>");
			} else {
				println(--indent, "</" + op.name + ">");
			}
			println(--indent, "</mmled:template>");

			// sanity check
			if (indent != 0) {
				throw new RuntimeException();
			}
		}
	}

	static void println(int depth, String s) {
		MathmMaker.println(MathmMaker.MAX_DEPTH - depth, s);
	}
	
	static void printStuff(String type) {
		if ("bvar".equals(type)) {
			println(indent++, "<bvar>");
			println(indent, "<mmled:block type='id'/>");
			println(--indent, "</bvar>");
		} else {
			if(type.endsWith("*")) {
				type = type.substring(0, type.length() - 1);
				println(indent, "<mmled:block type='" + type + "' extra='expandable'/>");
			} else if(type.endsWith("+")) {
				type = type.substring(0, type.length() - 1);
				println(indent, "<mmled:block type='" + type + "' extra='optional'/>");
			} else {
				println(indent, "<mmled:block type='" + type + "'/>");
			}
		}
	}
}
