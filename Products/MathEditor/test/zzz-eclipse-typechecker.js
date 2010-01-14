/* This file is used by the Eclipse Javascript type-checker to make sure things exist 
 * 
 * So far it has a few functions that are specific to XML or to Firefox,
 * jsMath, Firebug, and custom fields I add to xhtml:input boxes (for the cursor)
 */ 

/**
 * @type Document
 */ 
DOMParser.prototype.parseFromString=function(str, encoding){};
/**
 * @type String
 */
XMLSerializer.prototype.serializeToString=function(node){};
/**
 * @type Node
 */
function XML(str) {return null;};

function XSLTProcessor(){};
/** @param {Node} xsltNode */
XSLTProcessor.prototype.importStylesheet = function(xsltNode){};
/** 
 * @type Node 
 * @param {Node} source 
 * @param {Node} dest 
 * @memberOf XSLTProcessor
 * @returns {Node} 
 */
XSLTProcessor.prototype.transformToFragment = function(source, dest){};
/** Used by IE @param {String} name @param {String} value */
Document.prototype.setProperty = function(name, value){};
/**
 * @type String
 * @param {String} name
 * @memberOf Node
 * @returns {String}
 */
Node.prototype.getAttribute=function(name){}; 
/**
 * @param {String} name
 * @memberOf Node
 */
Node.prototype.removeAttribute=function(name){}; 

/** 
 * @param {any} node
 */
JSMath.prototype.ProcessElement = function(node){};
Window.prototype.jsMath = new JSMath();

/* Firebug console */
/** @param {String} str */
Console.prototype.debug=function(str){};
/** @param {String} str */
Console.prototype.log=function(str){};
/** @param {Object} arg */
Console.prototype.dir=function(arg){};
/** @param {Node} arg */
Console.prototype.dirxml=function(arg){};
/** @param {Boolean} b 
 * @param {String} str */
Console.prototype.assert=function(b,str){};
Window.prototype.console= new Console();

MathInput.prototype = new Node();
MathInput.prototype.value = new String();
MathInput.prototype._editor = new MathEditor();
MathInput.prototype._orig = new String();
