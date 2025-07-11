import asyncio
import os
import time
from dotenv import load_dotenv
from playwright.async_api import async_playwright, expect

load_dotenv()
USERNAME = "portal@canopi.studio"
PASSWORD = "displayDonkey-0"

async def main():
    """
    The main function to run the automation logic in a visible browser.
    """
    async with async_playwright() as p:
        # This requires a desktop environment on your Raspberry Pi.
        browser = await p.chromium.launch(headless=False)
        page = await browser.new_page()
        print("Browser launched successfully in headed (visible) mode.")

        try:
            await page.goto(URL, timeout=60000)
            print(f"Navigated to: {URL}")
        except Exception as e:
            print(f"Error navigating to page: {e}")
            await browser.close()
            return

        await page.locator("#username").fill(USERNAME)
        await page.locator("#password").fill(PASSWORD)
        print("Username and Password entered.")

        await page.get_by_text('LOG IN').click()
        print("Clicked 'LOG IN'. Waiting 3 seconds for the page to load...")

        await page.wait_for_timeout(3000)

        await page.goto(URL)
        print(f"Navigated to target page: {URL}")

        await page.pause()

# Standard Python entry point to run the async main function.
if __name__ == "__main__":
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