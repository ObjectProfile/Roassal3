Extension { #name : #RSAnimationExamples }

{ #category : #'*Roassal3-SVG-Examples' }
RSAnimationExamples >> example04Phyco [
	<script: 'self new example04Phyco open'>
	| update canvas theta slices unit color sc1 sc2 |
	canvas := RSCanvas new.
	slices := 50.
	unit := Float pi * 2 / slices.
	"domain: aBoolean, range: aColor"
	color := NSScale ordinal rangeFrom: { '480D4A'. 'BB1C60' }.
	"input: a number between {-1 1} ouput: a number between 100 and 350"
	sc1 := NSScale linear domain: #(-1 1);range: { 100. 350 }.
	sc2 := NSScale linear domain: #(-1 1);range: { 350. 100 }.
	"for zoom to fit"
	canvas add: (RSBox new extent: 800@800; noPaint; yourself).
	theta := 0.
	update := [
		canvas edges copy do: #remove.
		1 to: slices do: [ :i | | line sz  |
			line := RSSVGPathLine new
				model: i;
				yourself.
			sz := i even
				ifTrue: [ sc1 scale: (i *unit + theta) sin ]
				ifFalse: [ sc2 scale: (line model*unit - theta) sin ].
			line
				width:  sz /2;
				borderColor: (color scale: i even);
				from: (i even
					ifTrue: [-25@ -25 ]
					ifFalse: [ 25@25 ]);
				to: 0@0.
			line svgPath: [ :theLine |
				"this block returns a block to use complex operations of Athens Canvas"
				"in this part you can also return a string, the svg path"
				[ :pathBuilder |
					| angle a |
					a := theLine startPoint.
					angle := i * unit.
					pathBuilder
						moveTo: a + (sz * (angle cos@ angle sin));
						arcCenterX: a x
							centerY: a y
							radius: sz
							startAngle: line model* unit
							endAngle: (line model+1)*unit
					 ] ].
			canvas add: line.
		].
	].
	canvas when: RSMouseClick do: [ :evt | canvas edges inspect ].
	canvas newAnimation repeat onStepDo: [ :t |
		update value.
		theta := theta + 0.0523 ].
	canvas when: RSExtentChangedEvent do: [ :evt |
		canvas zoomToFit ].
	^ canvas
]
