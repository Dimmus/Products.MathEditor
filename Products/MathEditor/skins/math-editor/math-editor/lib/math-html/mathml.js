
//The following symbols don't have any padding. You can also use padded="false" directly on the element
var nopadding_array = new Array (' ', '(', ')', '[', ']', '{', '}', '|', '||', '.', '. ', ',', ', ', ';', '; ', ':', "'", '"', '\u22C5', '\\', '/', '!');

function NoPaddingOnOp(cha)
{
	var lenny = nopadding_array.length;
	for (var i = 0; i < lenny; i++)
	{
		if (cha == nopadding_array[i]) {return true;}
	}
	return false;
}

var use_images_for_large_operators = true; // Things generally look better when this is true, but there may be a slight delay whilst images are loaded. If false then fonts are used 

function LargeOperatorCode(cha)
{
	switch(cha)
	{
		case '\u2211': return 'summation.png';
		case '\u222B': return 'integral.png';
		case '\u220F': return 'product.png';
		case '\u2210': return 'coproduct.png';
		case '\u2229': return 'intersection.png';
		case '\u222A': return 'union.png';
		case '\u2294': return 'squareunion.png';
		case '\u22C1': return 'vee.png';
		case '\u22C0': return 'wedge.png';
		case '\u2295': return 'oplus.png';
		case '\u2297': return 'otimes.png';
		case '\u2299': return 'odot.png';
		case '\u228E': return 'unionplus.png';
		case '\u222E': return 'circleintegral.png';
		case '\u222C': return 'doubleintegral.png';
		case '\u222D': return 'tripleintegral.png';

		default: return '';
	}
}

function IsIntegral(cha)
{
	if (cha == '\u222B' || cha == '\u222E' || cha == '\u222C' || cha == '\u222D') {return true;}
	return false;
}

function ParenthesisCode(cha)
{
	switch(cha)
	{
		case '(':      return 'leftparen.png';
		case ')':      return 'rightparen.png';
		
		case '[':      return 'leftbracket.png';
		case ']':      return 'rightbracket.png';
		
		case '{':      return 'leftbrace.png';
		case '}':      return 'rightbrace.png';
		
		case '|':      return 'pipe.png';
		case '\u2223': return 'pipe.png';
		
		case '||':     return 'doublepipe.png';
		case '\u2225': return 'doublepipe.png';
		
		case '\u2229': return 'leftangular.png';
		case '\u27E8': return 'leftangular.png';
		case '\u222A': return 'rightangular.png';
		case '\u27E9': return 'rightangular.png';
		
		case '\u230A': return 'leftfloor.png';
		case '\u230B': return 'rightfloor.png';
		
		case '\u2308': return 'leftceiling.png';
		case '\u2309': return 'rightceiling.png';
		
		case '\u2191': return 'uparrow.png';
		case '\u2193': return 'downarrow.png';
		case '\u2195': return 'updownarrow.png';
		
		case '\u21D1': return 'uparrow2.png';
		case '\u21D3': return 'downarrow2.png';
		case '\u21D5': return 'updownarrow2.png';
		
		default: return '';
	}
}

function StretchyCode(cha)
{
	switch(cha)
	{
		case '\u2190': return 'leftarrow.png';
		case '\u2192': return 'rightarrow.png';
		case '\u2194': return 'leftrightarrow.png';
		case '\uFE37': return 'overbrace.png';
		case '\uFE38': return 'underbrace.png';
		
		case '^':      return 'widehat.png';
		case '\u02C6': return 'widehat.png';
		
		case '-':      return 'bar.png';
		case '_':      return 'bar.png';
		case '\u00AF': return 'bar.png';

		default: return '';
	}
}




var ua = navigator.userAgent.toLowerCase();

var ie = (document.getElementById && document.all); 
var apple = (ua.indexOf('applewebkit') != -1 ? 1 : 0); //This includes Google Chrome
var opera = (ua.indexOf('opera') != -1 ? 1 : 0);
var chrome = (ua.indexOf('chrome') != -1 ? 1 : 0);
var firefox2 = false; if (ua.indexOf('firefox/2') != -1) {firefox2 = true;}

var browser_supports_border_image = true;
if (opera) //we'll bravely assume version 11 will have border image
{
	if (ua.indexOf('version/10') != -1 || ua.indexOf('version/9') != -1 || ua.indexOf('version/8') != -1)
	{
		browser_supports_border_image = false;
	}
}
if (firefox2)
{
	browser_supports_border_image = false;
}
//TODO: Not sure when  safari started supporting border image


if (ie) //TODO: Maybe pigs will fly and IE9 will support Xpath, border image, and (most importantly) using non-HTML tags
{
	alert('The mathematics on this page cannot be displayed using Internet Explorer.\n\nYou should use a standards compliant browser such as Firefox, Safari or Chrome.');
}



/* Some general functions */
function D(id)
{
	return document.getElementById(id);
}
function Trim(str)
{
	return str.replace(/^\s+|\s+$/g,"");
}
function LeftTrim(str)
{
	return str.replace(/^\s+/,"");
}
function RightTrim(str)
{
	return str.replace(/\s+$/,"");
}

function IsUppercase(str)
{
	if (str == str.toUpperCase()) {return true;}
	return false;
}
function IsLowercase(str)
{
	if (str == str.toLowerCase()) {return true;}
	return false;
}

function IsTallLetter(str)
{
	if (IsUppercase(str)) {return true;}
	
	if (str == 'b' || str == 'd' || str == 'f' || str == 'h' || str == 'k' || str == 'l' || str == 't') {return true;}
	
	if (str == '\u03B2' || str == '\u03B4' || str == '\u03B6' || str == '\u03B8' || str == '\u03D1' || str == '\u03BB' || str == '\u03BE' || str == '\u03C6' || str == '\u03C8') {return true;}
	
	return false;
}
function IsLowChar(str)
{
	if (str == 'f' || str == 'g' || str == 'j' || str == 'p' || str == 'q' || str == 'y' || str == '(' || str == ')' || str == '[' || str == ']' || str == '{' || str == '}') {return true;}
	
	return false;
}



/* Some general DOM functions */
function TagName(node)
{
	return node.nodeName.toLowerCase();
}

function RemoveNode(x)
{
	if (!x) {return;}
	if (!x.parentNode) {return;}
	x.parentNode.removeChild(x);
}
function InsertBefore(n1, n2) //put n1 before n2
{
	if (!n1 || !n2) {return;}
	
	try
	{
		n2.parentNode.insertBefore(n1, n2);
	}
	catch(e)
	{
		return;
	}
}
function InsertAfter(n1, n2) //put n2 after n1
{
	if (!n1 || !n2) {return;}
	
	if (n1.nextSibling)
	{
		InsertBefore(n2, n1.nextSibling);
	}
	else
	{
		n1.parentNode.appendChild(n2);
	}
}
function PrependChild(parent, node) 
{
    if (parent.firstChild) 
	{
        parent.insertBefore(node, parent.firstChild);
    } 
	else 
	{
        parent.appendChild(node);
    }
}
function SwapNodes(n1, n2)
{
	n1.parentNode.insertBefore(n2, n1);
}
function ChangeNodeName(node, new_name) //This doesn't copy attributes over
{
	var new_tag = document.createElement(new_name);
	InsertBefore(new_tag, node);

	while (node.firstChild)
	{
		new_tag.appendChild(node.firstChild);
	}
}
function IsFirstChild(node)
{
	if (node == node.parentNode.firstChild) {return true;}
	return false;
}
function IsLastChild(node)
{
	if (node == node.parentNode.lastChild) {return true;}
	return false;
}
function Wrap(node, wrapper)
{
	var wrap_node = document.createElement(wrapper);
	InsertBefore(wrap_node, node);
	wrap_node.appendChild(node);
}



/*------------- FUNCTIONS THAT  TIDY THE MATH  --------------------*/
function CleanWhitespace(ancestor_node) 
{
	var i; var lenny;

	var xPathResult = document.evaluate('//math//text()', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	
	var text_node; var str = ''; var orig_str = str;
	lenny = xPathResult.snapshotLength;
	
	var remove_array = new Array();
		
	for (i = 0; i < lenny; i++) 
	{
		text_node = xPathResult.snapshotItem(i);
		
		str = text_node.data;
		orig_str = str;
		
		str = str.replace(/[\t\n\r ]+/g, " ");

		if (TagName(text_node.parentNode) == 'mtext' || str == ', ' || str == '. ' || str == '; ') 
		{	//preserve leading/trailing space in mtext elements as this makes something like <mtext>if </mtext><mi>x</mi><mo>=</mo><mn>1</mn> look right
			if (str.charAt(0) == " " && !text_node.previousSibling && text_node.parentNode)
			{
				text_node.parentNode.innerHTML = '&#160;' + LeftTrim(str);
			}
			if (str.charAt(str.length - 1) == " " && !text_node.nextSibling && text_node.parentNode)
			{
				text_node.parentNode.innerHTML = RightTrim(str) + '&#160;';
			}	
		}
		else
		{
			if (str.charAt(0) == " " && !text_node.previousSibling) 			{str = LeftTrim(str);}
			if (str.charAt(str.length - 1) == " " && !text_node.nextSibling)    {str = RightTrim(str);}
			
			if (str == '' || str == ' ') {remove_array.push(text_node);}
			else if (str != orig_str)    {text_node.data = str;}
		}
	}
	
	lenny = remove_array.length; 
	if (lenny > 0)
	{
		for (i = 0; i < lenny; i++) 
		{
			RemoveNode(remove_array[i]);
		}
	}
}



function CleanFractions(ancestor_node)
{
	var i;var j; var lenny; var node; var numerator; var num_child; var denominator; var denom_child; var exit = false; var num_name = '';
	var den_name = ''; var got_one = false; var safe = 0;
	var fracs = ancestor_node.getElementsByTagName('mfrac');
	lenny = fracs.length;
	
	for (i = 0; i < lenny; i++) 
	{
		node = fracs[i];
		
		if (node.getAttribute('linethickness') == '0') {continue;}
		numerator = node.childNodes[0];
		denominator = node.childNodes[1];
		
		//If denominator is all small mi's, then reduce the top margin
		den_name = TagName(denominator)
		if (den_name == 'mi')
		{
			if (!IsTallLetter(denominator.innerHTML))
			{
				denominator.style.lineHeight = '70%';
			}
		}
		else if (den_name == 'mrow')
		{
			exit = false;
			denom_child = denominator.firstChild; 
			if (denom_child) 
			{
				for (j = 0; j < 10; j++) 
				{
					if (TagName(denom_child) != 'mi') {exit = true; break;}
					if (IsTallLetter(denom_child.innerHTML)) {exit = true; break;}
					denom_child = denom_child.nextSibling; if (!denom_child) {break;}
				}
				//if we get here, the denominator consists of all small/low letters
				if (!exit) {denominator.style.lineHeight = '70%';}
			}
		}
		

		num_name = TagName(numerator)
		if (num_name == 'mi' || num_name == 'mo')
		{
			if (IsLowChar(numerator.innerHTML)) {numerator.style.paddingBottom = '0.15em';}
		}
		else if (num_name == 'mrow')
		{
			got_one = false; safe = 0;
			num_child = numerator.firstChild; 
			while (num_child && safe < 100)
			{
				num_name = TagName(num_child)
				if (num_name == 'mi' || num_name == 'mo')
				{
					if (IsLowChar(num_child.innerHTML)) {numerator.style.paddingBottom = '0.15em';}
				}
				num_child = num_child.nextSibling; safe++;
			}
		}
	}
}




function SortOutSize(ancestor_node) //fontsize and mathsize attributes
{
	var i; var lenny; var node; var fs = '';
	var xPathResult = document.evaluate('//*[@fontsize] | //*[@mathsize]', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		fs = node.getAttribute('fontsize');
		if (!fs || fs == '') {fs = node.getAttribute('mathsize');}
		
		if (fs && fs != '') {node.style.fontSize = fs;}
	}
}
function SortOutColor(ancestor_node) //fontsize and mathsize attributes
{
	var i; var lenny; var node; var col = '';
	var xPathResult = document.evaluate('//*[@color] | //*[@mathcolor]', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		col = node.getAttribute('color');
		if (!col || col == '') {col = node.getAttribute('mathcolor');}

		if (col && col != '') {node.style.color = col;}
	}
}
function SortOutBackground(ancestor_node)
{
	var i; var lenny; var node; var col = '';
	var xPathResult = document.evaluate('//*[@background]', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		col = node.getAttribute('background');
		if (col && col != '') {node.style.backgroundColor = col;}
	}
}
function SortOutSpace(ancestor_node)
{
	var i; var lenny; var node; var col = ''; var width = ''; var height = ''; var depth = ''; var lspace = ''; var rspace = '';
	var xPathResult = document.evaluate('//mspace | //mpadded', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		width = node.getAttribute('width');   if (width && width != '')   {node.style.width = width;}
		height = node.getAttribute('height'); if (height && height != '') {node.style.paddingTop = height;}   //height and depth don't quite work as specified because
		depth = node.getAttribute('depth');   if (depth && depth != '')   {node.style.paddingBottom = depth;} //our css has a vertical align of middle.
		lspace = node.getAttribute('lspace'); 
		if (lspace && lspace != '') {
			node.style.marginLeft = lspace;
			if (lspace.charAt(0) == '-') {node.style.marginRight = lspace.substring(1);}//This hack is needed to display negated arrows properly (where / symbol used with negative lspace
		}

		rspace = node.getAttribute('rspace'); if (rspace && rspace != '') {node.style.marginRight = rspace;}
	}
}



function SortOutMsubsup(ancestor_node)
{

	var i; var lenny; var wid=0; var node; var str = ''; var rt = 0; var lt = 0;
	var test_node; var tn = ''; var inrow = false; var node2pad;

	var msubsup_array = ancestor_node.getElementsByTagName('msubsup'); lenny = msubsup_array.length;

	for (i = 0; i < lenny; i++) 
	{
		node = msubsup_array[i];
		inrow = false;
		test_node = node.parentNode; node2pad = node;
		if (TagName(test_node) == 'mrow') {test_node = test_node.parentNode; inrow = true; node2pad = node.parentNode}
		tn = TagName(test_node);
		if (tn == 'mfrac' || tn == 'munderover' || tn == 'munder' || tn == 'mover' || tn == 'msqrt' || tn == 'mroot')
		{
			node2pad.style.paddingTop = '0.3em';
			node2pad.style.paddingBottom = '0.4em';
		}

		wid = node.childNodes[1].offsetWidth;		
		wid = -wid;
		if (node.childNodes[2].style) {node.childNodes[2].style.left = wid+'px';}
	}

	var sup_bottom = -1;
	var root_top = -1;
	var root_node; var sup_node;
	var sup_height = -1;

	var msup_array = ancestor_node.getElementsByTagName('msup'); lenny = msup_array.length;
	
	for (i = 0; i < lenny; i++) 
	{
		node = msup_array[i];

		inrow = false;
		test_node = node.parentNode; node2pad = node;
		if (TagName(test_node) == 'mrow') {test_node = test_node.parentNode; inrow = true; node2pad = node.parentNode}
		tn = TagName(test_node);
		if (tn == 'mfrac' || tn == 'munderover' || tn == 'munder' || tn == 'msqrt' || tn == 'mroot')
		{
			node2pad.style.paddingTop = '0.3em';
		}
		
		
		
		if (!node.childNodes[0]) {continue;}
		if (!node.childNodes[1]) {continue;}
		if (!node.childNodes[0].style) {continue;}
		
		//TODO: this is taking up a lot of time considering most of the time it's not relevant (and below is a real hack)
		//would be better to use a special xpath query that looks to whether we have big stuff in the superscript.
		sup_height = node.childNodes[1].offsetHeight;

		if (sup_height > 20)
		{
			node.childNodes[1].style.bottom = '14px';
			node.childNodes[0].style.top = '4px';
			
			if (sup_height > 30) 
			{
				if (apple) {node.childNodes[0].style.top = '9px';}
				else {node.childNodes[0].style.top = '9px';}
			}
		}	
	}

	var msub_array = ancestor_node.getElementsByTagName('msub'); lenny = msub_array.length;
	
	for (i = 0; i < lenny; i++) 
	{
		node = msub_array[i];
		inrow = false;
		test_node = node.parentNode; node2pad = node;
		if (TagName(test_node) == 'mrow') {test_node = test_node.parentNode; inrow = true; node2pad = node.parentNode}
		tn = TagName(test_node);
		if (tn == 'mfrac' || tn == 'munderover' || tn == 'mover')
		{
			node2pad.style.paddingBottom = '0.4em';
		}
		
		
		if (!node.childNodes[0]) {continue;}
		if (!node.childNodes[1]) {continue;}
		if (!node.childNodes[0].style) {continue;}
		
		sup_height = node.childNodes[1].offsetHeight;

		if (sup_height > 20)
		{
			node.childNodes[1].style.top = '14px';
			node.childNodes[0].style.bottom = '4px';
			
			if (sup_height > 30) 
			{
				node.childNodes[0].style.bottom = '9px';
			}
		}	
	}
}

function SortOutHorizontalStretchy(ancestor_node)
{
	var i; var lenny; var par; var par_name = ''; var cha = ''; var stretchy_attr = ''; var wid = -1; var accent = '';
	var max_size = ''; var min_size = '';

	var xPathResult = document.evaluate('//mo', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;	
	
	var node; var str = '';

	var inrow = false;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		cha = Trim(node.innerHTML);

		par = node.parentNode;
		par_name = par.nodeName.toLowerCase();
		inrow = false;
		
		if (par_name == 'mrow')
		{
			inrow = true;
			par = par.parentNode;
			par_name = par.nodeName.toLowerCase();
		}
		
		if (par_name == 'munder' || par_name == 'mover' || par_name == 'munderover')
		{
			var src = StretchyCode(cha);
			if (src == '') {continue;}

			var img = document.createElement('img');
			
			//get the stretchy attribute and check it's not false
			stretchy_attr = node.getAttribute('stretchy');
			if (stretchy_attr == 'false') {continue;}
			// the attribute might be called stretchchar according to some mathml specifications
			stretchy_attr = node.getAttribute('stretchchar');
			if (stretchy_attr == 'false') {continue;}
			//won't stretch if maxsize is 1 either
			max_size = node.getAttribute('maxsize');
			min_size = node.getAttribute('minsize');
			
			if (max_size == '1' || max_size == '1em') {continue;}
			
			
			img.setAttribute('src', 'Stretchy/'+src);
			
			//img.style.width = '100%'; //Setting width to 100% was too big for webkit browsers, so explicity  getting the width of the parent is safer (but less pure)

			wid = 0;
			
			if (node.previousSibling) {wid = node.previousSibling.offsetWidth;}
			else 
			{
				if (inrow) {wid = node.parentNode.parentNode.offsetWidth;}
				else {wid = node.parentNode.offsetWidth;}
			}

			//Compare width to any maxsize or minsize attributes
			if (max_size && max_size != '')
			{
				var max_width = parseInt(max_size) * 16; 
				if (wid > max_width) {wid = max_width;} //TODO: calculate pixels per em. 16 is just a rough guess
			}
			
			if (min_size && min_size != '')
			{
				var min_width = parseInt(min_size) * 16; 
				if (wid < min_width) {wid = min_width;} //TODO: calculate pixels per em. 16 is just a rough guess
			}
			
			if (wid < 26) {continue;} //no point in stretching an image if it isn't that wide
			
			
			if (src == 'overbrace.png') {img.style.marginBottom = '0.08em'; img.style.marginTop = '0.12em'; img.setAttribute('height', 12);}
			else {img.setAttribute('height', 12);}
			
			img.setAttribute('width', wid);
			
			node.appendChild(img);
			RemoveNode(node.firstChild);
		}
	}
}

function SortOutAccents(ancestor_node)
{
	var i; var lenny; var cha = ''; var tag_name = '';
	
	//Firefox stretches some elements by default so we will have to look at the character and the stretchy attribute
	var xPathResult = document.evaluate('//mover[@accent="true"]', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	
	var node; var str = '';
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		//if what's under the accent is a small letter, then give a negative margin to make things look better
		tag_name = TagName(node.firstChild);
		if (tag_name == 'mrow') {cha = node.firstChild.firstChild.innerHTML;}
		else {cha = node.firstChild.innerHTML;}

		if (!IsTallLetter(cha))
		{
			node.firstChild.nextSibling.style.marginBottom = '-0.35em';
		}
		else //accent looks better if we shift it to the right a bit
		{
			node.firstChild.nextSibling.style.marginLeft = '0.2em';
		}
	}
}




function SortOutOps(ancestor_node)
{
	var i; var lenny; var node; var str = ''; var cha = ''; var largeop = ''; var padded_left = false; var padded_right = false;
	var form = ''; var fence = ''; var separator = ''; var lspace = ''; var rspace = '';
	var node2; var exit = false; var ds = ''; var par; var par_name = '';
	var sl; var op_img = ''; var im;

	var mo_s = ancestor_node.getElementsByTagName('mo'); lenny = mo_s.length;

	var large = false;

	for (i = 0; i < lenny; i++) 
	{
		node = mo_s[i];
		
		cha = Trim(node.innerHTML);
		
		if (cha == '-') {node.style.fontFamily = 'Lucida Sans Unicode';}

		if (cha == '*') {node.innerHTML = '&#x2217;';}
		
		large = false;
		largeop = node.getAttribute('largeop');
		if (largeop == 'true') 
		{
			large = true;
			//continue; //may as well leave the css to do the biz. NO!! Apple doesn't adjust the over and underscripts properly if this is the case
		}
		
		sl = node.getAttribute('scriptlevel');
		if (sl && sl != '') {continue;}
		
		if (largeop != 'false' && !large) //certain operators will always be displayed large by default
		{
			//Find default large operators.
			if (cha == '\u2211') 	  {large = true;}	//summation
			else if (cha == '\u222B') {large = true;}	//integral
			else if (cha == '\u220F') {large = true;}	//product
			else if (cha == '\u2210') {large = true;}	//coproduct
			else if (cha == '\u222E') {large = true;}	//circle integral
			else if (cha == '\u222C') {large = true;}	//double integral
			else if (cha == '\u222D') {large = true;}	//triple integral
		}
		
		if (large)
		{
			op_img = '';
			if (use_images_for_large_operators)
			{
				op_img = LargeOperatorCode(cha);
				if (op_img != '') {op_img = 'LargeOperators/'+op_img;}
			}

			par = node.parentNode;
			par_name = par.nodeName.toLowerCase();
			
			if (par_name == 'mrow')
			{
				par = par.parentNode;
				par_name = par.nodeName.toLowerCase();
			}
		
			if (par_name == 'munder' || par_name == 'mover' || par_name == 'munderover')
			{
				par.style.verticalAlign = 'middle';
				par.style.bottom = '0em';
				
				if (op_img != '') {
					if (par_name == 'mover') {if (par.childNodes[1].style) {par.childNodes[1].style.marginBottom = '0em';}}
					else if (par_name == 'munderover') {if (par.childNodes[2].style) {par.childNodes[2].style.marginBottom = '0em';}}
					else if (par_name == 'munder') 
					{
						par.style.top = '0.3em'; 
						par.style.marginBottom = '0.15em'; //this is a hack because multiple subscripts below a large operator don't seem to have enough space
					}
				}
			}
			
			node2 = node; exit = false;
			
			node.style.paddingLeft = '0em';

			if (par_name == 'munder' || par_name == 'mover' || par_name == 'munderover' || par_name == 'msub' || par_name == 'msup' || par_name == 'msubsup' || IsIntegral(cha))
			{node.style.paddingRight = '0.1em';}
			
			do
			{
				ds = node2.getAttribute('displaystyle');
				if (ds == 'true' || node2.getAttribute('display') == 'block')
				{
					if (op_img != '')
					{
						node.innerHTML = '';
						im = document.createElement('img');
						im.setAttribute('src', op_img);

						node.appendChild(im);
						
						node.style.marginTop = '0.1em'; node.style.marginBottom = '0.1em';
						
						if (IsIntegral(cha) && (par_name == 'msub' || par_name == 'msubsup'))
						{
							//second child needs to be moved back to make things look good
							if (par.childNodes[1].style) {par.childNodes[1].style.left = '-0.75em';}
						}
					}
					else
					{
						node.style.fontSize = '180%'; node.style.lineHeight = '114%';
						if (IsIntegral(cha) && (par_name == 'msub' || par_name == 'msubsup'))
						{
							//second child needs to be moved back to make things look good
							if (par.childNodes[1].style) {par.childNodes[1].style.left = '-0.35em';}
						}
					}
					exit = true;
				}
				if (ds == 'false' || node2.nodeName.toLowerCase() == 'math' || node2.nodeName.toLowerCase() == 'body') {exit = true;}
				node2 = node2.parentNode;	
			}while (!exit)
		}

		//Find operators which should be padded
		padded_left = false; padded_right = false;
		form = node.getAttribute('form'); fence = node.getAttribute('fence'); separator = node.getAttribute('separator')
		
		if (fence == 'true' || separator == 'true') // css handles these
		{}
		else if (form == 'infix' || form == 'prefix' || form == 'postfix') // css handles these
		{}
		else if (node.getAttribute('padded') == 'false') // css handles these
		{}
		else if (!large)
		{		
			if (IsFirstChild(node)) {node.style.paddingRight = '0.14em'; node.style.paddingLeft = '0em';}
			else if (IsLastChild(node)) {node.style.paddingRight = '0.14em'; node.style.paddingLeft = '0em';}
			else if (NoPaddingOnOp(cha)) {node.style.paddingRight = '0.14em'; node.style.paddingLeft = '0em';}// node.style.backgroundColor='green'}
		}

		//Of course, if we have lspace or rspace attributes, these will override the above
		lspace = node.getAttribute('lspace');
		rspace = node.getAttribute('rspace');
		
		if (lspace && lspace != '') {node.style.paddingLeft = lspace;}
		if (rspace && rspace != '') {node.style.paddingRight = rspace;}
	}
}



function SortOutFenced(ancestor_node)
{
	var i; var lenny; var node; var str = ''; var open = ''; var close = '';
	
	var xPathResult = document.evaluate('//mfenced', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		open = node.getAttribute('open');
		close = node.getAttribute('close');
		
		if (browser_supports_border_image)
		{
			if (open == '(' && close == ')') {continue;}
			if (open == '[' && close == ']') {continue;}
			if (open == '{' && close == '}') {continue;}
			if (open == '{' && close == '')  {continue;}
			if (open == '' && close == '}')  {continue;}
			if (open == '\u2229' && close == '\u222A') {continue;} //angular
			if (open == '\u27E8' && close == '\u27E9') {continue;} //angular
			if (open == '\u230A' && close == '\u230B') {continue;} //floor
			if (open == '\u2308' && close == '\u2309') {continue;} //ceiling
			if (open == '[' && close == ')') {continue;}
			if (open == '(' && close == ']') {continue;}
		}
		
		// for 'absolute value' or 'norm', we just use border: 1px solid   or   4px double        in the css
		if ((open == '|' || open == '\u2223' || open == '||' || open == '\u2225' || open == '') && (close == '|' || close == '\u2223' || close == '||' || close == '\u2225' || close == ''))
		{
			continue;
		}

		var open_node = document.createElement('mo'); var close_node = document.createElement('mo');
		open_node.innerHTML = open; close_node.innerHTML = close;
		
		//replace <mfrenced open="(" close=")"> ... <mfenced>   by       <mrow><mo>(</mo>..........<mo>)</mo></mrow>
		PrependChild(node, open_node);
		node.appendChild(close_node);
		
		ChangeNodeName(node, 'mrow');
	}
}

function IsBigNode(node)
{
	var tn = TagName(node);
	
	//|| tn == 'msub' || tn == 'msup' || tn == 'msubsup'    (decided things are more likely to work better without these
	if (tn == 'mfrac' || tn == 'munder' || tn == 'mover' || tn == 'munderover' || tn == 'mrow' || tn == 'mtable' || tn == 'mfenced' || tn == 'msqrt' || tn == 'mroot' || tn == 'menclose') {return true;}
	
	return false;

}

function SortOutParens(ancestor_node)
{
	var i; var lenny; var node; var str = ''; var cha = ''; var stretch = false; var stretchy_attr = ''; var src = '';
	var max_size = ''; var min_size = '';
	var ht = 0; var last_ht = 0; var diff = 1000;
	var match = ''; var test_node; var score = 0; var safe = 0; var getout = false;

	var mo_s = ancestor_node.getElementsByTagName('mo'); lenny = mo_s.length;

	var large = false;

	for (i = 0; i < lenny; i++) 
	{
		node = mo_s[i];
		cha = Trim(node.innerHTML);
		
		stretch = false; src = '';
		
		if (node.getAttribute('ignore') == 'true') {continue;}

		match = '';
		
		if (cha == '(') 		{match = ')';}
		else if (cha == '[') 	{match = ']';}
		else if (cha == '{') 	{match = '}';}

		src = ParenthesisCode(cha);
		if (src == '') {continue;}
		
		max_size = node.getAttribute('maxsize');
		min_size = node.getAttribute('minsize');
		stretchy_attr = node.getAttribute('stretchy');
		
		if (node.getAttribute('stretchchar') == 'false') {continue;}
		if (node.getAttribute('fence') == 'false') {continue;}
		
		if (stretchy_attr == 'true') {stretch = true;}
		else if (stretchy_attr == 'false') {stretch = false;}
		else if (src != '' && max_size != '1' && max_size != '1em' && max_size != '1ex') {stretch = true;}
		else {stretch = false;}

		if (stretch)
		{
			if (match != '')
			{
				score = 1; safe = 0; getout = false; test_node = node.nextSibling;
				while (test_node && safe < 50)
				{
					if (IsBigNode(test_node)) {break;}
					if (TagName(test_node) == 'mo')
					{
						if (test_node.innerHTML == cha) {score++;}
						if (test_node.innerHTML == match)
						{
							score--;
							if (score == 0) {getout = true; test_node.setAttribute('ignore', 'true'); break;}
						}
					}
				
					test_node = test_node.nextSibling; safe++;
				}
				
				if (getout) {continue;}
			}
		
			var img = document.createElement('img');
			img.setAttribute('src', 'Parentheses/'+src);

			ht = node.parentNode.offsetHeight;   //This takes a lot of time!
			
			if (src == 'pipe.png') {img.style.width = '1px';}
			else 
			{
				if (ht > 60)
				{
					img.style.width = '0.55em';
				}
				else if (ht > 40)
				{	
					img.style.width = '0.50em';
				}
				else {img.style.width = '0.45em';}
			}

			if (max_size && max_size != '')
			{
				var max_height = parseInt(max_size) * 16; 
				if (ht > max_height) {ht = max_height;} //TODO: calculate pixels per em. 16 is just a rough guess
			}
			
			if (min_size && min_size != '')
			{
				var min_height = parseInt(min_size) * 16; 
				if (ht < min_height) {ht = min_height;} //TODO: calculate pixels per em. 16 is just a rough guess
			}
			
			diff = ht - last_ht;   //Have problems with matching parens being a different size when in msqrt so this is a hack to sort things out 
			if (diff <= 7 && diff >= -7) {ht = last_ht;}
			if (ht <= 22) {continue;} //normal font brackets should look fine in this case
			if (ht <= 30)
			{
				node.style.fontSize = '114%'; continue;
			}

			img.style.height = ht - 3; //Setting the height exactly can shift things a bit unwantedly so subtracting a bit is a hack to get things looking better
			
			node.innerHTML = '';
			node.appendChild(img);
			
			last_ht = ht;
		}
	}
}



function SortOutMI(ancestor_node)
{
	var i; var lenny; var node; var str = ''; var cha = ''; var padded = false; var italic = true; var upright = false;
	var mi_s = ancestor_node.getElementsByTagName('mi'); lenny = mi_s.length;

	for (i = 0; i < lenny; i++) 
	{
		padded = false;
		node = mi_s[i];
		cha = Trim(node.innerHTML);
		if (cha == 'f') {padded = true;}
		
		if (padded) {node.style.paddingLeft = '0.12em'; node.style.paddingRight = '0.24em';}

		upright = false;
		if (cha.length > 1) {upright = true;}
		//if (upright) {node.style.fontStyle = 'normal';}	
		if (upright) {node.style.fontStyle = 'inherit';} //this is more consistent for when theorems are displayed using italics.
	}
}


function AppleTurnover(ancestor_node)
{
	var i; var lenny; var node; var str = '';
	
	var xPathResult = document.evaluate('//mover | //munder | //munderover | //msub | //msup | //msubsup', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;
	
	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		
		if (node.firstChild && TagName(node.firstChild) != 'mrow')
		{
			Wrap(node.firstChild, 'mrow');
		}
		if (node.childNodes[1] && TagName(node.childNodes[1]) != 'mrow')
		{
			Wrap(node.childNodes[1], 'mrow');
		}
		if (node.childNodes[2] && TagName(node.childNodes[2]) != 'mrow')
		{
			Wrap(node.childNodes[2], 'mrow');
		}
	}
}

function AppleFractionHack(ancestor_node)
{
	var i; var lenny; var node; var str = '';
	
	var xPathResult = document.evaluate('//math[@display="block"]//mfrac | //math[@mode="display"]//mfrac', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		node.style.verticalAlign = '-0.15em';
	}
}


function AppleInlineHack(ancestor_node)
{
	var i; var lenny; var node; var str = '';
	
	var xPathResult = document.evaluate('//math', ancestor_node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	lenny = xPathResult.snapshotLength;

	for (i = 0; i < lenny; i++) 
	{
		node = xPathResult.snapshotItem(i);
		if (node.getAttribute('display') != 'block')
		{
			node.style.top = '-0.15em'; //This will need to be tweaked for different font-sizes and line-heights
		}
	}
}


function TidyMath(node)
{

	CleanWhitespace(node);

	if (apple) {AppleInlineHack(node);}
	if (apple) {AppleFractionHack(node);}
	
	CleanFractions(node);
	
	SortOutMI(node);
	
	if (apple) //mover, munder, and munderover stuff sometimes doesn't display properly in webkit if any of the children isn't wrapped in an mrow node
	{		   //ALSO some msub/msup stuff needs wrapping to display properly
		AppleTurnover(node);
	}
	
	SortOutFenced(node);

	SortOutOps(node);

	SortOutSize(node);
	
	SortOutSpace(node);
	
	SortOutParens(node);
	
	SortOutMsubsup(node);
	
	SortOutAccents(node);
	
	SortOutHorizontalStretchy(node);

	SortOutColor(node);
	
	SortOutBackground(node);
	

	if (!browser_supports_border_image) 
	{
		var style = document.createElement('style');
		
		var ih = 'msqrt,mroot>*:first-child{display:inline-block;position:relative;border-top:solid 1px;border-left:solid 1px;z-index:1;margin:1px 0;padding:0px 0px 0 0px;margin-left:8px;}';
		
		ih += 'msqrt:before,mroot>*:first-child:before{display:inline-block;vertical-align: bottom;position:relative;left: -0.3em;top: 0em;content: "\\\\"; line-height:60%; font-size:80%;}';
		
		ih += 'mroot>*+*{left:-0.1em;}';

		style.innerHTML = ih;
		
		//document.body.appendChild(style);
		document.getElementsByTagName('body')[0].appendChild(style);
	}
}


function MathHTML_OnLoad()
{
	var bd = document.getElementsByTagName('body')[0];
	
	TidyMath(bd);

	bd.style.visibility = 'visible';	//in case the visibility has been set to 'hidden' in the css
	
	
}



window.onload = MathHTML_OnLoad; // If you have other window.onload functionality on your page, just comment this line out and make the call to MathHTML_OnLoad() when you are ready