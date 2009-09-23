/*
 * Code that periodically parses text in a textarea and replaces math with MathML
 */
var doc = MathUtil.parseFromString('<root />');
var model = new Model('prefix-', doc);

function startMathInterval(inputBox) {
	inputBox.mathInterval = setInterval(checkForMath.createDelegate(inputBox), 1000);
};

function stopMathInterval(inputBox) {
	clearInterval(inputBox.mathInterval);
	checkForMath(inputBox);//do it one more time just in case
};

function checkForMath() {
	var value = this.value || '';
	var possibleMaths = value.split("$$");
	var len = possibleMaths.length;
	
	for(var i = 0; i < len; i++) {
		//Skip 0th split string (unless the 1st character was a $) and the last.
		if(i==0   && "$" != value.charAt(0)
		|| i==len-1 && "$" != value.charAt(value.length)) {
			continue;
		}

		var mathExpression = possibleMaths[i];
		//If a string starts or ends in a space, ignore it
		if(mathExpression.charAt(0) == " " || mathExpression.charAt(mathExpression.length-1) == " ") {
			continue;
		}
		
		//Try to parse
		var parser = new MathParser(model, mathExpression);
		var parsed = parser.getMathNode();
		if(parsed) {
			var mathml = MathUtil.xmlToString(MathType.toDom(doc, parsed, MathRender.toDomWysiwygFilter /*Used to get rid of the empty mmled:block's*/));
			//Wrap the mathml in "<math/>"
			mathml = '<math xmlns="http://www.w3.org/1998/Math/MathML">' + mathml + '</math>';
			this.value = this.value.replace("$$"+mathExpression+"$$", mathml);
			break; //Wait until the next round so we don't do between every pair of $'s
		}
	}
};
