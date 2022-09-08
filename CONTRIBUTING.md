# `Contributing Guidelines`

This documentation contains a set of guidelines to help you during the contribution process.

We are happy to welcome all the contributions from anyone willing to improve/add new scripts to this project. Thank you for helping out and remember, **no contribution is too small.**

[`Code of Conduct`](CODE_OF_CONDUCT.md)
---------------

<details>

```css
# Contributor Covenant Code of Conduct

## Our Pledge

We as members, contributors, and leaders pledge to make participation in our
community a harassment-free experience for everyone, regardless of age, body
size, visible or invisible disability, ethnicity, sex characteristics, gender
identity and expression, level of experience, education, socio-economic status,
nationality, personal appearance, race, religion, or sexual identity
and orientation.

We pledge to act and interact in ways that contribute to an open, welcoming,
diverse, inclusive, and healthy community.

## Our Standards

Examples of behavior that contributes to a positive environment for our
community include:

* Demonstrating empathy and kindness toward other people
* Being respectful of differing opinions, viewpoints, and experiences
* Giving and gracefully accepting constructive feedback
* Accepting responsibility and apologizing to those affected by our mistakes,
  and learning from the experience
* Focusing on what is best not just for us as individuals, but for the
  overall community

Examples of unacceptable behavior include:

* The use of sexualized language or imagery, and sexual attention or
  advances of any kind
* Trolling, insulting or derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or email
  address, without their explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

## Enforcement Responsibilities

Community leaders are responsible for clarifying and enforcing our standards of
acceptable behavior and will take appropriate and fair corrective action in
response to any behavior that they deem inappropriate, threatening, offensive,
or harmful.

Community leaders have the right and responsibility to remove, edit, or reject
comments, commits, code, wiki edits, issues, and other contributions that are
not aligned to this Code of Conduct, and will communicate reasons for moderation
decisions when appropriate.

## Scope

This Code of Conduct applies within all community spaces, and also applies when
an individual is officially representing the community in public spaces.
Examples of representing our community include using an official e-mail address,
posting via an official social media account, or acting as an appointed
representative at an online or offline event.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported to the community leaders responsible for enforcement at
nkr.nikhil.nkr@gmail.com.
All complaints will be reviewed and investigated promptly and fairly.

All community leaders are obligated to respect the privacy and security of the
reporter of any incident.

## Enforcement Guidelines

Community leaders will follow these Community Impact Guidelines in determining
the consequences for any action they deem in violation of this Code of Conduct:

### 1. Correction

**Community Impact**: Use of inappropriate language or other behavior deemed
unprofessional or unwelcome in the community.

**Consequence**: A private, written warning from community leaders, providing
clarity around the nature of the violation and an explanation of why the
behavior was inappropriate. A public apology may be requested.

### 2. Warning

**Community Impact**: A violation through a single incident or series
of actions.

**Consequence**: A warning with consequences for continued behavior. No
interaction with the people involved, including unsolicited interaction with
those enforcing the Code of Conduct, for a specified period of time. This
includes avoiding interactions in community spaces as well as external channels
like social media. Violating these terms may lead to a temporary or
permanent ban.

### 3. Temporary Ban

**Community Impact**: A serious violation of community standards, including
sustained inappropriate behavior.

**Consequence**: A temporary ban from any sort of interaction or public
communication with the community for a specified period of time. No public or
private interaction with the people involved, including unsolicited interaction
with those enforcing the Code of Conduct, is allowed during this period.
Violating these terms may lead to a permanent ban.

### 4. Permanent Ban

**Community Impact**: Demonstrating a pattern of violation of community
standards, including sustained inappropriate behavior,  harassment of an
individual, or aggression toward or disparagement of classes of individuals.

**Consequence**: A permanent ban from any sort of public interaction within
the community.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage],
version 2.0, available at
https://www.contributor-covenant.org/version/2/0/code_of_conduct.html.

Community Impact Guidelines were inspired by [Mozilla's code of conduct
enforcement ladder](https://github.com/mozilla/diversity).

[homepage]: https://www.contributor-covenant.org

For answers to common questions about this code of conduct, see the FAQ at
https://www.contributor-covenant.org/faq. Translations are available at
https://www.contributor-covenant.org/translations.

```

</details>

----------

### Before contributing please ensure your **pull request** adheres to the following guidelines

## STEP-0 : Key Points to remember

- Look at the [previous](https://github.com/nixrajput/social-media-app-flutter) work and get some idea from them.
- Always maintain project folder architecture.
- Don't delete/remove any existing file or folder.
- Please don't add any License under your work. This repo already under `GPL-3.0 License`.

## STEP-1 : **Flow**

### `Tree of Index`

```js
.
├── src
│   ├── config
│   │   ├── config.env
│   │
│   ├── constants
│   │   ├── responseMessages.js
|   |
│   ├── helpers
│   │   ├── catchAsyncError.js
│   │   ├── errorHandler.js
│   │
│   ├── middlewares
│   │   ├── auth.js
│   │   ├── error.js
│   │   ├── multer.js
|   |
│   ├── models
|   |   ├── index.js
│   │   ├── comment
│   │   │   ├── comment.js
│   │   │
│   │   ├── device-info
│   │   │   ├── deviceInfo.js
│   │   │
│   │   ├── post
│   │   │   ├── post.js
│   │   │
│   │   ├── user
│   │   │   ├── user.js
│   │   │
│   │   ├── notification
│   │   │   ├── notification.js
│   │   │
│   │   ├── otp
│   │   │   ├── otp.js
│   │   │
│   │   ├── hashtag
│   │   │   ├── hashtag.js
│   │   │
│   │   ├── report
│   │   │   ├── report.js
│   │ 
│   ├── modules
│   │   ├── auth
│   │   │   ├── index.js
│   │   │   ├── controllers
│   │   │   │   ├── index.js
│   │   │   │   ├── forgot-password
│   │   │   │   │   ├── forgotPassword.js
│   │   │   │   │ 
│   │   │   │   ├── login
│   │   │   │   │   ├── login.js
│   │   │   │   │
│   │   │   │   ├── logout
│   │   │   │   │   ├── logout.js
│   │   │   │   │
│   │   │   │   ├── register
│   │   │   │   │   ├── register.js
│   │   │   │   │
│   │   │   │   ├── reset-password
│   │   │   │   │   ├── resetPassword.js
│   │   │   │   │
│   │   │   │   ├── verify-account
│   │   │   │   │   ├── verifyAccount.js
│   │   │   │   │   ├── verifyAccountOtp.js
│   │   │   │   │
│   │   │   │   
│   │   │   ├── routes
│   │   │   │   ├── index.js
│   │   │   
│   │   │   
│   │   ├── admin
│   │   │   ├── index.js
│   │   │   ├── controllers
│   │   │   │   ├── index.js
│   │   │   │   ├── user
│   │   │   │   │   ├── deleteUser.js
│   │   │   │   │   ├── getAllUsers.js
│   │   │   │   │   ├── getUserDetails.js
│   │   │   │   │   ├── updateUser.js
│   │   │   │   │   ├── updateUserRole.js
│   │   │   │   │   ├── searchUser.js
│   │   │   │   │   ├── updateAccountStatus.js
│   │   │   │   │   ├── updateVerificationStatus.js
│   │   │   │   │
│   │   │   │   ├── post
│   │   │   │   │   ├── deletePost.js
│   │   │   │   │   ├── getAllPosts.js
│   │   │   │   │   ├── getPostDetails.js
│   │   │   │   │   ├── updatePost.js
│   │   │   │   │   ├── updatePostStatus.js
│   │   │   │   │   ├── searchPost.js
│   │   │   │   
│   │   │   ├── routes
│   │   │   │   ├── index.js
│   │   │
│   │   ├── user
|
├── .gitignore
|
├── CODE_OF_CONDUCT.md
|
├── CONTRIBUTING.md
|
├── LICENSE.md
|
├── package.json
|
├── package-lock.yaml
|
└── README.md
```

## STEP-2 : `Contributing`

We'd love your contributions! Kindly follow the steps below to get started:

0. Star <a href="https://github.com/nixrajput/social-media-app-flutter" title="this">this</a> repository.

1. Fork <a href="https://github.com/nixrajput/social-media-app-flutter" title="this">this</a> repository.

2. Clone the forked repository.

```css
git clone https://github.com/<your-github-username>/social-media-app-flutter
```

3. Create a new branch.

```css
git checkout -b <your_branch_name>
```

4. Make changes.

5. Stage your changes and commit

```css
git add -A

git commit -m "<your_commit_message>"
```

6. Push your local commits to the remote repo.

```css
git push -u origin <your_branch_name>
```

7. Create a <a href="https://github.com/nixrajput/social-media-app-flutter/pulls" title="Pull Request">Pull-Request</a>.

8. Congratulations! 🎉 Sit and relax, you've made your contribution to <a href="https://github.com/nixrajput/social-media-app-flutter" title="Rippl! - A Social Media App">Rippl! - A Social Media App</a>. ✌️ ❤️ 💥

## **Note**

- New categories, or improvements to the existing categorisation, are always welcome.
- If you have any idea or suggestions then check this [Discussion Tab](https://github.com/nixrajput/social-media-app-flutter/discussions). and put your [idea](https://github.com/nixrajput/social-media-app-flutter/discussions/categories/ideas) or [suggestions](https://github.com/nixrajput/social-media-app-flutter/discussions/categories/ideas)🏆

### [`Welcome to Discussions!`](https://github.com/nixrajput/social-media-app-flutter/discussions)

[Discussion Tab](https://github.com/nixrajput/social-media-app-flutter/discussions)

## Need more help?🤔

You can refer to the following articles on basics of Git and Github and also contact the Project [Admin](https://github.com/nixrajput), in case you are stuck:

- [Forking a Repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
- [Cloning a Repo](https://help.github.com/en/desktop/contributing-to-projects/creating-an-issue-or-pull-request)
- [How to create a Pull Request](https://opensource.com/article/19/7/create-pull-request-github)
- [Getting started with Git and GitHub](https://towardsdatascience.com/getting-started-with-git-and-github-6fcd0f2d4ac6)
- [Learn GitHub from Scratch](https://www.youtube.com/watch?v=BCQHnlnPusY&list=PLozRqGzj97d02YjR5JVqDwN2K0cAiT7VK)  
