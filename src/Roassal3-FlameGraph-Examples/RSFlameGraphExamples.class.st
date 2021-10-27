Class {
	#name : #RSFlameGraphExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-FlameGraph-Examples'
}

{ #category : #examples }
RSFlameGraphExamples >> example01FileSystem [
	<script: 'self new example01FileSystem open'>

	| b color legend |
	b := RSFlameGraph new.
	b boxShape
		cornerRadius: 0;
		border: (RSBorder new color: Color black translucent; width: 0.1; yourself).
	b
		boxHeight: 5;
		leafWeight: [ :f | f size sqrt ];
		explore: FileSystem workingDirectory 
			nesting: #directories
			leaves: #files.
	b build.
	b shapes @ RSDraggable.
	b shapes @ (RSPopup text: [:f | f basename, String crlf, f humanReadableSize ]).
	color := NSScale google20.
	b shapes do: [ :box | 
		box color: (color scale: (box model extension) )].
	
	"Add legend for file extensions"
	legend := RSLegend new.
	(b shapes 
		collect: [ :box | box model extension ]
		as: Set)
		do: [ :each |
			legend text: each withBoxColor: (color scale: each) ].
	legend legendDo: [ :l | 
		l
			withBorder;
			scaleBy: 0.1;
			padding: 20 ].
	legend layout horizontal gapSize: 30.
	legend container: b canvas.
	legend build.

	^ b canvas
		addInteraction: RSCanvasController new;
		yourself.

]

{ #category : #examples }
RSFlameGraphExamples >> example02FileSystem [
	<script: 'self new example02FileSystem inspect'>

	| b  |
	b := RSFlameGraph new.
	b boxShape
		color: Color veryLightGray;
		cornerRadius: 3.
	b
		graphWidth: 1000;
		leafWeight: [ :f | f size ];
		explore: FileSystem workingDirectory 
			nesting: #directories
			leaves: #files.
	b build.
	b shapes 
		@ RSDraggable;
		@ (RSPopup text: [:f | f basename, String crlf, f humanReadableSize ]);
		@ (RSHighlightable new highlightBorder: (RSBorder new color: Color black)).
	
"	b shapes addInteraction: (RSLabel new
		shapeBuilder: [ :string | RSLabel new color: Color black; text: string ];
		locationDo: [ :loc | loc middle; inner; left; offset: 5@0 ];
		yourself).
"	
	b shapes do: [ :shape |
		| loc labelBuilder label |
		loc := RSLocation new middle; inner; left; offset: 5@0; yourself.
		labelBuilder := RSMultilineLabelBuilder new
			wrapStrategy: (RSWrapEllipsisStrategy new wrapMaxWidth: shape width - 10);
			yourself.
		labelBuilder labelShape color: Color black.
		label := labelBuilder shapeFor: shape model basename.
		loc stick: label on: shape.
		(label width > 25 and: [ (label width+5) < shape width ]) ifTrue: [ 
			b canvas addShape: label ] ].

	b canvas addInteraction: RSCanvasController new.

	^ b canvas

]
