---
layout: post
title: "Personality Vectors, Rigidly Defined"
excerpt: "A mathematical approach to improving life"
image: assets/images/river.jpg
tags: 
  - life
  - optimization
  - habit
---

### Overview
If you haven't yet read the first version, read [personality vectors]({{site.url}}/personality-vectors/).

This version establishes firm mathematical footing and is still very much in progress, especially since I haven't added LaTeX support.

Here's an unordered list of facts we care about.

* We want a finite number of possible interests. Otherwise the inner product between two vectors could be unbounded, which would be problematic. Otherwise, we need definite infinite.
* There's a precise term for this space of vectors, called L2-Space. "Interests are infinite-dimensional vectors living in the square-integrable L2 space"
* Square integrable means the Lebesque integral of the function squared is finite. If f is the function, I the interval and p(x)dx the probability measure,
f is square integrable if the integral over l of $$dx p(x) (f(x)^2) < infinity$$.


Here is where it starts.

### Interests and Preferences

Suppose our world has a list of infinite interests. This is everything I (or anyone) could possibly have an opinion on -- from dogs to running 
to crying to mitochondria. Let's call this `$I: \{$`set of all interests`$\} = \{$`dog, japan, crying, `$...\}$`. Formally,

$$I: \{i_1, i_2, i_3, ...\}, |I| = \infty$$

As people (or animals), we have preferences about these things. That is, we have some opinion about how much we like it or not. We can scale these
preferences to a range from `$-1$` to `$1$`, so things I really hate are closer to `$-1$` and things I love are closer to `$1$`. Let's suppose
my preferences for the interests listed above are:

* I like dogs, so `$0.6$`
* Japan is an amazing destination with rich culture, so `$0.9$`
* Crying sucks, so `$-0.7$`

Ordering this up with our above list, we get `$(0.6, 0.9, -0.7)$` are my preferences for 
`$\{$`dog, japan, crying`$\}$`. We'll forget the rest for now for the sake of example. Formally, this is our **preference vector**. 

$$PV: \{p_1, p_2, p_3, ...\}: p_i\ |\ i \in \mathbb{N}, -1 \leq p_i \leq 1$$

### What your PV means to you

As you interact with people, you implicitly score them for every attribute in `$I$`. This means if I know Alice `$A$` and Bob `$B$`,
I can rank them based on my PV.

* Rank Alice on my line.
* Rank Bob on my line.
* Rank myself on my line.

### Other people's PVs

My preference vector is a reasonable summary of who I am as a person. At the same time, everyone else also has their own preference vectors.
For firm mathematical footing, we're working with these vectors in an `$l_2$` space.



# Figure out how to add plotly.
This is a plot.

<div id='myDiv'></div>

<script>
Plotly.d3.csv('https://raw.githubusercontent.com/plotly/datasets/master/3d-line1.csv', function(err, rows){
      function unpack(rows, key) {
          return rows.map(function(row) 
          { return row[key]; }); }
          
var x = unpack(rows , 'x');
var y = unpack(rows , 'y');
var z = unpack(rows , 'z'); 
var c = unpack(rows , 'color');
Plotly.newPlot('myDiv', [{
  type: 'scatter3d',
  mode: 'lines',
  x: x,
  y: y,
  z: z,
  opacity: 1,
  line: {
    width: 6,
    color: c,
    reversescale: false
  }
}], {
  height: 640
});
});
</script>
