# 5. SCM and QA Strategies

## 5.0 Source Control Management (SCM)

We will use Git and GitHub to manage the code for a team of 4 members.

### Branching Strategy
We used a simple strategy to preserve the core code, divided into three sections.



### - `main`
**Purpose:**
This is the final and complete version of the Maksab platform, which will be presented to the evaluators and observers on the day of the presentation.

**Rules:**
1. Direct uploading is not allowed.
2. The code can only be entered through integration and has been previously tested.




### - `development`
**Purpose:**
It is a draft compilation for the four members, so that any member who finishes a part puts it in the development.

**Rules:**
1. Any feature that has been completed in its own branch is integrated into development.
2. After completing the testing of the version located in development, We transfer updates to the main page .




###  - `feature/*`
**Purpose:**
A separate branch is created when starting work on a part of the project, so as not to disrupt other work.


  
**Rules:**
 1. When we finish working on a feature in the feature section, it is integrated into development.
2.  Once merged, it is removed from the feature list.

  
### - `hotfix/*`
**Purpose:**
 An exceptional branch we use only in case of an emergency.

### 5.1 Pull Requests & Code Review

Steps to follow if a member has completed a specific feature and wants to add it to the project:

1. **Open a feature branch:** The member opens a new branch from `development` and works on her part.
2. **Request a Pull Request:** Once she finishes her work, she uploads it to GitHub and requests her code to be merged into the `development` branch.
3. **Code Review:** Another team member checks her work to make sure it is error-free, works correctly, and matches the database and APIs.
4. **Integration and cleaning:** After approval, the work is merged into `development` and the temporary branch is deleted to keep it clean.
5. **Uploading to the final version (`main`):** Uploading from `development` to `main` is only for complete versions and requires approval from the team leaders.

### 5.2 Quality Assurance Strategy
How can we make sure that our website is working correctly and without errors before we display it?


**1. Testing tools we use:**


- **PyTest:** A code we write that automatically tests programming equations (such as calculator calculations and product prices).

- **Postman:** A program we use to test APIs and make sure that the server returns the data correctly.

-  **Manual Testing:** We enter the site ourselves as if we were users, press the buttons, and try each option.
  
**2. Code Quality Tools :**
- Automated tools (such as Flake8 for Python and ESLint for React) scan the code and make sure it is written neatly and cleanly without formatting errors.

**3.Main Test Cases :**
- Login (Merchant/Supplier).
-  The calculator and the effect of correct and incorrect numbers on it.
-  Adding products to the cart and making a mock checkout (Moyasar Sandbox).

 ### 5.3 Deployment Pipeline
 How does the code transfer from team members' devices until it becomes a working website on the internet?

**We have three environments:**

 - **Local (Personal Devices):** Each member writes their own feature
 - **Staging (experimental environment - development):** We collect all member code and upload it to a testing environment.
 - **Production (final location - main):** The approved version %100 that we upload for discussion 
 - **Automated Scanning (CI - GitHub Actions):** We note that as soon as a member uploads their work to GitHub, GitHub automatically checks the code and runs tests, and if everything comes out fine, it allows us to merge it.
 
