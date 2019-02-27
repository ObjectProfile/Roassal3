"
I use the RSShapeBuilder
"
Class {
	#name : #RoassalShapeExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #shapes }
RoassalShapeExamples >> example01Basic [
	<script: 'self new example01Basic'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		onElement;
		color: [ :e | e index even 
			ifTrue: [ Color red ]
			ifFalse: [ Color blue ] ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	v open
]

{ #category : #shapes }
RoassalShapeExamples >> example02Basic [
	<script: 'self new example02Basic'>

	| v box box1 line |
	v := RSView new.
	box := RSShapeBuilder box
		size: 100;
		interactionDo: [ :i | i draggable ].
	box1 := box element.
	box1 translateBy: 150@150.
	v add: box1.
	line := RSEdgeBuilder line 
		color: Color red.
	v add: (line from: box1; to: 0@0; edge).

	v open
	



]

{ #category : #layouts }
RoassalShapeExamples >> example03LayoutBasic [
	<script: 'self new example03LayoutBasic'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		onElement;
		color: [ :e | e index even 
			ifTrue: [ Color red alpha: 0.5 ]
			ifFalse: [ Color blue alpha: 0.5 ] ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RTGridLayout on: elements children.
	v open
	
]

{ #category : #layouts }
RoassalShapeExamples >> example04LayoutBasic [
	<script: 'self new example04LayoutBasic'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		elementsOn: (Collection withAllSubclasses).

	v addAll: elements.
	RTGridLayout on: elements children.
	v open
	
]

{ #category : #lines }
RoassalShapeExamples >> example05Basic [
	<script: 'self new example05Basic'>

	| v elements form paint line path |
	v := RSView new.
	form := self iconNamed: #remote.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	elements := RSShapeBuilder box
		size: form extent x;
		paint: paint;
		position: [:m | m * 50 asPoint ];
		interactionDo: #draggable;
		elementsOn: {-1. 1}.
		
	path := [ :a :b | String streamContents: [ :s|
		| point number vector u unit middle middle2 l r |
		number := [ :n | 
			s nextPutAll: n asFloat asString ].
		point := [ :p | 
			number value: p x.
			s space.
			number value: p y.
			s space. ].
		vector := a - b.
		u := vector normal.
		unit := vector / vector r.
	
		1 to: 3 do: [ :i |
			middle := a - (unit * (i+1)* 5).
			middle2 := a - (unit * (i*2)*5).
			l := middle - (u * ((i-1) * 7)).
			r := middle + (u * ((i-0.9) * 7)).
			
			s nextPutAll: 'M'.
			point value: l. 
			s nextPutAll: 'Q '.
			point value: middle2.
			point value: r.
			].
		 ] ].
	line := RSEdgeBuilder linePath
		color: [:m | m alpha: 0.4];
		svgPath: [path];
		width: 4;
		capRound.
	v add: (line 
		from: elements first;
		to: elements second;
		edgeOn: Color red).
	v add: (line 
		from: elements second;
		to: elements first;
		edgeOn: Color blue).
	v addAll: elements.
	v camera scale: 1.
	v open
	
]

{ #category : #lines }
RoassalShapeExamples >> example06Basic [
	<script: 'self new example06Basic'>

	| v line |
	v := RSView new.
	line := RSEdgeBuilder line
		width: 1.
	"no dashes no gaps"
	v add: (line from: -15@ 1; to: 15@ 1; edge).
	"Dashes and gaps of the same size"
	line dashArray: { 4 }.
	v add: (line from: -15@ 3; to: 15@ 3; edge).
	"Dashes and gaps of different sizes"
	line dashArray: { 4. 1 }.
	v add: (line from: -15@ 5; to: 15@ 5; edge).
	"Dashes and gaps of various sizes with an odd number of values"
	line dashArray: { 4. 1. 2 }.
	v add: (line from: -15@ 7; to: 15@ 7; edge).
	"Dashes and gaps of various sizes with an even number of values"
	line dashArray: { 4. 1. 2. 3 }.
	v add: (line from: -15@ 9; to: 15@ 9; edge).
	v camera 
		scale: 10;
		position: 0@5.
	v open
	
]

{ #category : #lines }
RoassalShapeExamples >> example07Basic [
	<script: 'self new example07Basic'>

	| v line dot d1 d2 ed styles |
	v := RSView new.
	line := RSEdgeBuilder line
		color: Color lightGray;
		width: 20.
	dot := RSShapeBuilder circle
		interactionDo: #draggable;
		color: Color darkGray;
		position: #yourself;
		radius: 5.
	styles := #('capButt' 'capRound' 'capSquare').
	styles doWithIndex: [ :style :i|
		d1 := dot elementOn: -100@(i*30).
		d2 := dot elementOn: 100@(i*30).
		line perform: style asSymbol.
		ed := line from: d1; to: d2; edge.
		v add: ed; add: d1; add: d2.
		 ].
	
	v open
	
]

{ #category : #lines }
RoassalShapeExamples >> example08Basic [
	<script: 'self new example08Basic'>

	| v line path styles |
	v := RSView new.
	path := [ :a :b| String streamContents: [ :s| 
		| mid number point |
		number := [ :n | 
			s nextPutAll: n asFloat asString ].
		point := [ :p | 
			number value: p x.
			s space.
			number value: p y.
			s space. ].
		
		mid := (a + b)/2 + (0@ -50).
		s nextPutAll: 'M'.
		point value: a.
		s nextPutAll: 'L'.
		point value: mid.
		s nextPutAll: 'L'.
		point value: b.
		 ] ].
	
	line := RSEdgeBuilder linePath
		svgPath: [ path ];
		color: Color lightGray;
		width: 25.
	styles := #('joinMiter' 'joinRound' 'joinBevel').
	styles doWithIndex: [ :style :i|
		line perform: style asSymbol.
		v add: (line
			from: ((i-2) * 80)@0;
			to: (((i-2) * 80) + 50)@0;
			edge).
	].
	
	v open
	
]

{ #category : #layouts }
RoassalShapeExamples >> example09LayoutColorFadingBasic [
	<script: 'self new example09LayoutColorFadingBasic'>

	| v elements color |
	v := RSView new.
	color := TSScale linear
		domain: #(1 20);
		range: {Color red. Color green}.
		
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		onElement;
		color: [ :e | color scale: e index ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RTGridLayout on: elements children.
	v open
	
]

{ #category : #layouts }
RoassalShapeExamples >> example10LayoutColorFadingBasic2 [
	<script: 'self new example10LayoutColorFadingBasic2'>

	| v elements color |
	v := RSView new.
	color := TSScale linear
		domain: #(1 10 20);
		range: { Color red. Color green. Color blue }.
		
		
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		color: [ :m |color scale: m ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RTGridLayout on: elements children.
	v open
	
]

{ #category : #layouts }
RoassalShapeExamples >> example11LayoutBasicWithColorFading [
	<script: 'self new example11LayoutBasicWithColorFading'>

	| v elements minAndMax color |
	v := RSView new.
	minAndMax := Collection withAllSubclasses inject: { 10000 . 0 } into: [ :res :cls | {res first min: cls numberOfMethods . res second max: cls numberOfMethods}].
	color := TSScale linear
		domain: minAndMax;
		range: { Color green . Color red }.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		color: [ :cls | color scale: cls numberOfMethods ];
		elementsOn: (Collection withAllSubclasses).

	v addAll: elements.
	RTGridLayout on: elements children.
	v open
	
]

{ #category : #normalizer }
RoassalShapeExamples >> normalize01Color [
	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		elementsOn: (Collection withAllSubclasses).

	RSNormalizer color
		elements: elements;
		normalize: #numberOfMethods.

	v addAll: elements.
	RTGridLayout on: elements children.

	v camera position: v elements encompassingRectangle center.
	
	
	v open
	
]
