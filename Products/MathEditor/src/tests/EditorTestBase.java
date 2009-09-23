package tests;

import java.util.Arrays;
import java.util.List;

import com.thoughtworks.selenium.SeleneseTestCase;

public abstract class EditorTestBase extends SeleneseTestCase {

	public static final String RIGHT = "\\39";
	public static final String BACKSPACE = "\\8";
	public static final String LEFT = "\\37";
	public static final String RETURN = "\\13";
	
	public static final String CURSOR = "css=.cursor";
	public static final String EDITOR = "id=blank-editor";

	public void setUp() throws Exception {
		String baseURL = "http://localhost/~schatzp/MathEditor/";
		System.out.println("Using the URL defined in EditorTestBase: "+baseURL);
		setUp(baseURL, "*firefox");
		selenium.open("test/blank.xhtml");
		Thread.sleep(1000);
		//selenium.click("//x:input[@id='input-editor-0-block-1']");
	}

	/** Used to enter text into the editor. Enters the text and presses Enter */
	protected void enter(String text) throws Exception {
		selenium.type(CURSOR, text);
		press(RETURN);
	}
	
	/** Presses a key (usually a special one like LEFT, BACKSPACE, etc */
	public void press(String key) throws Exception {
		selenium.keyDown(CURSOR, key);
		selenium.keyUp(CURSOR, key);
	}
	
	public void assertContainsMath(String exp) {
		String value = selenium.getValue(EDITOR);
		assertTrue("Value:"+value + "\n" + "Pattern:"+exp, matchesWildcard(value, exp));
	}

	public void assertNotContainsMath(String exp) {
		String value = selenium.getValue(EDITOR);
		assertFalse("Value:"+value + "\n" + "Pattern:"+exp, matchesWildcard(value, exp));
	}

	public boolean matchesWildcard(String value, String exp) {
		exp = exp.replace("</", "__TEMP__");//may contain a prefix so need to put * after /
		exp = exp.replace("<", "*<.?.?");
		exp = exp.replace("__TEMP__", "*</.?.?");

		exp = exp.replace("/>", "__TEMP__"); //may contain attributes <m:pi id=""/>
		exp = exp.replace(">", "*>*");
		exp = exp.replace("__TEMP__", "*/>*");

		exp="*" + exp + "*";
		exp = exp.replace("\\*\\*", "*");
		//replace the *'s with the Regular-Expression equivalent
		exp = exp.replaceAll("\\*", "\\[\\\\s\\\\S]\\*");
		return value.matches(exp);
	}
	
}
