package tests;

import test_calc.Calculator;
import org.testng.annotations.Test;
import org.testng.Assert;
import org.testng.asserts.SoftAssert;

public class calcTest {

	@Test
	public void testAdd() {
		Calculator calc = new Calculator();
		int res = calc.add(1, 3);
		Assert.assertEquals(res, 4);
	}

	@Test
	public void testSub() {
		Calculator calc = new Calculator();
		SoftAssert softAssert = new SoftAssert();
		int res = calc.sub(3, 2);
		Assert.assertEquals(res, 1);
		int res2 = calc.sub(9, 2);
	    softAssert.assertEquals(res2, 7); // If this fails, it keeps going

	    // You MUST call this at the end to report the failures
	    softAssert.assertAll();
	}
}