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
RSBarChartExample >> example03TilePaint [
	<script: 'self new example03TilePaint open'>
	
	| data x paintBlock c lb size labels |
	data := { 
		{  10. 9 }.
		{ 20. 15 }.
		{ 11. 7 }.
		{ 30. 25 } }.
	x := 1 to: 2.

	paintBlock := [ :aColor | 
		| tileCanvas e morph paint |
		tileCanvas := RSCanvas new.
		e := 10@10.
		
		tileCanvas add: (RSBox new color: aColor; extent: e; yourself).
		tileCanvas add: (RSEllipse new 
			color: Color black; 
			extent: e / 4; 
			position: e / 4;
			yourself).
		tileCanvas add: (RSEllipse new 
			color: Color black; 
			extent: e / 4;
			position: e / -4;
			yourself).
		morph := tileCanvas createMorph.
		morph extent: e*(1@0.75).
		morph drawOnMockCanvas.
		paint := AthensCairoPatternSurfacePaint createForSurface: morph surface.
		paint repeat.
		paint ].

	c := RSChart new.
	c extent: 300@ 200.
	lb := RSLegend new.
	lb container: c canvas.
	size := 25.

	lb title: 'Nerd?'.
	lb text: 'Not nerd' withBoxColor: Color gray.
	lb text: 'Nerd' withBoxColor: (paintBlock value: Color gray).
	lb text: ' '.
	labels := #('<5' '5-10' '10-20' '>20').
	lb title: 'Study Time'.

	data doWithIndex: [ :serie :index | 
		| plot color |
		c addPlot: (plot := RSBarPlot new x: x y: serie).
		color := plot computeColor.
		index even
			ifTrue: [ plot color: (paintBlock value: color) ].
		plot barSize: size .
		plot barOffset: ((index-(data size +1/ 2)) * size).
		lb text: (labels at: index) withBoxColor: color.
		].

	c addDecoration: (RSHorizontalTick new fromNames: #(Math Science); labelRotation: 0 ).
	c addDecoration: (RSVerticalTick new numberOfTicks: 5).
	c ylabel: 'Number of students'.
	c xlabel: 'Class'.
	c build.
	lb legendDo: [ :shape | shape scaleBy: 0.6 ].
	lb location right; middle; offset: 10@0.
	lb build.

	^ c canvas
]
