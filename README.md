# robot-trello_API

Sample project to demonstrate basic api tests using the trello api of my personal account.

# Pre-requirements:

- Python 3.12.2.
- Robot Framework 7.0.
- SeleniumLibrary 6.2.0.
- RequestsLibrary 0.9.6.
- JSONLibrary 0.5.
- Visual Studio Code 1.87.2 (Optional, however strongly recommended so you can use Robot Framework Language Server extension).
- Robot Framework Language Server 1.11.0.
- Chrome browser 123.0.6312.86 (64-bit).
- Firefox browser 124.0.1 (64-bit).
- Chrome webdriver 123.0.6312.86 (r1262506).
- Firefox geckodriver 0.34.0 (2024-01-03, c44f0d09630a).
- Chrome TruePath extension 1.0.0.

# Instalation:

- See "https://www.python.org/downloads/" and download the latest Python stable version. Start the installation and check
both "Add python.exe to PATH" and "Use admin privileges when installing py.exe" checkboxes.
- Open windows propmpt as admin and execute the "pip install robotframework" command.
- Open windows propmpt as admin and execute the "pip install robotframework-seleniumlibrary" command.
- Open windows propmpt as admin and execute the "pip install robotframework-requests" command.
- Open windows propmpt as admin and execute the "pip install robotframework-jsonlibrary" command.
- See "https://code.visualstudio.com/" and install the latest VSC stable version.
- Look for "Robot Framework Language Server" in the VSC extensions marketplace and install it.
- See "https://www.google.com/chrome/dr/download/" and install Chrome browser.
- See "https://www.mozilla.org/pt-BR/firefox/new/" and install Firefox browser.
- See "https://googlechromelabs.github.io/chrome-for-testing/" and look for the binary file of the chromedriver that has same version of your Chrome browser, and open its URL. Donwload is supposed to start automatically.
- See "https://github.com/mozilla/geckodriver/releases" and download the geckodriver related to your system's capabilities.
- Unzip both Chrome and Firefox drivers inside Python scripts folder (C:\Python312\Scripts). This folder must be configured in windows environment varibles.
- See "https://chromewebstore.google.com/detail/truepath/mgjhkhhbkkldiihlajcnlfchfcmhipmn?hl=pt-BR" and install TruePath extension.

# Tests:

- "robot -d results api/tests" to execute tests in headless mode.

# Support:

- SeleniumLibrary (https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- RequestsLibrary (https://github.com/MarketSquare/robotframework-requests#readme)
- JSONLibrary (https://robotframework-thailand.github.io/robotframework-jsonlibrary/JSONLibrary.html#library-documentation-top)
- String (https://robotframework.org/robotframework/latest/libraries/String.html#Remove%20String)
- OperatingSystem (https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html)
- BuiltIn (https://robotframework.org/robotframework/latest/libraries/BuiltIn.html)
- Error regarding installing robotframework-jsonlibrary explicitly (https://blog.finxter.com/fixed-modulenotfounderror-no-module-named-robotframework-jsonlibrary/)

# Tips

- Always check drivers and browsers versios before running the tests. They should be compatible.


