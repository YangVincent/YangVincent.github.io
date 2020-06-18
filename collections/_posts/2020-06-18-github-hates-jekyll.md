---
layout: post
title: "Github hates Jekyll"
excerpt:
tags:
 - development
---

Recently I've spent a lot of time thinking about how I want to manage my data and my notes. I've previously 
used Roam Research and Notion, but I'm scared that those might someday force me to pay or worse, lose my data.
I've decided to instead create a clone of the features I enjoy here so I can just put all my notes online and
access them whenever. The downside is that I can't modify them on mobile, but I'm okay with that loss. 

New features:
1. Search with Algolia
2. Travis CI
3. Estimated reading time
4. Bidirectional Linking

### Algolia
Integrating with Algolia was absurdly simple. You add a few snippets of code and send your pages over to them so they can build a search index. They even help you set up Travis CI so this index gets rebuilt whenever you push new changes.

### Travis CI
I got this for free with Algolia, but it's a little bit sad doing dependency management here. Specifically, `bundle` doesn't play well with newer versions of `json` so in its infinite wisdom, Travis CI (but really the problem is Ruby) decides to die.

### Bidirectional linking
I created this by looking over and over at how Generators work in Jekyll. It was a ton of googling how to do very basic things in Ruby and slowly hacking it together. Some learnings:
1. Generators work by taking in some information and outputting other information that can be read by each page to become content.
2. We have to first look through all posts to find where all the links are pointing to, then reverse this so we can see where all the links are pointing from.
3. I should probably change my plugin to an actual Gem, but I'm lazy.
4. Github doesn't allow us to install plugins because they mandate safe mode!!
5. I found a reasonable tool to use Github to host, but disable their Jekyll (jgd -- jekyll github deploy). It works by taking a source branch, building it, and dumping it on a resulting branch to build.
6. Github forces you to use `master` to build on a name branch.

Github hates Jekyll. You heard it here first.
