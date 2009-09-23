package tests;

public class FailingTest extends EditorTestBase {

	/** Navigating through a squiggly (syntax/type) error should keep the squiggly */
	public void testRetainSquiggly() throws Exception {
		enter("a+false");
		assertTrue(selenium.isElementPresent("//*[@class='type-error']"));
		press(LEFT);
		assertTrue(selenium.isElementPresent("//*[@class='type-error']"));
		
		press(BACKSPACE);
		assertTrue(selenium.isElementPresent("//*[@class='type-error']"));
		press(RIGHT);
		assertTrue(selenium.isElementPresent("//*[@class='type-error']"));
		
		//Now, delete false, and make a syntax error
		assertFalse(selenium.isElementPresent("//*[@class='syntax-error']"));
		press(BACKSPACE);
		press(BACKSPACE);
		enter("a)");
		assertTrue(selenium.isElementPresent("//*[@class='syntax-error']"));
	}
	
	/** 
	 * #8342 Part 2
	 * Making sure adding to the Left hand side works
	 */
	public void testComplicatedCongealing() throws Exception{
		enter("pi+2");
		enter("=5");
		assertContainsMath("<eq/><plus/>");
		enter("=true=sum");
		assertContainsMath("<eq/><plus/>");
		assertNotContainsMath("<eq/><eq/>");
		//move to the LHS by selecting everything (we could have deleted)
		selenium.shiftKeyDown();
		press(LEFT);
		selenium.shiftKeyDown();
		press(RIGHT);
		press(LEFT);
		//ok, try and add something detectable (so we know it was added to LHS)
		enter("true=");
		assertNotContainsMath("<eq/><eq/>");
		assertContainsMath("<true/><pi/><true/>");
	}

	public void testInsertMathMLInCursor() throws Exception {
		enter("<m:mbox><m:mi>TEST</m:mi></m:mbox>");
		assertContainsMath("<math><mbox><mi>TEST</mi></mbox>");
	}
	
}
