Class {
	#name : #RSBlocExamples,
	#superclass : #Object,
	#category : #'Roassal3-Bloc'
}

{ #category : #examples }
RSBlocExamples >> example01Boxes [
	<script: 'self new example01Boxes'>
	
	| c |
	c := RSCanvas new.
	c useBlocHost.

	c addShape: (RSBox new
		extent: 100@100;
		yourself).
	c addShape: (RSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).

	c open.

]

{ #category : #examples }
RSBlocExamples >> example02Ellipse [
	<script: 'self new example02Ellipse'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

	c addShape: (RSEllipse new
			 extent: 100 @ 100;
			 yourself).
	c addShape: (RSEllipse new
			 position: 100 @ 100;
			 color: Color red;
			 extent: 100 @ 100;
			 yourself).

	c open
]

{ #category : #examples }
RSBlocExamples >> example03RotatedBoxes [
	<script: 'self new example03RotatedBoxes'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

	1 to: 12 do: [ :m |
		| angle theta p box |
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		box := RSBox new
			size: 90@45;
			yourself.
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270)
			ifTrue: [ 180 ]
			ifFalse: [ 0 ] ).

		box rotateByDegrees: angle.
		box position: p + ((box baseRectangle width/2) * theta).

		c addShape: box.
		].
	c addShape: (RSEllipse new
		color: nil;
		withBorder;
		radius: 90).

	c open.

]

{ #category : #examples }
RSBlocExamples >> example04RotatedLabels [
	<script: 'self new example04RotatedLabels'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

		1 to: 12 do: [ :m |
			| angle theta p label |
			angle := (m * 360 / 12) degreesToRadians.
			theta := angle cos @ angle sin.
			p := theta * 100.
			label := RSLabel new
				color: (Color purple alpha: 0.5);
				fontName: 'Arial';
				fontSize: 40;
				text: (Month nameOfMonth: m);
				yourself.
			angle := angle radiansToDegrees.
			angle := angle + ((angle between: 90 and: 270)
				ifTrue: [ 180 ]
				ifFalse: [ 0 ] ).

			label rotateByDegrees: angle.
			label position: p + ((label textWidth/2) * theta).
			m even
				ifTrue: [ label bold ]
				ifFalse: [ label italic ].
			c addShape: label.
			].
		c addShape: (RSEllipse new
			color: nil;
			withBorder;
			radius: 90).

	c open.

]

{ #category : #examples }
RSBlocExamples >> example05Ellipses [
	<script: 'self new example05Ellipses'>

	| c r y |
	c := RSCanvas new.
	c useBlocHost.

	r := Random new.
	c color: (Color colorFrom: '325A64').
	1 to: 500 do: [ :x|
		y := 255 + (x sin * 255).
		c addShape: (RSEllipse new
			color: Color transparent;
			border: (RSBorder new
				width: x/ 50;
				color: (Color
					r: r next * 255
					g: r next * 200
					b: 255
					range: y) );
			position: (x*2@y)-250;
			extent: (y/10)@( x * 75/ 499 ) ).
		 ].


	c open.

]

{ #category : #examples }
RSBlocExamples >> example06Polyline [
	<script: 'self new example06Polyline'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

	c addShape: (RSPolyline new
		width: 30;
		joinRound;"joinBevel; joinMiter"
		color: Color blue;
		controlPoints: { 50@300. 150@300. 150@200. 250@200. 250@100. 350@100};
		basicTranslateBy: -150 @ -150;
		yourself).


	c open.

]

{ #category : #examples }
RSBlocExamples >> example07MouseMove [
	<script: 'self new example07MouseMove'>

	| c size circles |
	c := RSCanvas new.
	c useBlocHost.

	size := 200.
	c addAll: (circles := #(magenta yellow red cyan) collect: [ :sel | 
	    c add: (RSEllipse new
	        size: size;
	        color: ((Color perform: sel) alpha: 0.4 );
	        yourself).
	    ]).
	c when: RSMouseMove do: [ :evt | 
		| posOffset negOffset |
	    posOffset := (evt position distanceTo: 0@0).
	    negOffset := posOffset negated.
	    circles first position: posOffset @ 0.
	    circles second position: 0 @ posOffset.
	    circles third position: negOffset @ 0.
	    circles fourth position: 0@negOffset.

		c signalUpdate ].
		
	c open.

]

{ #category : #examples }
RSBlocExamples >> example08ZoomToFitWhenExtentChangedEvent [
	<script: 'self new example08ZoomToFitWhenExtentChangedEvent'>

	| canvas |
	canvas := RSCanvas new.
	canvas useBlocHost.

	canvas add: (RSBox new
			 color: Color blue;
			 position: 100 asPoint;
			 size: 5000@3000;
			 yourself).

	canvas when: RSExtentChangedEvent do: [ :event |
		canvas zoomToFit.
		canvas signalUpdate ].
	
	canvas open
]

{ #category : #examples }
RSBlocExamples >> example09HierarchyWithCanvasController [
	<script: 'self new example09HierarchyWithCanvasController'>

	| canvas color shapes |
	canvas := RSCanvas new.
	canvas useBlocHost.

	color := NSScale linear
	    domain: { 1. 200. 400 };
	    range: #(white gray red).

	shapes := String withAllSubclasses collect: [ :cls |
	    RSBox new
	        model: cls;
	        color:( color scale: cls numberOfMethods );
	        size: cls linesOfCode sqrt + 10;
	        yourself
	     ].
	canvas addAll: shapes.

	RSLineBuilder orthoVertical
	    withVerticalAttachPoint;
	    shapes: shapes;
	    connectFrom: #superclass.

	RSTreeLayout on: shapes.

	canvas addInteraction: RSCanvasController new.
	canvas open.


]
