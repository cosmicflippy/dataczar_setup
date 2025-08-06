import asyncio
import os
import time
from dotenv import load_dotenv
from playwright.async_api import async_playwright, expect, Playwright


load_dotenv()
USERNAME = ""
PASSWORD = ""
URL = ""

# Check if credentials were loaded correctly
if not USERNAME or not PASSWORD:
    print("Error: WEBSITE_USERNAME and WEBSITE_PASSWORD must be set in the.env file.")
    exit(1)

async def main():
    """
    The main function to run the automation logic in a visible browser.
    """
    async with async_playwright() as p:
        # This requires a desktop environment
        browser = await p.firefox.launch(
        headless=False,
        args=['--kiosk']
        )
        page = await browser.new_page()
        print("Browser launched successfully in headed (visible) mode.")

        # 2. Navigation: Go to the target website.
        try:
            await page.goto(URL, timeout=60000)
            print(f"Navigated to: {URL}")

            await page.evaluate("document.body.style.zoom=0.85")
            print("Page zoom set to 85%.")
        except Exception as e:
            print(f"Error navigating to page: {e}")
            await browser.close()
            return

        # 3. Interaction: Fill credentials and log in.
        # Using specific locators for username, password, and login button.
        await page.locator("#username").fill(USERNAME)
        await page.locator("#password").fill(PASSWORD)
        print("Username and Password entered.")

        await page.get_by_text('LOG IN').click()
        print("Clicked 'LOG IN'. Waiting 3 seconds for the page to load...")

        # Use the asynchronous version of sleep to avoid blocking.
        await page.wait_for_timeout(3000)

        await page.goto(URL)
        print(f"Navigated to target page: {URL}")

        # The browser window will remain open until you manually close it.
        print("\nAutomation sequence complete.")
        print("The browser will remain open. Close the browser window to exit the script.")
        await page.wait_for_event('close', timeout=0)

        print("Browser window closed. Script finished.")

if __name__ == "__main__":
    # Check for placeholder credentials before running.
    if USERNAME == "username" or PASSWORD == "password":
        print("Warning: Please replace the placeholder username and password in the script.")

    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\nScript interrupted by user. Exiting.")
    except Exception as e:
        # This will catch errors if the browser is closed before page.pause()
        if "Target page, context or browser has been closed" in str(e):
            print("Browser closed. Script finished.")
        else:
            print(f"An unexpected error occurred: {e}")