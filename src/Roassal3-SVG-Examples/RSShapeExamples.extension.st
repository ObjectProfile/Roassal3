Extension { #name : #RSShapeExamples }

{ #category : #'*Roassal3-SVG-Examples' }
RSShapeExamples >> example03LinePath [
	<script: 'self new example03LinePath open'>

	| canvas shapes form paint line path |
	canvas := RSCanvas new.
	form := self iconNamed: #remote.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	shapes := #(-1 1 ) collect: [ :m |
		RSBox new
			size: form extent x;
			paint: paint;
			position: m * 50 asPoint;
			draggable;
			yourself
		].
	path := [ :aLine | String streamContents: [ :s|
		| point number vector u unit middle middle2 l r a b |
		a := aLine startPoint.
		b := aLine endPoint.
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
	line := [:m | RSSVGPathLine new
		borderColor: (m alpha: 0.4);
		svgPath: path;
		width: 4;
		capRound;
		yourself].
	canvas add: ((line value: Color red)
		from: shapes first;
		to: shapes second).
	canvas add: ((line value: Color blue)
		from: shapes second;
		to: shapes first).
	canvas addAll: shapes.
	canvas camera scale: 1.
	^ canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSShapeExamples >> example06JoinStyles [
	<script: 'self new example06JoinStyles open'>
	| canvas line path styles |
	canvas := RSCanvas new.
	path := [ :aLine | String streamContents: [ :s| 
		| mid number point a b |
		a := aLine startPoint.
		b := aLine endPoint.
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
	
	styles := #('joinMiter' 'joinRound' 'joinBevel').
	styles doWithIndex: [ :style :i|
		line := RSSVGPathLine new 
			svgPath: path;
			borderColor: Color gray;
			draggable;
			width: 25;
			from: ((i-2) * 80)@0;
			to: (((i-2) * 80) + 50)@0;
			perform: style asSymbol;
			yourself.
		canvas add: line.
		.
	].
	^ canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSShapeExamples >> example15BimetricLine [
	<script: 'self new example15BimetricLine open'>
	| canvas s1 s2 l |
	canvas := RSCanvas new.
	s1 := RSBox new
		color: Color blue;
		draggable;
		size: 100;
		yourself.
	s2 := RSBox new
		translateTo: 400@0;
		draggable;
		size: 100;
		yourself.
	l := RSBimetricLine new
		widthFrom: 50;
		widthTo: 10;
		paint: Color red;
		border: nil;
		withBorderAttachPoint;
		from: s1;
		to: s2;
		yourself.
	canvas addAll: { s1. s2. l}.
	canvas @ RSCanvasController. 
	^ canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSShapeExamples >> example18ExampleFromMondrian [
	<script: 'self new example18ExampleFromMondrian open'>
	| canvas legend |
	canvas := RSCanvas new.

	canvas addAll: (Collection withAllSubclasses collect: [:cls | 
		RSEllipse new
			draggable;
			model: cls;
			popup;
			color: Color red translucent;
			yourself]).
	RSNormalizer size
		from: 5;
		to: 50;
		shapes: canvas nodes;
		normalize: #numberOfMethods.
	RSLineBuilder line
		color: Color lightGray;
		shapes: canvas nodes;
		canvas: canvas;
		connectFrom: #superclass.
	RSForceBasedLayout on: canvas nodes.
	RSMultiBezierEdgeBuilder multiBezier
		borderColor: (Color blue alpha: 0.1);
		shapes: canvas nodes;
		canvas: canvas;
		tension: 0.7;
		following: #superclass;
		connectToAll: #dependentClasses.
	
	legend := (RSMultilineLabelBuilder new
		shapeFor: 'Circle = classes, size = number of methods; gray links = inheritance;
blue links = dependencies; layout = force based layout on the inheritance links')
		padding: 10;
		withBorder;
		yourself.
	RSLocation new
		below;
		offset: 10;
		move: legend on: canvas nodes.
	canvas add: legend.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSShapeExamples >> example25BimetricLineOnLargeExample [
	<script: 'self new example25BimetricLineOnLargeExample open'>
	| packagesRegExp packages l packageElements high canvas |
	packagesRegExp := { 'Calypso*' }.
	
	packages := packagesRegExp flatCollect: [ :regExp | 
		RPackageOrganizer default packages 
			select: [ :p | regExp match: p packageName ] ].
		
	l := RSLabeledInteraction new text: [ :model | model packageName ].
	packageElements  := packages collect: [ :pkg | | shapes |
		shapes := pkg definedClasses collect: [ :cls |
			RSBox new
				color: Color black;
				size: cls numberOfMethods sqrt;
				yourself
			 ].
		RSGridLayout on: shapes.
		RSComposite new
			color: Color blue translucent;
			model: pkg;
			addInteraction: l;
			draggable;
			shapes: shapes;
			padding: 5;
			yourself ] as: RSGroup.
	high := RSHighlightableInteraction new.
	high withLines.
	high highlightColor: Color red translucent.							
	packageElements @ high.						
	canvas := RSCanvas new.
	canvas addAll: packageElements.

	RSLineBuilder bimetricLine
		canvas: canvas;
		objects: packages;
		noBorder;
		widthFrom:[ :edge | (edge key numberOfDependenciesToward: edge value) sqrt * 4 ];
		widthTo:[ :edge | (edge value numberOfDependenciesToward: edge key) sqrt * 4 ];
		paint: Color blue translucent;
		withBorderAttachPoint;
		connectFrom: #yourself toAll: #dependentPackages.
	RSWeightedCircleLayout new initialRadius: 300; on: packageElements.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSShapeExamples >> example25BisBimetricLineOnLargeExample [
	<script: 'self new example25BisBimetricLineOnLargeExample open'>
	"Same than example25BimetricLineOnLargeExample, but with no label"
	| packagesRegExp packages packageElements high canvas |
	packagesRegExp := { 'Calypso*' }.
	
	packages := packagesRegExp flatCollect: [ :regExp | 
		RPackageOrganizer default packages 
			select: [ :p | regExp match: p packageName ] ].
		
	packageElements  := packages collect: [ :pkg | | shapes |
		shapes := pkg definedClasses collect: [ :cls |
			RSBox new
				color: Color black;
				size: cls numberOfMethods sqrt;
				yourself
			 ].
		RSGridLayout on: shapes.
		RSComposite new
			color: Color blue translucent;
			model: pkg;
			draggable;
			shapes: shapes;
			padding: 5;
			yourself ] as: RSGroup.
	high := RSHighlightableInteraction new.
	high withLines.
	high highlightColor: Color red translucent.							
	packageElements @ high.						
	canvas := RSCanvas new.
	canvas addAll: packageElements.

	RSLineBuilder bimetricLine
		canvas: canvas;
		objects: packages;
		noBorder;
		widthFrom:[ :edge | (edge key numberOfDependenciesToward: edge value) sqrt * 4 ];
		widthTo:[ :edge | (edge value numberOfDependenciesToward: edge key) sqrt * 4 ];
		paint: Color blue translucent;
		withBorderAttachPoint;
		connectFrom: #yourself toAll: #dependentPackages.
	RSWeightedCircleLayout new initialRadius: 300; on: packageElements.
	canvas @ RSCanvasController.
	^ canvas
]
