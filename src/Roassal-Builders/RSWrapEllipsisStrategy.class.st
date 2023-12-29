"
Basic ellipsis for a single line text
"
Class {
	#name : 'RSWrapEllipsisStrategy',
	#superclass : 'RSAbstractWrapStrategy',
	#category : 'Roassal-Builders-Text',
	#package : 'Roassal-Builders',
	#tag : 'Text'
}

{ #category : 'accessing' }
RSWrapEllipsisStrategy >> ellipsis [
	^ '...'
]

{ #category : 'hooks' }
RSWrapEllipsisStrategy >> wrapTextFor: aString with: aRSMultilineLabelBuilder [
	| width lines label currentTextWithEllipsis currentText ellipsis |
	lines := aString lines.
	lines size > 1 ifTrue: [ self error: 'Not supported for multiline' ].
	width := self wrapMaxWidth.
	ellipsis := self ellipsis.
	currentText := currentTextWithEllipsis := aString.

	[label := aRSMultilineLabelBuilder singleLabelFor: currentTextWithEllipsis.
	label width > width and: [ currentText isNotEmpty ] ] whileTrue: [
		currentText := currentText copyFrom: 1 to: currentText size - 1.
		currentTextWithEllipsis := currentText , ellipsis.
	].

	^ label
]
