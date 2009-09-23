package tests;

public class WorkingTest extends EditorTestBase {

	public void testSimpleSquigglys() throws Exception {
		//For some reason, can't just check for 1 class on MathML (can't use css selector)
		assertFalse(selenium.isElementPresent("//*[@class='math-content type-error']"));
		assertFalse(selenium.isElementPresent("//*[@class='parse-error']"));
		enter("true+pi");
		assertTrue(selenium.isElementPresent("//*[@class='math-content type-error']"));
		assertFalse(selenium.isElementPresent("//*[@class='parse-error']"));
		press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		enter("poor-syntax(");
		assertTrue(selenium.isElementPresent("//*[@class='parse-error']"));
	}
	
	/** 
	 * #8342
	 * When adding a "+3" right next to an existing "1+2", there should be only
	 * one plus operation.
	 * 
	 * This should also work for =*^| (Every expandable including ones with bvar's)
	 */
	public void testSimpleCongealing() throws Exception {
		enter("true+false");
		enter("+pi");
		assertContainsMath("<plus/>");
		assertNotContainsMath("<plus/><plus/>");
		
		//Clear it out, and do the same for *
		press(BACKSPACE);
		press(BACKSPACE);
		enter("true*false");
		enter("*pi");
		assertContainsMath("<times/>");
		assertNotContainsMath("<times/><times/>");
		
		//Clear it out, and do the same for mml:and
		press(BACKSPACE);
		press(BACKSPACE);
		enter("true&&false");
		enter("&&pi");
		assertContainsMath("<and/>");
		assertNotContainsMath("<and/><and/>");
	
		//Clear it out, and do the same for mml:or
		press(BACKSPACE);
		press(BACKSPACE);
		enter("true||false");
		enter("||pi");
		assertContainsMath("<or/>");
		assertNotContainsMath("<or/><or/>");
	}

	
	public void testBvarNavigation() throws Exception {
		enter("forall");
		press(LEFT);
		press(LEFT);
		enter("pi");
		enter("true");
		enter("false");
		enter("reals");
		press(LEFT);
		press(LEFT);
		press(LEFT);

		assertContainsMath("<pi/><true/><false/><reals/><block/>");

		//delete "false" and move to true
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("<false/>");
		assertContainsMath("<block/><block/><block/>");
		press(BACKSPACE);//deletes the block "false" was in
		assertNotContainsMath("<block/><block/><block/>");
		//delete "true" and move to pi
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("<true/>");
		assertContainsMath("<block/><block/><block/>");
		press(BACKSPACE);//deletes the block "true" was in
		assertNotContainsMath("<block/><block/><block/>");
		//delete "pi" and move to reals
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("<pi/>");
		assertContainsMath("<block/><block/><block/>");
		press(BACKSPACE);//deletes the block "pi" was in
		assertNotContainsMath("<block/><block/><block/>");
		//delete "reals" and move to block
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("<reals/>");
		assertContainsMath("<block/><block/><block/>");
		press(BACKSPACE);
		assertNotContainsMath("<block/><block/><block/>");
		assertContainsMath("<block/><block/>");
		//Make sure we can't delete the last bvar
		press(BACKSPACE);
		assertContainsMath("<block/><block/>");

		//now, delete the whole thing
		press(LEFT);
		selenium.shiftKeyDown();
		press(RIGHT);
		selenium.shiftKeyUp();
		press(BACKSPACE);
		assertNotContainsMath("<forall/>");
	}
	
	/**
	 * Deleting a non-expandable block is still possible. Shouldn't be the case.
	 */
	public void testDontRemoveNonExpandableBlock() throws Exception {
		enter("sum");
		
		//Populate the Sum except for 1 piece
		press(LEFT);
		press(LEFT);
		press(LEFT);
		press(LEFT);
		enter("i");
		enter("1");
		enter("pi");
		
		assertContainsMath("<block/>");
		assertNotContainsMath("<block/><block/>");
		press(BACKSPACE);
		assertContainsMath("<block/>");
		assertNotContainsMath("<block/><block/>");
	}
	
	/** 
	 * #8387
	 * Check that removing the "B" in "a+B" will also remove the plus.
	 * Also, this only applies to certain operations
	 */
	public void testAutoCollapse() throws Exception {
		enter("exponentiale+imaginaryi+pi");
		assertContainsMath("<plus/><exponentiale/><imaginaryi/><pi/>");
		assertNotContainsMath("<block/>");//no more expandable

		//Delete the third pi, and make sure the block is still there
		//(When we hit backspace in an empty block it will go away)
		press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("<pi/>");
		assertContainsMath("<block/>");//1 for the expandable

		//delete the recently created block
		press(BACKSPACE);
		assertContainsMath("<plus/><exponentiale/><imaginaryi/>");
		assertNotContainsMath("<block/>");

		//Delete the "imaginaryi" and make sure there is no plus.
		press(BACKSPACE);
		press(BACKSPACE);
		assertContainsMath("<plus/><exponentiale/>");
		assertNotContainsMath("<imaginaryi/>");
		assertContainsMath("<block/>");//1 for the expandable

		//delete the recently created block and automatically, remove the +
		press(BACKSPACE);
		assertNotContainsMath("<plus/>");
		assertNotContainsMath("<block/>");
		
		//Clean up by deleting the "exponentiale"
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("<exponentiale/>");
		assertContainsMath("<block/>"); //This is the empty block.
		
		
		//---------------- Similar thing, but with subtraction
		enter("exponentiale-a_1-sum-pi");
		//matching "minus" is difficult, so I'm just checking />
		assertContainsMath("pi");
		press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("pi");
		assertContainsMath("<block/><block/>");
		press(BACKSPACE);
		assertContainsMath("sum");
		press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("sum");
		assertContainsMath("<block/>");
		press(BACKSPACE);
		assertContainsMath("msub");
		press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("msub");
		assertContainsMath("<block/>");
		press(BACKSPACE);
		assertContainsMath("exponentiale");
		//press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		assertNotContainsMath("exponentiale");
		assertContainsMath("<block/>");
	}

	/**
	 * The input parser generates a binary tree node for "+*^|" and others but 
	 * they all take a variable number of arguments, so make sure they collapse.
	 */
	public void testCollapseInParse() throws Exception {
		enter("a+b+c");
		assertContainsMath("<plus/>");
		assertNotContainsMath("<plus/><plus/>");
	}
	
	/** #8392 */
	public void testPresentationStyle() throws Exception {
		//Need to use xpath syntax instead of CSS because math elements are "special"
		assertFalse(selenium.isElementPresent("//*[@class='presentation-math']"));
		
		enter("a_1");
		assertTrue(selenium.isElementPresent("//*[@class='presentation-math']"));
	
		press(BACKSPACE);
		press(BACKSPACE);
		assertFalse(selenium.isElementPresent("//*[@class='presentation-math']"));
		
		enter("a+pi");
		assertFalse(selenium.isElementPresent("//*[@class='presentation-math']"));
	}
	
	public void testSimpleAPlusPi() throws Exception {
		enter("a+pi");
	
		//check that we generate a+pi
		assertContainsMath("<math><apply><plus/><ci>a</ci><pi/></apply></math>");
	
		press(LEFT);
		press(BACKSPACE);
		press(BACKSPACE);
		Thread.sleep(10);
		press(RIGHT);
		Thread.sleep(10);
		press(BACKSPACE);
		press(BACKSPACE);
	
		//From Selenium's TestPatterns (copy/pasted as Java through Selenium IDE)
		assertContainsMath("<math><block></math>");
	
	}

}
