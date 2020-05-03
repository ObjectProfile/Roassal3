# Tutorial 04 - Charting 

Here is another tutorial for [Roassal3](https://github.com/ObjectProfile/Roassal3). 

What you will learn in this tutorial: 
- create and visualize a chart from a given set of numbers found in a CSV file
- parse a CSV file using `DataFrame`

The problem we will solve in this tutorial is: _how to draw a chart from a set of values found in a CSV file_

The topic of this tutorial is charting. It will gently introduce the charting library Roassal3 offers through some contrivied example at first, and then visualize a real dataset.

## Simple example

Consider the following script:

```Smalltalk
x := -3.14 to: 3.14 count: 100.
y := x sin.

c := RSChart new.
p := RSLinePlot new x: x y: y.
c addPlot: p.

c
```

The result of the script is given by the figure:
![alt text](screenshots/chart01.png)

We will now review the script line by line. The first two lines define the data, expressed with the two variables `x` and `y`, we wish to visualize. Remember that the message `to:count:` defined a collection of 100 numerical values, ranging from `-3.14` to `3.14`.

The class `RSChart` is a container of plots. We add a new plot called `RSLinePlot` to the chart. The script ends with the value `c`, which visualizes the chart thanks to the Pharo inspector framework.


## Data frame



## Covid dataset
