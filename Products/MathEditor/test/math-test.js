MathUtil.rootPath = "../skins/math-editor/math-editor/";

function testAll() {
	var c = getConsole;

	// TODO: run all the tests with an extra Model listener that walks through
	// (using the cursor the entire Math DOM) makes sure we render everything
	// that we should

	testInput();
	testCursor();
	testTypeChecking();
	testPlus();
	testRemoveChild();
	testRender();
	testParser();
	testInference();

};

function testInput() {
	var c = getConsole;
	c().log("-------------------------------------");
	c().log(" Start Input tests");
	c().log("-------------------------------------");

	var xml;
	var doc;
	var model;
	var cursor;
	var root;
	var ret;

	// Load up the XSLT
	var c2pXslt = MathUtil.getXsl("xsl/c2p-new.xsl");
	// Create a DIV for output
	var textarea = document.getElementById("test-source");

	// Simple blank document
	var editor = new MathEditor(textarea, c2pXslt);
	var logger = {
		notifyModelUpdated : function(mathNode) {
			getConsole().dirxml(MathType.toDom(editor.render.doc, mathNode));
		}
	};
	editor.model.registerListener("logger", logger);

	editor._mathInput._cursor.value = "a^+sum";
	editor._mathInput.handleReturn();
};

function testCursor() {
	var c = getConsole;
	c().log("-------------------------------------");
	c().log(" Start Cursor tests");
	c().log("-------------------------------------");

	var xml;
	var doc;
	var model;
	var cursor;
	var root;
	var ret;

	// Simple blank document
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML' />";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);

	// Load up the XSLT
	var c2pXslt = MathUtil.getXsl("xsl/c2p-new.xsl");
	// Create a DIV for output
	var div = document.getElementById("test-editor");
	new MathRender(model, c2pXslt, div, null, null, doc);
	cursor = new MathPosition(model, model.root.getChildren()[0]);

	root = model.root.getChildren()[0];
	assert(root == cursor.getCurrentNode(),
			"Root should be where the cursor is (not null)");
	assert(cursor.isAfter(), "Should be AFTER the node by default");
	assert(!cursor.isSelected(), "Should also NOT be selected");

	cursor.moveRight();
	assert(root == cursor.getCurrentNode(), "Should STILL be on the same node");
	assert(cursor.isAfter(), "Should STILL be after the node");

	cursor.moveLeft();
	assert(root == cursor.getCurrentNode(), "Should STILL be on the same node");
	assert(!cursor.isAfter(), "Should now be BEFORE the node");

	// Add in an element with bvar's and make sure we skip over them
	var listener = {
		b : false,
		selectFlag : false,
		n : false,
		is : false,
		notifySelectionChanged : function(b) {
			this.b = b;
			this.selectFlag = true;
		},
		notifyCursorMoved : function(n, is) {
			this.n = n;
			this.is = is;
			this.movedFlag = true;
		}
	};
	cursor.registerListener("test-listener", listener);
	root = model.buildMathNode("sum");
	model.root.replaceChildWith(model.root.getChildren()[0], root);

	// We just replaced the cursor. Check to make sure the cursor now points to
	// "sum" and that it fired off listeners
	assert(listener.movedFlag && listener.n == root,
			"Should have moved and set to root.");
	assert(listener.selectFlag, "Should have changed selection.");
	listener.selectFlag = false;
	listener.movedFlag = false;

	// Now replace an ancestor of the cursor (check that notifications fire and
	// that the cursor moves)
	cursor.moveLeft();// now it's after the main block
	cursor.moveLeft();// now it's before the main block
	cursor.moveLeft();// now it's after the condition

	// Now, replace a child/unrelated node and make sure we DON'T fire
	// listeners.

	cursor.moveTo(root, /*isAfter*/false);
	cursor.moveRight();
	assert(cursor.getCurrentNode().isBlock(), "Should NOT select mml:bvar's");
};
function testInference() {
	var c = getConsole;
	c().log("-------------------------------------");
	c().log(" Start Type Inference tests");
	c().log("-------------------------------------");

	var xml;
	var doc;
	var model;
	var root;
	var ret;

	// Simple blank document
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML' />";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	assert(root.getChildren().length == 1, "Should have created 1 child block");
	assert(root.getChildren()[0].isBlock(), "Should have created 1 block");

	// Document with 1 child
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'><pi/></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	assert(root.getChildren().length == 1, "Should have created 1 mml:pi");
	ret = root.getChildren()[0];
	assert("pi" == MathUtil.localName(MathType.toDom(doc, ret)),
			"Should have created 1 mml:pi");
	assert("number" == ret.template.returnType, "Should have created 1 mml:pi");
	assert("any" == root.getTypeOfChild(ret).base, "Should still be 'any'");

	// Test if we can parse when there is extra stuff (2 children of a bvar)
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<bvar><ci>x</ci><condition><true/></condition></bvar></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;

	// Test correct ordering of children when infertypes runs
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><leq/><ci>a</ci><pi/></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	assert("ci" == MathUtil.localName(MathUtil.xpathNode("mml:apply/*[2]",
			MathType.toDom(doc, root))), "a should be less than pi");

	// Test that we correctly infer uplimit/lowlimit
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><int/><bvar><ci>a</ci></bvar><uplimit><ci>B</ci></uplimit><lowlimit><ci>A</ci></lowlimit><pi/></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	assert(
			MathUtil
					.xpathNode(
							"mml:apply[mml:int and mml:lowlimit[mml:ci/text()='A'] and mml:uplimit[mml:ci/text()='B']]",
							MathType.toDom(doc, root)),
			"Should have converted limits to an interval");

	// Check if we can partially match nodes (like integral without a
	// domainofapplication)
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><int/><bvar><ci>a</ci></bvar><pi/></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	// should have 3 children: mml:int, mml:bvar, and mml:pi
	assert(4 == MathUtil.xpathNumber("count(mml:apply/*)", MathType.toDom(doc,
			root)), "Should have 3 nodes");
	assert(MathUtil.xpathNode(
			"mml:apply[mml:int and mml:bvar and mml:interval and mml:pi]",
			MathType.toDom(doc, root)), "Should have 3 nodes");

	// Check that we re-order the qualifiers of mml:apply
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><sum/><pi/><domainofapplication><ci>B</ci></domainofapplication><bvar><ci>VAR1</ci></bvar></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	var apply = root.getChildren()[0];
	assert("domainofapplication" == MathUtil.localName(MathUtil.xpathNode(
			"*[3]", MathType.toDom(doc, apply))),
			"Should have moved domainofapplication up");

	// Check that something with a bvar+ and a number gets correctly assigned
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><forall/><bvar><ci>A</ci></bvar><true/></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	var apply = root.getChildren()[0];
	assert("true" == MathUtil.localName(MathUtil.xpathNode(
			"*[position()=last()]", MathType.toDom(doc, apply))),
			"Should have assigned true to be the last element (not part of bvar+)");

	// Check that something with 2 bvars and a number gets correctly assigned
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><forall/><bvar><ci>A</ci></bvar><condition><false/></condition><true/></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	var apply = root.getChildren()[0];
	assert(1 == MathUtil.xpathNumber("count(mml:condition)", MathType.toDom(
			doc, apply)), "Should NOT have 2 conditions");
	assert("bvar" == MathUtil.localName(MathUtil.xpathNode("*[position()=3]",
			MathType.toDom(doc, apply))),
			"Condition should NOT be part of bvar's");

	// From m12761: Check that mml:min[bvar, expectedvalue] get assigned
	// correctly
	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML'>"
			+ "<apply><min/><bvar><ci>A</ci></bvar><pi/></apply></math>";
	doc = MathUtil.parseFromString(xml);
	model = new Model("test", doc);
	root = model.root;
	var apply = root.getChildren()[0];
	getConsole().log("XML dumped:");
	getConsole().dirxml(MathType.toDom(doc, root));
	assert(!MathUtil.xpathNode("mml:condition", MathType.toDom(doc, apply)),
			"Should NOT add a condition when there is a bvar and number");

	getConsole().log("Done");

}

function testParser() {
	var c = getConsole;
	c().log("-------------------------------------");
	c().log(" Start parsing tests");
	c().log("-------------------------------------");

	xml = "<math xmlns='http://www.w3.org/1998/Math/MathML' />";
	doc = MathUtil.parseFromString(xml);
	var model = new Model("test", doc);
	var parser = new MathParser(model, "TOP_BOTTOM");
	var p = parser.getMathNode();
	assert(!parser.hasError(), "Should have parsed without a problem");
	assert(
			MathUtil
					.xpathNode(
							"mml:msub[mml:mi/text()='TOP' and mml:mi/text()='BOTTOM' and not(mmled:block)]",
							MathType.toDom(doc, p)),
			"Should have created an msub");

	var model = new Model("test", doc);
	var parser = new MathParser(model, "a+(-b_2)");
	assert(!parser.hasError(), "Should have correctly parsed");
	var p = parser.getMathNode();
	assert(MathUtil.xpathNode("mml:plus", MathType.toDom(doc, p)),
			"Should have created a plus");
	assert(MathUtil.xpathNode("mml:ci[text()='a']", MathType.toDom(doc, p)),
			"Should have created a ci");
	assert(MathUtil.xpathNode("mml:apply[mml:minus]", MathType.toDom(doc, p)),
			"Should have found the nested negation");
	assert(MathUtil.xpathNode(
			"mml:apply[mml:minus]/mml:ci[mml:msub/mml:mi[text()='b']]",
			MathType.toDom(doc, p)), "Should have created a ci with msub");
	assert(2 == MathUtil.xpathNumber("count(mml:apply[mml:minus]/*)", MathType
			.toDom(doc, p)), "Should have created a negation");

	// try an incomplete
	parser = new MathParser(model, "+2");
	assert(parser.hasError(),
			"Should have found an error (no context information given)");
	var pi = model.buildMathNode("pi");
	parser = new MathParser(model, "+2", pi, /*holeOnLeft*/true);
	assert(!parser.hasError(), "Should have parsed correctly");

	// TODO this is a painful piece:
	// Depending on the context, this can be a negation, OR a subtraction...
	parser = new MathParser(model, "-3");
	assert(!parser.hasError(), "Should have parsed correctly");
	p = parser.getMathNode();
	assert(1 + 1 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, p)),
			"Should have created a negation");

	parser = new MathParser(model, "-4", pi, /*holeOnLeft*/true);
	assert(!parser.hasError(), "Should have parsed correctly");
	p = parser.getMathNode();
	assert(1 + 2 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, p)),
			"Should have created a subtraction");

};

function testRender() {
	var c = getConsole;
	c().log("-------------------------------------");
	c().log(" Start rendering tests");
	c().log("-------------------------------------");

	// Load up the XSLT
	var c2pXslt = MathUtil.getXsl("xsl/c2p-new.xsl");

	// Create a DIV for output
	var div = document.getElementById("test-editor");

	var xml = "<math xmlns='http://www.w3.org/1998/Math/MathML' />";
	var doc = MathUtil.parseFromString(xml);
	var model = new Model("test", doc);
	var renderer = new MathRender(model, c2pXslt, div, null, null, document);
	var root = model.root;
	var plus = model.buildMathNode("plus");
	var block = root.getChildren()[0];
	root.replaceChildWith(block, plus);
	plus.replaceChildWith(plus.getChildren()[1], model.buildMathNode("sum"));
	plus.replaceChildWith(plus.getChildren()[0], model.buildMathNode("int"));
	plus.replaceChildWith(plus.getChildren()[1], model.buildMathNode("power"));
	plus.replaceChildWith(plus.getChildren()[1], model.buildMathNode("forall"));

};

function testRemoveChild() {
	var c = getConsole;
	c().log("--------------------------------------");
	c().log(" Testing removeChild");
	c().log("--------------------------------------");
	var xml = "<math xmlns='http://www.w3.org/1998/Math/MathML' />";
	var doc = MathUtil.parseFromString(xml);
	var model = new Model("test", doc);
	var root = model.root;
	
	var plus = model.buildMathNode("plus");
	// Check if replacing the root's child works
	c()
			.assert(
					1 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc,
							root)));
	var ret = root.getChildren()[0];
	root.replaceChildWith(ret, plus);
	c()
			.assert(
					1 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc,
							root)));

	var child1 = plus.getChildren()[0];
	c().assert(4 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable
	c().log("Removing the 1st child (should replace it with a block)");
	ret = plus.removeChild(child1);
	c().assert(ret && ret.isBlock(), "Should not have deleted this block");
	c().assert(2 == plus.getChildren().length); // op+2args+expandable
	//Should have unwrapped the plus, so let's check and then re-add a new plus in
	c().assert(!plus.getParent(), "plus should have been unwrapped");
	c().assert(root == ret.getParent(), "Unwrapping plus should land ret under root");
	plus = model.buildMathNode("plus");
	root.replaceChildWith(ret, plus);
	ret = plus.getChildren()[0];
	
	// Add a pi, and try to remove it (check that a block is reinserted)
	c().log("Adding a mml:pi and removing it (make sure a block is inserted");
	var pi = model.buildMathNode("pi");
	plus.replaceChildWith(ret, pi);
	ret = plus.removeChild(pi);
	c().assert(ret && ret.isBlock(), "Should not have deleted this block");
	c().assert(4 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable
	// Add the pi to the end (make sure plus is expanded)
	c().log("Adding the pi to the expandable child (should expand)");
	ret = plus.getChildren()[2];
	plus.replaceChildWith(ret, pi);
	c().assert(5 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable

	// Delete the pi, delete the block that replaced the pi, and try to delete
	// the next block (and fail)
	ret = plus.removeChild(pi);
	assert(ret && ret.isBlock(), "Should have replaced pi with a block");
	c().assert(5 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+3args+expandable

	// try to remove the expandable now that we have a bunch of children
	var exp = plus.getChildren()[3];
	var exp2 = plus.removeChild(exp);
	assert(exp2 == exp, "Should NOT have removed the expandable node");
	c().assert(5 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable

	var ret2 = ret;
	ret = plus.removeChild(ret);
	assert(ret != ret2, "Should have removed it");
	c().assert(4 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable

	//New unwrapping code causes this to fail
	//ret = plus.getChildren()[1];
	//var ret2 = plus.removeChild(ret);
	//assert(ret2 == ret, "Should NOT have removed this block (min invariant)");
	//c().assert(4 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable

	ret = plus.getChildren()[2];
	ret2 = plus.removeChild(ret);
	assert(ret2 == ret, "Should NOT have removed the expandable node");
	c().assert(4 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable

	// test replaceChildWith when child is the expandable and we congeal...
	var plus2 = model.buildMathNode("plus");
	ret = plus.getChildren()[2]; // the expandable
	plus.replaceChildWith(ret, plus2);
	c().assert(6 == MathUtil.xpathNumber("count(*)", MathType.toDom(doc, plus))); // op+2args+expandable
	c().assert(ret == plus.getChildren()[4],
			"Expandable should still be in there");

	c().dirxml(MathType.toDom(doc, model.root));

	c().log("tests done (check for failed assertions)!");

}
function testPlus() {
	var c = getConsole;
	var xml = "<math xmlns='http://www.w3.org/1998/Math/MathML' />";
	var doc = MathUtil.parseFromString(xml);
	var model = new Model("test", doc);
	var plus = model.buildMathNode("plus");

	// Add plus to the tree
	var r = model.root;
	var t = r.getChildren()[0];
	r.replaceChildWith(t, plus);
	getConsole().log("Root DOMNode");

	// Try to add a child
	var pi = model.buildMathNode("pi");
	// var pi2 = model.buildMathNode("pi");
	var blocks = plus.getChildren();
	plus.replaceChildWith(blocks[0], pi);

	var plus2 = model.buildMathNode("plus");
	var plus2block = plus2.getChildren()[0]; // this will be
	// added to plus
	c().log("Adding inner plus (testing operation flattening)");
	var consumed = plus.replaceChildWith(blocks[1], plus2);
	c().assert(consumed,
			"The inner plus'sa args should have been sucked into the parent.");

	c().log("Replacing plus with pi2")
	plus.replaceChildWith(plus2block, pi);

}
function testTypeChecking() {
	var c = getConsole;
	// Check that plus works
	c().assert(
			MathType.accepts(MathEditor_Templates["plus"].args, [ "number",
					"number" ]));

	c().assert(
			MathType.accepts(MathEditor_Templates["plus"].args, [ "number",
					"number", "any" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["plus"].args, [ "any",
					"number", "any" ]));

	// Next one should fail
	c().assert(
			!MathType.accepts(MathEditor_Templates["plus"].args, [ "bvar",
					"number", "any" ]));
	// Next one should fail
	c().assert(
			!MathType.accepts(MathEditor_Templates["minus"].args, [ "number",
					"number", "number" ]));

	// Check optionals at the start, and ones at the back mml:piecewise

	// mml:root has an optional at the beginning
	// mml:piecewise has an optional at the end
	// mml:expectedvalue has 2 optionals

	// mml:root Tests
	c().assert(
			MathType.accepts(MathEditor_Templates["root"].args, [ "degree",
					"number" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["root"].args, [ "number" ]));
	c().assert(
			!MathType.accepts(MathEditor_Templates["root"].args, [ "number",
					"degree" ]));

	// mml:piecewise Tests
	c().assert(!MathType.accepts(MathEditor_Templates["piecewise"].args, []));
	c().assert(
			!MathType.accepts(MathEditor_Templates["piecewise"].args,
					[ "otherwise" ]));
	c().assert(
			!MathType.accepts(MathEditor_Templates["piecewise"].args,
					[ "number" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["piecewise"].args,
					[ "piece" ]));
	c().assert(
			!MathType.accepts(MathEditor_Templates["piecewise"].args, [
					"optional", "piece" ]));
	c().assert(
			!MathType.accepts(MathEditor_Templates["piecewise"].args, [
					"piece", "optional", "optional" ]));

	// mml:expectedvalue Tests
	c().assert(
			!MathType.accepts(MathEditor_Templates["expectedvalue"].args, []));
	c().assert(
			MathType.accepts(MathEditor_Templates["expectedvalue"].args,
					[ "number" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["expectedvalue"].args, [
					"bvar", "number" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["expectedvalue"].args, [
					"condition", "number" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["expectedvalue"].args, [
					"bvar", "condition", "number" ]));
	c().assert(
			!MathType.accepts(MathEditor_Templates["expectedvalue"].args, [
					"condition", "bvar", "number" ]));
	c().assert(
			MathType.accepts(MathEditor_Templates["expectedvalue"].args, [
					"any", "number" ]));

	c().assert(
			MathType.accepts(MathEditor_Templates["int"].args, [ "bvar",
					"domainofapplication", "any" ]));
}