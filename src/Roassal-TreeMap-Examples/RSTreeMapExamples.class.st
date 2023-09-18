"
I have examples for RSTreeMap
"
Class {
	#name : #RSTreeMapExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-TreeMap-Examples'
}

{ #category : #examples }
RSTreeMapExamples >> example01Numbers [
	<script: 'self new example01Numbers open'>
	| b |
	b := RSTreeMap new.
	b boxShape color: Color black translucent.
	b from: (1 to: 5) using: [ #() ].
	b modelWeight: #yourself.
	^ b
]

{ #category : #examples }
RSTreeMapExamples >> example02Numbers [
	<script: 'self new example02Numbers open'>
	| b |
	b := RSTreeMap new.
	b boxShape borderColor: Color black.
	b extent: 400@400;
		explore: 1
		using: [ :n | n< 8 ifTrue: [ Array with: n + 1 with:  n + 2 ] ifFalse: [ #() ] ];
		modelWeight: [ :n | n ].
	b build.
	b shapes do: [ :each |
		each color: (each model even
			ifTrue: [ 'lightGray' ]
			ifFalse: [ 'purple' ] ).
		each color: each color translucent. ].
	^ b canvas
]

{ #category : #examples }
RSTreeMapExamples >> example03Labels [
	<script: 'self new example03Labels open'>
	| b labels |
	b := RSTreeMap new.
	labels := #('uno' 'dos' 'tres' 'cuatro' 'cinco' 'cent mille').
	b boxShape color: Color veryLightGray.
	b from: labels using: [ #() ].
	b modelWeight: [ :n | n size ].
	b build.
	b shapes @ (RSLabeled new
		in: [ :lbl | lbl location middle ];
		yourself).
	^ b canvas
]

{ #category : #examples }
RSTreeMapExamples >> example04CollectionSubclasses [
	<script: 'self new example04CollectionSubclasses open'>
	| b |
	b := RSTreeMap new.
	b
		explore: Collection
		using: #subclasses;
		leafWeight: #numberOfLinesOfCode.
	b build.
	b shapes do: [ :shape | | cls name |
		cls := shape model.
		name := ByteSymbol streamContents: [ :s | s << cls name; << 'Test'].
		(Smalltalk globals includesKey: name)
			ifTrue: [ shape color: Color green translucent ].
		cls hasAbstractMethods
			ifTrue: [ shape color: Color blue translucent ].
		 ].
	^ b canvas
]

{ #category : #examples }
RSTreeMapExamples >> example05FileSystem [
	<script: 'self new example05FileSystem open'>
	| b color max |
	b := RSTreeMap new.
	b boxShape
		color: Color transparent;
		borderColor: Color black.
	b
		leafWeight: [ :f | f size sqrt ];
		explore: FileSystem workingDirectory
			nesting: #directories
			leaves: #files.
	b build.
	b shapes @ (RSPopup text: [:f | f basename, String crlf, f humanReadableSize ]).
	max := (b shapes
		select: [ :box | box isSLeaf ]
		thenCollect: [ :box | b weightOf: box ]) max.
	color := NSScale linear
		domain: {0. max};
		range: #(gray red).
	b shapes
		select: [ :box | box isSLeaf ]
		thenDo: [ :box |
			box color: (color scale: (b weightOf: box) )].
	^ b canvas
]

{ #category : #examples }
RSTreeMapExamples >> example06FitText [
	<script: 'self new example06FitText open'>
	| b canvas color |
	b := RSTreeMap new.
	b boxShape
		color: Color white.
	b
		extent: 800 asPoint;
		leafWeight: #linesOfCode;
		explore: SequenceableCollection using: #subclasses.
	b build.
	b depthShadedBorder.
	canvas := b canvas.
	color := NSScale category20c.
	b shapes
		select: [ :box | box isSLeaf ]
		thenDo: [ :box | | label |
			label := RSLabel new
				text: box model;
				color: Color black;
				yourself.
			box color: ((color scale: box model superclass) alpha: 0.7).
			box width > box height
				ifTrue: [ label scaleBy: (box extent*0.95) / label extent ]
				ifFalse: [
					label
						rotateByDegrees: -90;
						scaleBy: (box extent transposed *0.95) / label extent transposed
					].

			RSLocation new
				inner;
				move: label on: box.
			canvas add: label.
			 ].

	^ canvas
]

{ #category : #examples }
RSTreeMapExamples >> example07Roassal [
	<script: 'self new example07Roassal open'>
	| b palette lb bag title |
	b := RSTreeMap new.
	b inset: 1 asPoint.
	b canvas color: (Color colorFrom: '#2d2f3c') lighter.
	b boxShape color: Color white.

	b
		leafWeight: [ :f | f size sqrt ];
		explore: (IceRepository registry
				detect: [ :each | each name = 'Roassal3' ]) location
			nesting: [:file | file directories
				reject: [ :dir | dir basename beginsWith: '.' ] ]
			leaves: #files.
	b build.
	palette := RSColorPalette qualitative flatui120.
	bag := b gradientFill: palette block: [ :model | model extension ].
	b shapes do: [ :shape | shape border: (RSBorder new width: 1/(shape propertyAt: #depth); color: Color black) ].

	"LEGEND"
	lb := RSLegend new.
	lb defaultLabel
		color: Color white;
		fontSize: 18;
		fontName: 'Gill Sans';
		bold;
		border: (RSBorder new color: Color black).
	lb defaultCircle
		border: (RSBorder new color: Color black).
	lb layout vertical gapSize: 0.
	lb container: b canvas.
	bag sortedCounts do: [ :assoc |
		(assoc value
			ifEmpty: [ lb
				text: (String streamContents: [ :stream | stream << assoc key asString<< ' directories' ])
				withCircleColor: Color veryVeryLightGray ]
			ifNotEmpty: [ lb
				text: (String streamContents: [ :stream | stream << assoc key asString << ' ' << assoc value << ' files' ])
				withCircleColor: (palette scale: assoc value) ]) model: assoc.
		 ].
	lb location left; middle; offset: -10@0.
	lb build.

	lb shapes @ (RSHighlightable
		showEdges: [:assoc | b shapes
			select: [:shape | shape model extension = assoc value ]
			thenCollect: [ :shape | shape model ] ]
		using: (RSBezier new
			color: Color red;
			width: 2;
			controlPointsController: RSShortestHorizontalCPController new;
			yourself)).
	title := RSLabel new
		text: 'Roassal3 Github Repository Directory';
		color: Color yellow;
		fontName: 'Gill Sans';
		bold;
		fontSize: 34;
		border: (RSBorder new color: Color black; width: 1.5).
	RSLocation new
		above; move: title on: b canvas shapes first.
	title addedIn: b canvas.
	^ b canvas
]
