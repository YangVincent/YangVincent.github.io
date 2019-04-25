---
layout: post
title: "Development Workflow"
excerpt: "Efficiency"
image: images/setup.JPG
tags: 
  - life
  - optimization
  - habit
---

## Overview
I'm a strong believer that we should improve both at what we do and how we do it.
I spend hours at a computer telling it what to do; it follows that I should improve
*how* I tell it what to do. In this post, I'll focus on plugins/tips/tricks for my development tools.
IMO (and in the opinion of [these studies](https://ux.stackexchange.com/questions/30682/are-there-any-recent-studies-of-the-keyboard-vs-mouse-issue)), 
using only the keyboard should be faster than the mouse.

## Tools
* Vim (Emacs + evil mode)
* Zsh
* Tmux
* fzf

## Vim
Vim's philosophy is that you edit text in modes -- moving around and editing.
You can find articles on this virtually everywhere, so I'll focus on what I find more unique: the plugins. 

#### Evil
Emacs has better "large feature" support. You can run things that hook back in asynchronously
and even run their version of vim, in emacs (evil). 

#### Kythe
[Kythe](https://github.com/kythe/kythe) is an ecosystem that seeks to "understand" code.
Specifically, it allows tools to communicate across languages. This is helpful in Vim because
it helps you find, for instance, the definition of a function, or where that function
may be called, or the documentation for a function. This allows you to "click through"
in vim.

#### Jumplist
Use ```C-i``` and ```C-o``` to jump forward and backward in a jump list. Typically, you're supposed 
to open multiple buffers for all your files so you don't completely close vim for hours at a time.
When you jump to/from functions and in/out of various files, this will track where you've been and
let you navigate this history easily. Think of it as moving forward and backward in time, vs space.

## Zsh
A nice interactive, powerful shell with pleasant community support.

#### zsh-command-time
Track and output how long each command took.

## Tmux
Tmux allows you to group your terminals and split/configure them however you like.
The plugin manager is called tpm. [Here is a huge list of plugins](https://github.com/tmux-plugins).

#### tmux-resurrect 
Preserves your contents even when you leave sessions/close down the server completely.

#### tmux-continuum
Allows you to reload buffer contents (even stuff like vim files!)

## fzf
Fzf allows you to fuzzy search through a list of strings.

#### fasd
Fasd sorts past commands by frequency and recency (frecency). When coupled with fzf, it is
a powerful way to fuzzy search through opening files you open often. It basically becomes 
global project or content search that can be coupled with vim. 

#### history
fzf and history is nice too.
