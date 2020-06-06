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

## Overview
If you haven't yet read the first version, read [personality vectors]({{site.url}}/resources/personality-vectors/).

## Core Definitions
Let us establish:
* Things (`$T$`): An ordered, infinitely large set of everything you could possibly have an opinion on.
* Preference Vectors (`$P$`): A person's preference for each thing they could possibly have an opinion on. This order matches that of `$T$`. Ex: Honesty. Higher values are better.
Two people are more similar if their (`$P$s`) are more similar.
* Attributes (`$A$`): A person's attributes. Ex: Whether or not I am honest. Higher values are more significant. These can be combined with `$P$` to determine how much you want to interact with someone. 

For firm mathematical footing, let's rigidly define each. We're working with these vectors in an `$l_2$` space.

$$T: \{t_1, t_2, t_3, ...\}, |T| = \infty$$

$$P: \{p_1, p_2, p_3, ...\}: p_i\ |\ i \in \mathbb{N}, -1 \leq p_i \leq 1$$

$$A = \{a_1, a_2, a_3, ...\}, |A| = |I|, -= \leq a_i \leq 1$$

Notice that a single preference `$p_i$` is scaled down to `$[-1, 1]$`. This means `$1$` is the most you could possibly care for any single thing, and everything must exist
in proportion to this. If I have gone through a traumatic experience with a friend with whom I have no other common values, that means I must value "having had that experience"
more than the sum of "all my common values". The same holds true for attributes.

### Similarity

The similarity between two people is the cross product of their PVs. The cross product combines both the significance (length) as well as the similarity (angle).

$$Similarity = \langle P_1, P_2 \rangle$$

### Bandwidth

Since we have a finite amount of time and processing power, we're capped in terms of how many things we can have meaningful opinions on. This works like
a budget: you have some amount of "effort" you can dedicate towards learning about and participating in things. This "effort" gets distributed 
across your own attributes as well as your preferences. Effectively, this means it is impossible to care about/be known for everything maximally, although
some people may have a more diverse spread than others.

### Opacity

Unfortunately, it's impossible to know the true value of our preference vectors and attributes, so there's an extra degree of uncertainty here. As we interact with people,
our impressions of them grow more clear, so our perceived attributes and guesses of others' PVs hopefully grow more accurate.

### Example

Suppose our world actually only has 3 things we could possibly have an opinion on: being a dog, being related to Japan, and being honest.

$$T = \{dog, japan, honesty\}$$

Let's first figure out my PV -- how much I care about each.

* I like dogs, so `$0.6$`
* Japan is an amazing destination with rich culture, so `$0.9$`
* Honesty is almost always important, so `0.8`

Ordering this up with `$T$`, we get 

$$P_v = (0.6, 0.9, 0.8)$$

Now, I `$v$` can also observe how well I adhere to each of these. Note that this is not the same as my preference for them. Rather, it is
how well I am attributed to each.

* I am not a dog, so `$0$`
* I have only been to Japan once but don't know much about their culture, so `$0.2$`
* I am mostly honest, but not always, so `$0.6$`

$$ A_{v}: \{0, 0.2, 0.6\} $$

I can also observe others' attributes; Suppose Eve `$e$` is my friend who 
* is not a dog `$0$`
* has never heard of Japan `$-0.2$`
* is very honest `$0.8$`. 

And Bob `$b$` is 
* a dog `$1$` 
* that lives in Japan `$0.8$`
* but plays tricks and isn't very honest `$-0.7$`. 

$$A_{e} = \{0, -0.2, 0.8\}$$

$$A_{b} = \{1, 0.8, -0.7\}$$


I can combine each person's values to respective points on my `$P$`, which represents my world view. 
You tend to want to interact with people higher than you on this range and avoid those lower than you on this range.
The formula `$f$` for doing so is:

$$f(P, A) = \sum_{i-0}^{i=\infty}A_{i} \cdot P_{i} $$

$$f(P_v, A_{e}) = (0 \cdot 0.6) + (-0.2 \cdot 0.9) + (0.8 \cdot 0.8) = 0.46$$

$$f(P_v, A_{b}) = (1 \cdot 0.6) + (0.8 \cdot 0.9) + (-0.7 \cdot 0.8) = 0.76$$

I can also grade myself based on my own attributes `$A_v$`.

$$f(P_v, A_{v}) = (0 \cdot 0.6) + (0.2 \cdot 0.9) + (0.6 \cdot 0.8) = 0.66$$


<div id='myDiv'></div>

<img src="{{ site.url }}/assets/images/preference-vectors/group-pv.png" alt="group-pv" style="background-color:#fff; padding: 5px 5px 5px 5px;"/>

<script>
var alice = {
  x: [0.46],
  y: [0],
  type: 'scatter',
  hoverinfo: 'x'
};
var bob = {
  x: [0.76],
  y: [0],
  type: 'scatter',
  hoverinfo: 'x'
};
var me = {
  x: [0.66],
  y: [0],
  type: 'scatter',
  hoverinfo: 'x'
};


var layout = {
  hovermode: 'closest',
  showlegend: false,
  xaxis: {
	range: [-1,1],
    autorange: false,
    showgrid: false,
    zeroline: false,
    showline: false,
    autotick: true,
    ticks: 'outside',
    showticklabels: true
  },
  yaxis: {
    autorange: false,
    showgrid: false,
    zeroline: false,
    showline: false,
    autotick: false,
	zerolinewidth:3,
    showticklabels: false
  },
  annotations: [
	{
		xref: 'x',
    	yref: 'y',
    	x: 0.46,
    	y: 0.1,
    	xanchor: 'center',
    	text: 'Alice',
		yanchor: 'bottom',
  	},
	{
		xref: 'x',
    	yref: 'y',
    	x: 0.76,
    	y: 0.1,
    	xanchor: 'center',
    	text: 'Bob',
		yanchor: 'bottom',
  	},
	{
		xref: 'x',
    	yref: 'y',
    	x: 0.66,
    	y: 0.1,
    	xanchor: 'center',
    	text: 'Me',
		yanchor: 'bottom',
  	}
  ]
};

var data = [alice, bob, me];
Plotly.newPlot('myDiv', data, layout);
</script>


---

## Other people's PVs

My preference vector is a reasonable summary of who I am as a person. At the same time, everyone else also has their own preference vectors.
Note that preference vectors are different from attribute vectors, in that preference vectors indicate someone's opinions towards things and
not their ability to fulfill those things. For instance, I like dogs (preference) but am not a dog (attribute). However, the fact that I like dogs 
can also be a separate attribute. **To be pedantic, it's possible preference vectors are actually simply a subset of attributes**.

Let's now describe `eve` and `bob`'s preferences.
Alice loves dogs, but has no interest in Japan. She also thinks being honest is pretty important. 
On the other hand, Bob is a monster who hates dogs, hates Japan, and is extremely dishonest.

$$P_e=\{1, -0.3, 0.7\}$$

$$P_b=\{-0.9, -0.4, -0.7\}$$

$$P_v = (0.6, 0.9, 0.8)$$

We tend to want to spend more time with people who have similar preferences. The smaller the inner product between our vectors,
the more similar our preferences are. Our preferences are closely tied with our attributes.
Over time, people who spend together have preference vectors whose inner products shrink -- the vectors become more similar.

In the chart below, we can see that `eve` (orange) and My (white) PVs are more similar than either of ours is to `bob`'s. This
means we're more likely to want to spend time and get to know each other than either of us does to Bob.

<div id='otherPeople'></div>
<script>
Plotly.d3.csv('https://www.yangvincent.com/assets/pv1.csv', function(err, rows){
    function unpack(rows, key) {
        return rows.map(function(row) 
        { return row[key]; }); 
    }
          
	var x = unpack(rows , 'x');
	var y = unpack(rows , 'y');
	var z = unpack(rows , 'z'); 
	var c = unpack(rows , 'color');
	Plotly.newPlot('otherPeople', [{
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
			autosize: true,
			margin: {
				l: 5,
				r: 5,
				b: 5,
				t: 5,
			}
	});
});
</script>

--- 

### More math details

* We constrain to an `$l_2$ space` to allow for infinite-sized preference vectors while maintaining that the cross product is finite. This is important
because differences between people must be comparable. Being "infinitely close" to my best friend as well as to my significant other isn't a meaningful comparison.
