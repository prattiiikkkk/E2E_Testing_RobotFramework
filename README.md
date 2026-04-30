# E2E Testing Robot Framework

End-to-end test automation project for the **Demo Web Shop** e-commerce application using **Robot Framework**, **SeleniumLibrary**, and Excel-based test data.

## Project Overview

This repository contains automated UI tests for common e-commerce user journeys such as registration, login, wishlist, cart, search, checkout, and cleanup flows.

Application under test:

```text
https://demowebshop.tricentis.com/
```

## Tech Stack

- Robot Framework
- SeleniumLibrary
- RPA.Excel.Files
- Python
- Excel test data
- PyCharm / command line execution

## Project Structure

```text
E2E_Testing_RobotFramework/
│
├── Pages/
│   ├── Actions.robot              # Reusable business/action keywords
│   └── PageVerifications.robot    # Page navigation and page verification keywords
│
├── UserData/
│   ├── RegistrationUsers.xlsx     # Registration test data
│   ├── ValidUsers.xlsx            # Valid login/user data
│   └── InvalidUsers.xlsx          # Invalid/negative test data
│
└── Tests.robot                    # Main test suite
```

## Covered Test Scenarios

The project currently includes tests for:

- Negative registration validation
- Positive registration
- Forgot password flow
- Negative login validations
- Positive login and logout
- Add products to wishlist
- Add products to cart
- Remove products from cart
- Remove products from wishlist
- Verify cart items after re-login
- Verify wishlist items after re-login
- Product search
- Checkout with login
- Checkout without login
- Terms of service popup validation
- Cart and wishlist cleanup

## Test Data Handling

The framework uses Excel files from the `UserData` folder.

Example registration data columns:

```text
Regis_FirstName
Regis_LastName
Regis_Email
Regis_Password
Used
```

The `Used` column helps avoid reusing the same registration user multiple times.

## Installation

Clone the repository:

```bash
git clone https://github.com/prattiiikkkk/E2E_Testing_RobotFramework.git
cd E2E_Testing_RobotFramework
```

Install dependencies:

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
pip install rpaframework
```

Verify installation:

```bash
robot --version
```

## Running Tests

Run the complete test suite:

```bash
robot Tests.robot
```

Run a specific test:

```bash
robot --test "PositiveLoginandLogoutFlow" Tests.robot
```

Run tests by tag:

```bash
robot --include PosFlow Tests.robot
```

```bash
robot --include WLogIn Tests.robot
```

## Reports

After execution, Robot Framework generates:

```text
log.html
report.html
output.xml
```

Open `report.html` or `log.html` in a browser to review test results.

## Recommended .gitignore

Add the following to `.gitignore` to avoid committing generated reports, screenshots, IDE files, and caches:

```gitignore
# Robot Framework reports
log.html
report.html
output.xml
selenium-screenshot-*.png

# Python cache
__pycache__/
*.pyc

# PyCharm
.idea/

# Environment
.venv/
venv/
```

## Notes

- Keep Excel files closed while running tests.
- Make sure the browser driver/browser setup is compatible with your local environment.
- Keep test cases independent and place reusable steps inside keywords.
- Use cleanup keywords before state-dependent cart or wishlist tests.

## Author

Created by [Pratik Vijay Kesarkar](https://github.com/prattiiikkkk).
