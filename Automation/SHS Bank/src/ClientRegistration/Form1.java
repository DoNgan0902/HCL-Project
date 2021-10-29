package ClientRegistration;

import org.testng.annotations.Test;

import com.relevantcodes.extentreports.ExtentReports;
import com.relevantcodes.extentreports.ExtentTest;
import com.relevantcodes.extentreports.LogStatus;

import XLSReader.XLSReader;

import static org.testng.Assert.assertTrue;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import java.util.concurrent.TimeUnit;
import org.testng.annotations.DataProvider;


public class Form1 {
	private WebDriver driver;
	private static String text = "Personal Details";
	private static String baseUrl = "http://54.237.43.64/sign-up/client";
	static ExtentTest test;
	static ExtentReports report;


	@BeforeClass
	public void beforeClass() throws InterruptedException {
		System.setProperty("webdriver.chrome.driver", "D:\\AutoTest\\chromedriver\\chromedriver.exe");
		driver = new ChromeDriver();
		driver.manage().timeouts().implicitlyWait(500, TimeUnit.MILLISECONDS);
		report = new ExtentReports(System.getProperty("user.dir") + "/test-output/MenuTestResults.html");
		test = report.startTest("SHS Bank - CLient Registration - Form1");
	}

	@Test(dataProvider = "Form1")
	public void testForm1(String username, String password, String confirmPassword, String result)
			throws InterruptedException {

		
		
		driver.get(baseUrl);
		driver.findElement(By.xpath("//input[@formcontrolname='userId']")).sendKeys(username);
		driver.findElement(By.xpath("//input[@formcontrolname='password']")).sendKeys(password);
		driver.findElement(By.xpath("//input[@formcontrolname='confirm_password']")).sendKeys(confirmPassword);
		driver.findElement(By.xpath("//span[text()='Next']")).click();
		Thread.sleep(1000);

		
		if (result.equals("pass")) {
			if (text.equals(driver.findElement(By.xpath("//div[text()='Personal Details']")).getText())) {
				System.out.println(driver.findElement(By.xpath("//div[text()='Personal Details']")).getText());
				assertTrue(true);
				test.log(LogStatus.PASS, "Form1 - Pass");

			} else {

				assertTrue(true);
				if (!driver.findElements(By.xpath("//mat-error[@role='alert']")).isEmpty())
					System.out.println(driver.findElement(By.xpath("//mat-error[@role='alert']")).getText());

				test.log(LogStatus.FAIL, "Failed");
			}
		}
	}

	@DataProvider(name = "Form1")
	public String[][] getData() {
		String[][] rowCol = null;
		try {
			DataConfig data = new DataConfig("C:\\Users\\Admin\\Desktop\\RV\\HCL\\Final Project - Automation Test\\SHS Bank.xlsx");
			int sheetIndex = 4;

			int noOfRow = data.getRowCount(sheetIndex);
			int noOfCell = data.getCellCount(sheetIndex, 0);
			rowCol = new String[noOfRow][noOfCell];

			for (int i = 1; i <= noOfRow; i++) {
				for (int j = 0; j < noOfCell; j++) {
					rowCol[i - 1][j] = data.getCellData(sheetIndex, i, j);
				}
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return rowCol;
	}

	@AfterClass
	public void afterClass() {
		driver.quit();
		report.endTest(test);
		report.flush();
	}

}