"
a simple hanoi
"
Class {
	#name : #RSHanoi,
	#superclass : #Object,
	#category : #'Roassal3-Experimental-Hanoi'
}

{ #category : #hanoi }
RSHanoi >> hanoi: anInteger from: a bridge: b to: c [
	"
	self new hanoi: 3 from: 'A' bridge: 'B' to: 'C'
	"
	anInteger < 1 ifTrue: [ ^ '' ].
	^ String streamContents: [ :s |
		s
			<< (self hanoi: anInteger - 1 from: a  bridge: c  to: b);
			<< (self moveFrom: a to: c); cr;
			<< (self hanoi: anInteger - 1 from: b bridge: a to: c)
		 ]
]

{ #category : #hanoi }
RSHanoi >> moveFrom: a to: b [
	^ 'Move from ', a, ' to: ', b
]

{ #category : #running }
RSHanoi >> run [
	<script: 'self new run inspect'>
	^ self hanoi: 3 from: 'A' bridge: 'B' to: 'C'
]
