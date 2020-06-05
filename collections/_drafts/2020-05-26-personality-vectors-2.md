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

Our world has infinite things I (or anyone) could possibly have an opinion on -- from dogs to japan to honesty. 
Let's call this `$I: \{$set of all interests$\} = \{$dog, japan, honesty, $...\}$`. Formally,

$$I: \{i_1, i_2, i_3, ...\}, |I| = \infty$$

As people (or animals), we have preferences about these things. That is, we have some opinion about how much we like each thing or not. We can scale these
preferences to a range from `$-1$ to $1$`, so things I really hate are closer to `$-1$` and things I love are closer to `$1$`. Let's suppose
my preferences for the interests listed above are:

* I like dogs, so `$0.6$`
* Japan is an amazing destination with rich culture, so `$0.9$`
* Honesty is almost always important, so `0.8`

Ordering this up with our above list, we get `$(0.6, 0.9, 0.8)$` are my preferences for 
`$\{$ dog, japan, honesty $\}$`. We'll forget the rest of my preferences for now for the sake of example. Formally, this is our **preference vector**. 

$$P: \{p_1, p_2, p_3, ...\}: p_i\ |\ i \in \mathbb{N}, -1 \leq p_i \leq 1$$

### What your PV means to you

As you interact with people, you implicitly score them for every attribute in `$I$`. This means if I know Alice `$A$` and Bob `$B$`,
I can rank them based on my PV.

Suppose Alice is my friend who is not a dog `$0$`, has never heard of Japan `$-0.2$`, and is very honest `$0.8$`. 
Bob is a dog `$1$` that lives in Japan `$0.8$`, but plays tricks and isn't very honest `$-0.7$`. Each of them has a position
on my PV. We can calculate each of their positions based off their attributes. Let's define the `Attribute vector $A$` and
use it to calculate the `Position`. The `$i$th` element on `A` is the attribute for the `$i$th` element on `I`.

$$A = \{a_1, a_2, a_3, ...\}, |A| = |I|$$

$$A_{A} = \{0, -0.2, 0.8\}$$

$$A_{B} = \{1, 0.8, -0.7\}$$

I can combine their values to a point on my P.

$$f(P, A) = \sum_{i-0}^{i=\infty}A_{i} \cdot P_{i} $$

$$f(P_v, A) = (0.6 \cdot 0) + (0.9 \cdot -0.2) + (0.8 \cdot 0.8) = 0.46$$

$$f(P_v, B) = (0.6 \cdot 1) + (0.9 \cdot 0.8) + (0.8 \cdot -0.7) = 0.76$$

I can also grade myself `$M$`.

$$f(P_v, M) = (0.6 \cdot 0) + (0.9 \cdot 0.4) + (0.8 \cdot 0.7) = 0.92$$


<div id='myDiv'></div>

<img src="{{ site.url }}/assets/images/preference-vectors/group-pv.png" alt="group-pv" style="background-color:#fff; padding: 5px 5px 5px 5px;"/>

You tend to want to interact with people higher than you on this range and avoid those lower than you on this range.

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
  x: [0.92],
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
    	x: 0.92,
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


### Other people's PVs

My preference vector is a reasonable summary of who I am as a person. At the same time, everyone else also has their own preference vectors.
For firm mathematical footing, we're working with these vectors in an `$l_2$` space.

I think Alice loves dogs, but has no interest in Japan. She also thinks being honest is pretty important. 
On the other hand, Bob is a monster who hates dogs, hates Japan, and is extremely dishonest.

$$PV_A=\{1, -0.3, 0.7\}$$

$$PV_B=\{-0.9, -0.4, -0.7\}$$

<div id='otherPeople'></div>
<script>
//Plotly.d3.csv('https://raw.githubusercontent.com/plotly/datasets/master/3d-line1.csv', function(err, rows){
Plotly.d3.csv('http://localhost:4000/assets/pv1.csv', function(err, rows){
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
  			height: 440
	});
});
</script>

We tend to want to spend more time with people who have similar preferences. That means the smaller the angle between our vectors,
the more similar our preferences are.

In the chart below, we can see that Alice (orange) and My (white) PVs are more similar than either of ours to Bob's. This
means we're more likely to want to spend time and get to know each other than either of us to Bob.

### Ranking People on our PVs

Not only do we have preferences, but we have the ability to rank how good we are fulfilling those preferences. For instance, if
I'm reasonably good at being honest `$0.5$` but someone else abides by radical candor `$1.0$`, then they'll be "higher up"
on my PV than myself.





# Figure out how to add plotly.
This is a plot.


