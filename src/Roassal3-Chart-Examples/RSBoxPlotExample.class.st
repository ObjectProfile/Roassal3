Class {
	#name : #RSBoxPlotExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Chart-Examples'
}

{ #category : #examples }
RSBoxPlotExample >> example01 [
	"A simple boxplot"
	<script: 'self new example01 open'>
	| c p y |
	
	y := { { 1. 2. 3. 4. 5. } asSortedCollection. 
			 { 5. 6. 7. 5. 10. } asSortedCollection . 
			 { 12. 12. 13. 14. 15. 24. } asSortedCollection }. 
	c := RSChart new.
	p := RSBoxPlot new y: y.
	
	c addPlot: p.
	
	c addDecoration: (RSHorizontalTick new 
		numberOfTicks: y size).
	c xlabel: 'X Axis'.
	c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
	c ylabel: 'Y Axis'.
	c title: 'Box Plot'.
	^ c 
]
