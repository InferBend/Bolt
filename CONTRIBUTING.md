# Contributing

Contributions are welcome, and they are greatly appreciated! Every little bit
helps, and credit will always be given.

You can contribute in many ways:

## Types of Contributions

### Report Bugs

Report bugs at <https://github.com/InferBend/Bolt/issues>.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.

### Fix Bugs

Look through the GitHub issues for bugs. Anything tagged with "bug" is open to whoever wants to implement it.

### Implement Features

Look through the GitHub issues for features. Anything tagged with "enhancement" is open to whoever wants to implement it.

### Write Documentation

bolt could always use more documentation, whether as part of the
official bolt docs, in docstrings, or even on the web in blog posts,
articles, and such.

### Submit Feedback

The best way to send feedback is to file an issue at <https://github.com/InferBend/Bolt/issues>. If you need to place to discuss and brainstorm please use the discussions space at <https://github.com/InferBend/Bolt/discussions>.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions
  are welcome :)

## Get Started

Ready to contribute? Here's how to set up `bolt` for local development.

1. Fork the `bolt` repo on GitHub.
2. Clone your fork locally

    ```sh
    git clone git@github.com:<your_github_username_name_here>/bolt.git
    ```

5. Create a branch for local development:

    ```sh
    git checkout -b name-of-your-bugfix-or-feature
    ```

8. Commit your changes and push your branch to GitHub:

    ```sh
    git add .
    git commit -m "Your detailed description of your changes."
    git push origin name-of-your-bugfix-or-feature
    ```

    **Note:** Commit messages must follow the [Conventional Commits Specification](https://www.conventionalcommits.org/en/v1.0.0/). This ensures a standardized and semantic versioning-friendly commit history.


9. You may want to add the remote upstream repository to your local repository to stay in sync with the main repository:

    Run this command to add the upstream repository:
    ```sh
    git remote add upstream git@github.com:InferBend/Bolt.git
    ```

    You can verify if you added the upstream repository successfully by running the following command:
    ```sh
    git remote -v
    ```
    Now you can pull the latest changes from the main repository by running the following command:
    ```sh
    git pull --rebase upstream main
    ```
10. Submit a pull request through the GitHub website after ensuring you follow the guidelines.

## Pull Request Guidelines

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
3. If the pull request adds functionality, the docs should be updated. Put
   your new functionality into a function with a docstring, and add the
   feature to the list in [README.md](README.md).
