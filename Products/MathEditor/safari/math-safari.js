/* Contains additional hacks for Safari (and jsMath) */

MmlEditor_Input.nearestNodeWithId = function(pNode) {
	var console = firebug.d.console.cmd;
	if(!pNode || "math" == MmlEditor_Util.localName(pNode)/*FF case*/ || "nobr" == MmlEditor_Util.localName(pNode)/*Safari case*/) {
		console.log("Reached the top! BUG!");
		return null;
	}
	assert(pNode, "nearestNode needs a node");
console.log("Clicked on:");
console.dirxml(pNode);
	
	// Safari: Check if it has 2 previous siblings (1 is a spacer)
	if (!pNode.getAttribute(ATTR_ID)) {
		var prev = MmlEditor_Util.xpathNode("preceding-sibling::*[position()=1]", pNode);
		console.log("prev:");
		console.dirxml(prev);
		var prevPrev = prev ? MmlEditor_Util.xpathNode("preceding-sibling::*[position()=1]", prev) : null;
		console.log("prevPrev:");
		console.dirxml(prevPrev);
		if(prevPrev && prevPrev.getAttribute(ATTR_ID)) {
			assert(prev.getAttribute("class") == "spacer", "prev MUST be @class='spacer'");
			assert(prevPrev.getAttribute(ATTR_ID), "prev.prev MUST have an ID. weird");
			console.log("Found prevPrev @id="+prevPrev.getAttribute(ATTR_ID));
			return prevPrev;
		} else if(MmlEditor_Util.xpathNode("../*[1]",pNode).getAttribute(ATTR_ID)) {
			console.log("Found parentParent.[1] @id="+MmlEditor_Util.xpathNode("../*[1]",pNode).getAttribute(ATTR_ID));
			return MmlEditor_Util.xpathNode("../*[1]",pNode);
		} else { 
			console.log("Couldn't do safari check, trying traditional");
		}
	}

	console.log("Printing pNode again:");
	console.dir(pNode);
	return MmlEditor_Input.nearestNodeWithId(pNode.parentNode);
	console.log("Traditional @id=" + pNode.getAttribute(ATTR_ID));
	return pNode;
};
