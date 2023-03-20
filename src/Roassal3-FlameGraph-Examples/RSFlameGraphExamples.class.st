Class {
	#name : #RSFlameGraphExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-FlameGraph-Examples'
}

{ #category : #examples }
RSFlameGraphExamples >> example01FileSystem [
	<script: 'self new example01FileSystem open'>

	| builder colorPalette |
	builder := RSFlameGraph new.
	builder boxShape
		cornerRadius: 0;
		border: (RSBorder new
			color: Color black translucent;
			width: 0.1;
			yourself).
	builder
		graphWidth: 150;
		gap: 0.5 asPoint;
		boxHeight: 4;
		leafWeight: [ :f | f size sqrt ];
		explore: FileSystem workingDirectory
			nesting: #directories
			leaves: #files.
	builder build.
	builder shapes @ RSDraggable.
	builder shapes @ (RSPopup text: [:f | f basenameWithIndicator, String crlf, f humanReadableSize ]).
	colorPalette := NSScale google20.
	builder shapes do: [ :box |
		box color: (colorPalette scale: box model extension) ].

	"Add legend for file extensions"
	RSLegend new
		title: 'Legend';
		text: '- Rectangle: file or directory';
		text: '- Width: sqrt of file size';
		text: '- Color: file extension';
		legendDo: [ :l | l scaleBy: 0.5 ];
		container: builder canvas;
		build.

	^ builder canvas
		addInteraction: RSCanvasController new;
		yourself
]

{ #category : #examples }
RSFlameGraphExamples >> example02FileSystem [
	<script: 'self new example02FileSystem inspect'>

	| builder |
	builder := RSFlameGraph new.
	builder boxShape
		color: Color veryLightGray;
		cornerRadius: 2.
	builder
		graphWidth: 1000;
		leafWeight: [ :f | f size ];
		explore: FileSystem workingDirectory
			nesting: #directories
			leaves: #files.
	builder build.
	builder shapes
		@ RSDraggable;
		@ (RSPopup text: [:f | f basenameWithIndicator, String crlf, f humanReadableSize ]);
		@ (RSHighlightable new highlightBorder: (RSBorder new color: Color black)).

	"Add labels to rectangles, when they fit inside."
	builder shapes do: [ :shape |
		| location labelBuilder label |
		location := RSLocation new middle; inner; left; offset: 5@0; yourself.
		labelBuilder := RSMultilineLabelBuilder new
			wrapStrategy: (RSWrapEllipsisStrategy new wrapMaxWidth: shape width - 10);
			yourself.
		labelBuilder labelShape color: Color black.
		label := labelBuilder shapeFor: shape model basenameWithIndicator.
		location stick: label on: shape.
		(label width > 25 and: [ (label width+5) < shape width ]) ifTrue: [
			builder canvas addShape: label ] ].

	^ builder canvas
		addInteraction: RSCanvasController new;
		yourself
]
