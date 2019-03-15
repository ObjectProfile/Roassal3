"
I can add a popup on an element when a move over event occurs 
"
Class {
	#name : #RSPopup,
	#superclass : #RSInteraction,
	#instVars : [
		'label',
		'box'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #accessing }
RSPopup class >> text: anObject [
	| inst |
	inst := self new.
	inst label text: anObject.
	^ inst
]

{ #category : #hooks }
RSPopup >> createOrGetPopupOn: anElement [
	| textElement boxElement att |
	att := anElement view attributes.
	att
		at: #popup
		ifPresent: [ :popup | ^ popup ].
		
	textElement := label elementOn: anElement model.
	boxElement := box elementOn: textElement.
	
	att at: #popup put: boxElement.
	boxElement isFixed: true.
	textElement isFixed: true.
	anElement view 
		add: boxElement;
		add: textElement.
	^ boxElement
	
]

{ #category : #initialization }
RSPopup >> initialize [
	super initialize.
	label := RSShapeBuilder label.
	box := RSShapeBuilder box
		color: (Color colorFrom: 'efefef');
		border: (TSBorder new color: Color gray);
		extent: [ :m | m extent + 5 ];
		when: TSPositionChangedEvent do: [ :m | [ :evt | m translateTo: evt newPosition ] ];
		when: TSShapeRemovedEvent do: [ :m | [ :evt | m remove ] ].
]

{ #category : #accessing }
RSPopup >> label [
	^ label
]

{ #category : #hooks }
RSPopup >> onElement: anElement [
	| remove |
	remove := [ :evt | self removePopupOn: anElement ].
	anElement
		when: TSMouseClick do: remove;
		when: TSMouseEnter do: remove;
		when: TSMouseLeave do: remove;
		when: TSMouseDragging do: remove;
		when: TSMouseMove do: [ :evt | | popup e p |
			popup := self createOrGetPopupOn: anElement.
			p := (anElement view camera 
				fromSpaceToPixel: evt position).
			e :=  (popup extent /2) + 5.
			p x +  popup extent x > popup view extent x ifTrue: [ 
				e := e x negated @ e y.
				p x - popup extent x < 0
					ifTrue: [ e := p x negated + (popup extent x /2) @ e y ].
			].
			popup translateTo: p + e.
			popup signalUpdate. ]

]

{ #category : #hooks }
RSPopup >> removePopupOn: anElement [ 
	| att popup |
	anElement view ifNil: [ ^ self ].
	att := anElement view attributes.
	(att includesKey: #popup) ifFalse: [ ^ self ].
	popup := att at: #popup.
	
	popup remove.
	att removeKey: #popup.
	anElement signalUpdate.
]
