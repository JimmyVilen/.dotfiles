Review the changes in the current branch compared to main (or master). This is a combined security and maintainability review scoped to the PR diff only. The PR number is: $ARGUMENTS

## Step 1: Identify the changes

Run the following to get the list of changed files and the full diff:

```bash
git diff main...HEAD --name-only
git diff main...HEAD
```

If main does not exist, try master instead. Only review files and lines that appear in this diff.

## Step 2: Security review

Review the changed code for security issues. Focus areas:

- Injection vulnerabilities (SQL, NoSQL, command injection)
- Input validation and sanitization
- Authentication and authorization checks
- Exposed secrets, keys, or connection strings
- Insecure dependencies (new or changed packages)
- CORS and CSP configuration changes

## Step 3: Maintainability review

Review the changed code for maintainability and code quality. Guiding principles:

- **Avoid premature abstraction:** Don't abstract until patterns are clearly and repeatedly established. Some code duplication is preferable to the wrong abstraction.
- **Prefer co-located code:** Keep related logic together. Locality of behavior makes code easier to follow, debug, and maintain.
- **Simplicity over cleverness:** Prioritize code that is easy to read and follow over code that is maximally DRY or generic.
- **Semantic naming:** Class, method, and variable names should clearly describe their purpose and behavior. Evaluate naming for clarity and consistency.

## Step 4: Generate report

Generate a markdown report and save it as `review-pr-{PR_NUMBER}-YYYY-MM-DD.md` (where `{PR_NUMBER}` comes from `$ARGUMENTS`) with the following structure:

- Header with date, branch name, PR number, and list of changed files
- Summary table with finding counts by severity: Critical, High, Medium, Low
- Security findings grouped by severity, each with: file/location, description, why it matters, and suggested fix with code example if applicable
- Maintainability findings grouped by severity, each with: file/location, description, why it matters, and suggested improvement with code example if applicable
- Positive observations: things done well in the PR
- Conclusion with overall assessment and recommended actions before merge

Save the file in a `/reviews` folder in the project root.
