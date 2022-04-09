# Installables barn

⚠️ WIP - A barn of installables.

Universal installers with some preset tools.

# Why?

Automate the bootstrap of common projects. Otherwise either we have to do all steps on every starting project or we have an outdated repo/snapshot 🤷🏻‍♂️

# NextJS install

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jbbn/installables-barn/main/nextjs-install.sh)"
```

- Starts a monorepo by default (using Yarn workspaces);
- Remove `api` folder and `styles` implementation;
- Add `styled-components` to the project;
- Git init and initial commit.

## TODO

- [ ] Configure CircleCI to daily check if the installable still works;
- [ ] Make the use of `styled-components` optional;
- [ ] Allow other CSS libraries to be integrated (like: Tailwind, Bootstrap, MaterialUI, ...);

# TBH

To be very honest, I only had the chance to test these installers on a Mac.
