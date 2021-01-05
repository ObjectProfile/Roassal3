"
Example plots making use of RSBoxPlot.
"
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

{ #category : #examples }
RSBoxPlotExample >> example02 [
	"This is a grouped boxplot, comparing two different datasets with the same x axis"
	<script: 'self new example02 open'>
	| c p p2 y y2 size x |
	
	x := { 'Day1'. 'Day2'. 'Day3' }.
	y := { { 1. 2. 3. 4. 5. } asSortedCollection. 
			 { 5. 6. 7. 5. 10. } asSortedCollection .
			 { 12. 12. 13. 14. 15. 24. } asSortedCollection }.
			
	y2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } asSortedCollection. 
			 { 1. 12. 7. 10. 11. 11. 15. 10. } asSortedCollection .
			 { 12. 12. 13. 15. 18. 20. 21. 24. } asSortedCollection }.

	c := RSChart new.
	p := RSBoxPlot new y: y.
	
	"size controls the width of the bars"
	size := 12.
	p barSize: size.
	p barOffset: size / 2.
	
	p2 := RSBoxPlot new y: y2.
	p2 barSize: size.
	p2 barOffset: size / -2.
	c addPlot: p.
	c addPlot: p2.
	c addDecoration: (RSHorizontalTick new fromNames: x).
	c addDecoration: (RSVerticalTick new integer).
	
	^ c
]
