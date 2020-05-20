[list of classes](reference.md)
# RSChart
`RSChart` is the main class to build charts.

*Responsibility*: maintain and render plots

*Collaborators*: a chart closely interact with plots and decorations. 

*Variables*:
- `plots`: the list of plots 
- `extent`: size of the produced chart. Note that this extent is for the area on which plots are draw. It does not comprise ticks and axis titles
- `decorations`: collection of decorations to annotate the chart
- `generator`: nice label generator, useful to have labels that are visually appealing
- `colors`: default color palette

*Example*:
Here is an example that adjust the font size used for the title, and axis labels:

```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.

c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 12).
c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 15; vertical).
c
```