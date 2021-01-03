Class {
	#name : #RSBoxPlotExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Chart-Examples'
}

{ #category : #examples }
RSBoxPlotExample >> example01 [
	"A simple boxplot"
	<script: 'self new example01 open'>
	| c p x y bottom |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) + 2.
	bottom := x + 2. 
	c := RSChart new.
	p := RSBoxPlot new x: x y: y.
	p bottom: bottom.
	
	c addPlot: p.
	
	c addDecoration: (RSHorizontalTick new 
		numberOfTicks: x size).
	c xlabel: 'X Axis'.
	c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
	c ylabel: 'Y Axis'.
	c title: 'Box Plot'.
	^ c 
]
