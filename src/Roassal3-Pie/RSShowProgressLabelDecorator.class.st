"
I put interactions on the shapes and a label for updating
"
Class {
	#name : #RSShowProgressLabelDecorator,
	#superclass : #RSAbstractPieDecorator,
	#instVars : [
		'labelShape',
		'progressLabel',
		'highlight'
	],
	#category : #'Roassal3-Pie-Decorators'
}

{ #category : #initialization }
RSShowProgressLabelDecorator >> initialize [
	super initialize.
	labelShape := RSLabel new.
	highlight := RSHighlightableInteraction new.
	highlight 
		highlightColor: [ :shape | shape color adjustBrightness: 0.08 ]; 
		when: RSHighlightEvent do: [ :evt | self updateLabel: evt shape ];
		when: RSUnHighlightEvent do: [ :evt | self updateLabel: nil ].
	
]

{ #category : #accessing }
RSShowProgressLabelDecorator >> labelShape [
	^ labelShape
]

{ #category : #updating }
RSShowProgressLabelDecorator >> progressFor: aShape [
	^ ((builder values at: aShape index) * 100 / builder totalSum) rounded
]

{ #category : #accessing }
RSShowProgressLabelDecorator >> progressLabel [
	^ progressLabel
]

{ #category : #rendering }
RSShowProgressLabelDecorator >> render [
	| canvas |
	progressLabel := self labelShape copy.
	progressLabel text: ''.
	canvas := builder container.
	canvas add: progressLabel.
	builder shapes @ highlight.
	
]

{ #category : #updating }
RSShowProgressLabelDecorator >> updateLabel: aShape [
	aShape ifNil: [ ^ progressLabel text: '' ].
	progressLabel
		color: aShape color;
		text: (self progressFor: aShape) asString, '%'
]
