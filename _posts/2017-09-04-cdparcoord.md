---
layout: post
title: "cdparcoord"
excerpt: "Top Frequency-Based Parallel Coordinates"
image: images/cdparcoord-diacdpar.png
tags: 
  - research
  - cdparcoord
  - matloff
  - davis
  - tech
---

## What is cdparcoord?

cdparcoord is a CRAN package for parallel coordinate plotting with resolutions for large
data sets and missing values. I won't go into technicalities here, but the
full vignettes are [here](https://cran.rstudio.com/web/packages/cdparcoord/vignettes/cdparcoord.html),
the source is [here](https://github.com/matloff/cdparcoord), and the academic paper
is [here](https://arxiv.org/abs/1709.00665).

Over the last 9 months, I have been blessed with the opportunity to work on this project alongside
a friend and with an amazing mentor. Here's what happened and what I learned.

Early on, a friend of mine, Harrison Nguyen, reached out to Dr. Norm Matloff trying to get
a PTA for his class - Scripting Languages. To his (and my) surprise, Matloff declined his request
to enter the class, but countered with an interesting proposition. He suggested working with him on 
a research project on parallel coordinates instead - an opportunity that Harrison immediately accepted.
Harrison told me about this and later the two invited me to join in on the project. Today, we 
have a paper on arxiv and a package on CRAN. Here are my key takeaways. 

## Learnings About Research and Development

#### People have different strengths, and it's important to find strengths that mesh together.

Harrison comes from a statistics background, and I from a CS one. While collaborating on 
cdparcoord, I found that he would be able to tackle complex analytics easily and often
came up with a short, clean, programmatic solution in R. While creating the primary
workhorse function for the package, I racked my brain on how to implement an efficient
solution, which quickly devolved into finding simply a solution that worked. My implemention,
I'm embarrased to say, relied on string manipulation and comparison while Harrison's
worked in several short lines and maximized usage of R's core functions. 

On the other hand, when we ran into issues with the code, it was often sufficient for me
to hear about the context of a situation, expected outcomes, and actual outcomes in order
to find the bug. I attribute both of these characteristics to practice, and this experience
taught me just how different two people could think about the same problems, and how we
could use this to our advantage. 

#### Research is about results.

For part of the package, I was looking for trends in airline data. Theoretically, we could
find the path of a plan from point A, to B, to C, then analize subsets of plans that would
still contribute to the 'weight' of full routes. After spending nearly a week preparing the
data and finding patterns, the results were unfortunately weak in demonstrating cdparcoord's
strengths. As such, we could not use it. Sometimes in life, simply having hard work is insufficient.

#### Research is rather similar to working on projects normally.

You focus on mildly different questions, but still test out programs, tools, and scenarios in
much the same way as you would for an actual product. Stackoverflow is still your best friend and
You still code as you would before, but now you care about finding your own implementations
over using someone else's.

#### Nothing beats experience.

There were many times where Harrison and I walked into a meeting with Dr. Matloff completely
stuck on the project, and walked out with the realization that the fix was really quite simple. 
Dr. Matloff's experience was invaluable with gauging the depth of our problem and predicting
the outcome of potential solutions without actually having to implement them. 

## Acknowledgements

All in all, this experience has been particularly eye-opening. I'd like to thank Dr. Matloff
for his consistent guidance, Harrison Nguyen for this opportunity and for 
all the times we actually pair programmed, and Rylan Schaeffer for pushing me towards research.
