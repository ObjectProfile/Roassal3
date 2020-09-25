"
I have examples of barcharts
"
Class {
	#name : #RSBarChartExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Chart-Examples'
}

{ #category : #examples }
RSBarChartExample >> example01TwoBars [
	<script: 'self new example01TwoBars open'>
	| c p p2 x y size |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSBarPlot new x: x y: y.
	size := 6.
	p barSize: size.
	p barOffset: size / 2.
	p2 := RSBarPlot new x: x y: y +0.5.
	p2 barSize: size.
	p2 barOffset: size / -2.
	c addPlot: p.
	c addPlot: p2.
	c build.
	p bars @ RSPopup.
	p2 bars
		when: RSMouseEnter do: [ :evt |
			| color |
			color := Color random.
			p2 bars do: [ :shape | shape color: color ].
			evt signalUpdate.
		 ].
	^ c canvas
]

{ #category : #examples }
RSBarChartExample >> example02TwoHorizontalBars [
	<script: 'self new example02TwoHorizontalBars open'>
	| c p p2 x y size lb |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSHorizontalBarPlot new x: y y: x.
	size := 5.
	p barSize: size.
	p barOffset: size / 2.
	p2 := RSHorizontalBarPlot new x: y +0.5 y: x.
	p2 barSize: size.
	p2 barOffset: size / -2.
	c addPlot: p.
	c addPlot: p2.
	c build.
	p bars , p2 bars @ RSPopup.
	lb := RSLegend new.
	lb container: c canvas.
	lb text: 'Series1' withBoxColor: p computeColor.
	lb text: 'Series2' withBoxColor: p2 computeColor.
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -10.
	lb build.
	^ c canvas
	
]

{ #category : #examples }
RSBarChartExample >> example03Heroes [
	<script: 'self new example03Heroes open'>
	| experience x c |
	experience := { 10. 20. 30. 100 }.
	x := 1 to: 4.

	c := RSChart new.
	c addPlot: (RSBarPlot new x: x y: experience ).
	c addDecoration: (RSHorizontalTick new
		fromNames: #(Kael Legion Luna Ember); 
		labelRotation: 0;
		yourself ).
	c addDecoration: (RSVerticalTick new integer).
	^ c  
]
