# dotfiles

A collection of dotfiles that provide an unobtrusive workflow with zsh, tmux, and vim.

> An important thing to keep in mind is that this is very much a work in progress. While developing with these tools, the structure is bound to change.

## Configuration Depth

These dotfiles work at three levels: the system, the context, and the project.

### System
Any system-level overrides can currently be added to the home-level dotfiles (`~/.vimrc`, etc...). In the future, there will be a convention for added extensions to a directory where they will be autoloaded.

### Context
In order to keep configurations slim and non-conflicting, there will be an additional context layer that can be used for sourcing specific overrides as needed. Say you usually develop a project in python, but you're starting a new personal project in golang. In this case, the contexts would separate which vim plugins are loaded. You could have separate todo lists depending on which context you're in, and using the tmux shortcut `<prefix> t` would pull up a different markdown file.

Context should be able to extend others, either all contexts should be written to source the base configurations they extend, OR, there should be a conventional folder structure for these.

### Project
Projects will have a source control ignored file that will either specify a context the shell should adopt upon entering, or declare its own set of configurations. This hasn't been decided yet.

**TODO:** Add a global VCS ignore for these files/folders.

> Projects can have IDE files that are opinionated tmux sessions. Contexts should provide everything needed for running, testing, and debugging code in the project's languages.

## Resources
- [Chris Toomey's dotfiles](https://github.com/christoomey/dotfiles)

