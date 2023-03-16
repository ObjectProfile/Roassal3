"
This uses a wrapMaxWidth and creates a multiline label
"
Class {
	#name : #RSWrapStrategy,
	#superclass : #RSAbstractWrapStrategy,
	#category : #'Roassal3-Builders-Text'
}

{ #category : #hooks }
RSWrapStrategy >> wordsAndSpacesFor: aString [
	| tokens flag isWord i |
	tokens := OrderedCollection new.
	isWord := nil.
	i := 1.
	aString doWithIndex: [ :char :index |
		flag := char tokenish.
		isWord ifNil: [ isWord := flag ].
		isWord = flag ifFalse: [
			tokens add: (aString copyFrom: i to: index-1).
			i := index.
			isWord := flag.
			].
		].
	tokens add: (aString copyFrom: i to: aString size).
	^ tokens
]

{ #category : #hooks }
RSWrapStrategy >> wrapLineShapesFor: line with: aRSMultilineLabelBuilder [
	| label tokens newLines i currentLine width lastLabel |
	label := aRSMultilineLabelBuilder
		singleLabelFor: line.
	width := self wrapMaxWidth.
	label width < width
		ifTrue: [ ^ { label } ].
	tokens := self wordsAndSpacesFor: line.
	newLines := OrderedCollection new.
	i := 1.
	lastLabel := nil.
	currentLine := ''.
	[ i <= tokens size ] whileTrue: [
		| token |
		token := tokens at: i.
		label := aRSMultilineLabelBuilder
			singleLabelFor: currentLine, token.
		label width > width
			ifTrue: [
				lastLabel ifNil: [
					| k ok |
					token := label text.
					k := token size - 1.
					ok := false.
					[ k > 1 and: [ ok not ] ] whileTrue: [
						lastLabel := aRSMultilineLabelBuilder
							singleLabelFor: (token copyFrom: 1 to: k).
						lastLabel width < width ifTrue: [
							ok := true.
							] ifFalse: [ k := k - 1 ] .
					].
					newLines add: lastLabel.
					tokens at: i put: (token copyFrom: k+1 to: token size).
				 ] ifNotNil: [
					newLines add: lastLabel.
					currentLine := ''.
					lastLabel := nil
				 ].
			] ifFalse: [
				currentLine := label text.
				lastLabel := label.
				i := i + 1 ]
	].
	currentLine ifNotEmpty: [
		newLines add: (aRSMultilineLabelBuilder
			singleLabelFor: currentLine). ].

	^ newLines
]

{ #category : #hooks }
RSWrapStrategy >> wrapTextFor: aString with: aRSMultilineLabelBuilder [
	| lines shapes |
	lines := aString lines.
	shapes := lines flatCollect: [ :line |
		self wrapLineShapesFor: line with: aRSMultilineLabelBuilder ]
		as: RSGroup.
	aRSMultilineLabelBuilder layout on: shapes.
	^ shapes asShape
		position: 0@0;
		yourself
]
