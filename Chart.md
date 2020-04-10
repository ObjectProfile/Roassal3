# Tutorial 03 - Charting 

Here is another tutorial for [Roassal3](https://github.com/ObjectProfile/Roassal3). The topic of this tutorial is charting. It will gently introduce the charting library Roassal3 offers through some contrivied example at first, and then visualize a real dataset.

## Some simple charts

Consider the following script:

```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.

c := RSChart new.
p := RSLinePlot new x: x y: y.
c addPlot: p.

c
```

The result of the script is given by the figure:
![alt text](screenshots/chart01.png)

We will now review the script line by line. The first two lines define the data, expressed with the two variables `x` and `y`, we wish to visualize. Remember that the message `to:by:` defined a collection of 63 numerical values, ranging from incremental values ranging from `-3.14` to `3.14`, using `0.1` step.

The class `RSChart` is a container of plots. 


