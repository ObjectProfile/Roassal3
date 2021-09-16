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
	^ b canvas.
	
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
