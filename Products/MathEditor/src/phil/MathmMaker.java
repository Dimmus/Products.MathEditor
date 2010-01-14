package phil;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

public class MathmMaker {
	static final int NUM_MATH_TAGS = 40;
	static final int MAX_DEPTH = 3;
	static final int MIN_CHILD_COUNT = 3;
	static final boolean ALLOW_QUALIFIERS = true;
	static final boolean RENDER_IDS = false;
	static boolean PRINT_TABLE = false;

	static class Op {
		public final String name;
		public final int arity;
		public final String returnType;
		public final String argTypes;
		public final String qualifiable;
		public final boolean isConstructor;

		public Op(String name, int arity, String returnType, String argTypes,
				String qualifiable, boolean isConstructor) {
			this.name = name;
			this.arity = arity;
			this.returnType = returnType;
			this.argTypes = argTypes;
			this.qualifiable = ALLOW_QUALIFIERS ? qualifiable : "none";
			this.isConstructor = isConstructor;
		}

		public boolean isQualifiable() {
			return !("none".equals(qualifiable));
		}

		public String typeOfArg(int argI, int total) {
			if ("piecewise".equals(name)) {
				fail(true);
			}
			if (arity == 1) {
				fail(argI == 0);
				String arg = argTypes;
				fail(byRet.containsKey(arg) || pseudos.contains(arg)
						|| "?".equals(arg) || "token".equals(arg));
				return argTypes;
			} else if (arity == 2) {
				String[] args = argTypes.split("\\|");
				if (args.length == 2) {
					return args[argI];
				}
				// Otherwise, it's a "+" or a "*"
				fail(false);
			} else if (arity == 3) {
				// something's optional
				String[] args = argTypes.split("\\|");
				fail(args.length == 2);
				// either the 1st one is multiple args, or the 2nd one is.
				String arg0 = args[0].substring(0, args[0].length() - 1);
				String arg1 = args[1].substring(0, args[1].length() - 1);
				char last0 = args[0].charAt(args[0].length() - 1);
				char last1 = args[1].charAt(args[1].length() - 1);
				if (last0 == '+') {
					// decide whether to use the optional arg
					if (total == 1 || argI == 1) {
						return args[1];
					}
					return arg0;
				} else if (last1 == '+') {
					// decide whether to use the optional arg
					if (total == 1 || argI == 0) {
						return args[0];
					}
					return arg1;
				} else {
					fail(false);
				}

			} else if (arity == 4) {
				String[] args = argTypes.split("\\|");
				if (args.length == 1) {
					return args[0].substring(0, args[0].length() - 1);
				} else if (args.length == 2) {
					// either the 1st one is multiple args, or the 2nd one is.
					String arg0 = args[0].substring(0, args[0].length() - 1);
					String arg1 = args[1].substring(0, args[1].length() - 1);
					char last0 = args[0].charAt(args[0].length() - 1);
					char last1 = args[1].charAt(args[1].length() - 1);
					if (last0 == '*') {
						// use arg1 only if argI == last
						if (argI < total - 1) {
							return arg0;
						} else if (last1 == '+') {
							// decide whether to use the optional arg
							if (r.nextBoolean()) {
								return arg1;
							}
							return arg0;
						} else {
							// it's not optional, so return arg1
							return args[1];
						}
					} else if (last1 == '*') {
						// use arg0 only if argI == 0
						if (argI > 0) {
							return arg1;
						} else if (last0 == '+') {
							// decide whether to use the optional arg
							if (r.nextBoolean()) {
								return arg0;
							}
							return arg1;
						} else {
							// it's not optional so return arg0
							return args[0];
						}
					} else {
						fail(false);
					}
				}
			}
			return "?";
		}
		
		public String[] getArgTypes() {
			return argTypes.split("\\|");
		}

		public String toString() {
			String[] args;
			if (arity > 1 && argTypes.contains("|")) {
				args = argTypes.split("\\|");
			} else {
				args = new String[] { argTypes };
			}
			String argszz = "[";
			for (int i = 0; i < args.length; i++) {
				if (i != 0)
					argszz += ", ";
				argszz += "\"" + args[i] + "\"";
			}
			argszz += "]";

			String sp1 = sp(17, name);
			String sp2 = sp(10, returnType);
			String sp3 = sp(24, argszz);
			String sp4 = sp(20, qualifiable);

			return "\"" + name + "\":" + sp1 + "{name:\"" + name + "\"," + sp1
					+ "arity:" + arity + ", returnType:\"" + returnType + "\","
					+ sp2 + "argTypes:" + argszz + "," + sp3 + "qualifiable:\""
					+ qualifiable + "\"," + sp4 + "isConstructor:"
					+ isConstructor + "}";
		}

		String sp(int max, String s) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < max - s.length(); i++) {
				sb.append(' ');
			}
			return sb.toString();
		}
	}

	static Random r = new Random(1);
	static ArrayList<Op> ops = new ArrayList<Op>();
	static final HashMap<String, List<Op>> byRet = new HashMap();

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		loadOps();

		if (PRINT_TABLE) {
			for (Op op : ops) {
				System.out.print(", ");
				System.out.println(op.toString());
			}
		}

		// ops are added. now build some mathml:
		for (int i = 0; i < NUM_MATH_TAGS; i++) {
			println(
					MAX_DEPTH + 1,
					"<p><math id=\"math-"
							+ i
							+ "\" xmlns='http://www.w3.org/1998/Math/MathML'><semantics><mrow/><annotation-xml encoding='Content-MathML'>");
			(new MathmMaker()).buildMath(MAX_DEPTH, "?");
			println(MAX_DEPTH + 1, "</annotation-xml></semantics></math></p>");
		}
	}

	static void loadOps() throws FileNotFoundException, IOException {
		File f = new File("mathml.csv");
		BufferedReader br = new BufferedReader(new FileReader(f));
		String line;
		while ((line = br.readLine()) != null) {
			StringTokenizer st = new StringTokenizer(line, "\",");
			String name = st.nextToken();
			int arity = Integer.parseInt(st.nextToken());
			String returnType = st.nextToken();
			String argTypes = st.nextToken();
			String qualifiable = st.nextToken();
			boolean isConstructor = st.hasMoreTokens();

			Op op = new Op(name, arity, returnType, argTypes, qualifiable,
					isConstructor);
			ops.add(op);
			putIn(op);
		}
	}

	static void putIn(Op op) {
		final List<Op> l;
		String key = op.returnType;
		if (byRet.containsKey(key)) {
			l = byRet.get(key);
		} else {
			l = new ArrayList<Op>();
			byRet.put(key, l);
		}
		l.add(op);
	}

	static void fail(boolean exp) {
		if (!exp)
			throw new RuntimeException();
	}

	void buildMath(int depth, String retType) {
		List<Op> myOps = ops;
		HashMap<String, List<Op>> myMap = byRet;
		if (pseudos.contains(retType)) {
			println(depth, pseudo(retType));
			return;
		}
		if (depth <= 0 && notInMidConstruct(retType)) {
			char c = 'a';// (char) (((int) 'a') + r.nextInt(25));
			println(depth, "<ci" + nextId("ci") + ">" + c + "</ci>");
			return;
		}
		final List<Op> opChoices;
		if ("?".equals(retType)) {
			// build up all the ops
			opChoices = ops;
		} else {
			opChoices = byRet.get(retType);
		}
		fail(opChoices != null);
		Op op = opChoices.get(r.nextInt(opChoices.size()));

		if (op.isConstructor) {
			println(depth, "<" + op.name + nextId(op.name) + ">");
		} else {
			println(depth, "<apply" + nextId("apply") + ">");
			println(depth - 1, "<" + op.name + nextId(op.name) + "/>");
		}

		// if it's qualifiable, randomly add it
		if (op.isQualifiable() && r.nextBoolean()) {
			String qual = op.qualifiable;
			// What type of qualifiable is it?
			// domainofapplication (condition, interval, or lowlimit/uplimit)
			// domainofapplication2 (just missing the bvar)
			// degree
			// logbase
			if ("domainofapplication".equals(qual)
					|| "condition|lowlimit".equals(qual)) {
				boolean condition = r.nextBoolean();
				buildMath(depth - 1, "bvar");
				if (condition) {
					println(depth - 1, "<condition" + nextId("condition") + ">");
					buildMath(depth - 1, "bool");
					println(depth - 1, "</condition>");
				} else {
					buildMath(depth - 1, "lowlimit");
					if (!("condition|lowlimit").equals(qual)) {
						println(depth - 1, "<uplimit" + nextId("uplimit") + ">");
						buildMath(depth - 1, "number");
						println(depth - 1, "</uplimit>");
					}
				}
			} else if ("domainofapplication2".equals(qual)) {
				int condition = r.nextInt(2);
				// buildMath(depth-1, "bvar");
				if (condition == 0) {
					println(depth - 1, "<condition" + nextId("condition") + ">");
					buildMath(depth - 1, "bool");
					println(depth - 1, "</condition>");
				} else if (condition == 1) {
					buildMath(depth - 1, "lowlimit");
					println(depth - 1, "<uplimit" + nextId("uplimit") + ">");
					buildMath(depth - 1, "number");
					println(depth - 1, "</uplimit>");
				} else {
					println(depth - 1, "<interval" + nextId("interval") + ">");
					buildMath(0, "?");
					buildMath(0, "?");
					println(depth - 1, "</interval>");
				}
			} else if ("degree".equals(qual)) {
				println(depth - 1, "<degree" + nextId("degree") + ">");
				buildMath(0, "?");
				println(depth - 1, "</degree>");
			} else if ("logbase".equals(qual)) {
				println(depth - 1, "<logbase" + nextId("logbase") + ">");
				buildMath(0, "?");
				println(depth - 1, "</logbase>");
			} else {
				fail(false);
			}
		}

		// now, recurse on the number of arguments, and make sure we return the
		// correct return type
		if (op.arity == 1) {
			if ("cn".equals(op.name)) {
				println(depth - 1, String.valueOf(r.nextInt(10)));
			} else if ("ci".equals(op.name)) {
				char c = 'a';// (char) (((int) 'a') + r.nextInt(25));
				println(depth - 1, String.valueOf(c));
			} else {
				buildMath(depth - 1, op.typeOfArg(0, 1));
			}
		} else if (op.arity == 2) {
			String arg1 = op.typeOfArg(0, 2);
			String arg2 = op.typeOfArg(1, 2);
			buildMath(depth - 1, arg1);
			buildMath(depth - 1, arg2);
		} else if (op.arity == 3) {
			// decide if it will have 1 or 2 args
			int argsNum = 2;// r.nextInt(1) + 1;
			for (int i = 0; i < argsNum; i++) {
				String arg = op.typeOfArg(i, argsNum);
				buildMath(depth - 1, arg);
			}
		} else if (op.arity == 4) {
			// decide how many arguments to pass (at least 1)
			int argsNum = r.nextInt(2) + MIN_CHILD_COUNT;
			for (int i = 0; i < argsNum; i++) {
				String arg = op.typeOfArg(i, argsNum);
				buildMath(depth - 1, arg);
			}
		} else {
			fail(true);
		}
		if (op.isConstructor) {
			println(depth, "</" + op.name + ">");
		} else {
			println(depth, "</apply>");
		}
	}

	static void println(int depth, String s) {
		if (PRINT_TABLE)
			return;
		for (int i = 0; i < (MAX_DEPTH + 1 - depth); i++) {
			System.out.print(" ");
		}
		System.out.println(s);
	}

	public static List<String> pseudos = Arrays.asList(new String[] {
			"logbase", "lowlimit", "bvar", "degree" });

	String pseudo(String k) {
		char c = 'a';// (char) (((int) 'a') + r.nextInt(25));
		return "<" + k + nextId(k) + "><ci>" + c + "</ci></" + k + ">";
	}

	public static List<String> inMidType = Arrays.asList(new String[] {
			"piece", "otherwise", "matrixrow" });

	boolean notInMidConstruct(String retType) {
		return !inMidType.contains(retType);
	}

	static int id = 0;

	String nextId(String name) {
		if (RENDER_IDS)
			return " id=\"" + name + "-" + String.valueOf(id++) + "\"";
		else
			return "";
	}
}
