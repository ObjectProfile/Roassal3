"
I am the general control interaction for one view with general elements.

You can zoom it, zoom out, drag the view, zoomToFit it, and move it with the arrow keys, and add RSLightShapesView
"
Class {
	#name : #RSControlsView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'translationAnimation',
		'keyUpActions',
		'keyDownActions',
		'steps',
		'speed',
		'resizeCanvas'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSControlsView >> addLegendOn: aView [
	| lb |
	lb := RSLegendBuilder new
		view: aView.
	lb defaultTitle fontSize: 12.
	lb defLabel fontSize: 10.
	lb shape
		border: TSBorder new;
		color: (Color white alpha: 0.8);
		padding: 10.
	lb 
		title: 'Shortcuts';
		text: '↑ ↓ → ←' description: 'Arrow keys to move the view';
		text: 'Shift + arrows' description: 'Accelerate the move';
		text: 'M' description: 'Maximize or restore the window';
		text: 'I' description: 'Zoom in';
		text: 'O' description: 'Zoom out';
		text: 'Space' description: 'To zoom to fit the view'.
	lb onDemand.
	lb build.
]

{ #category : #initialization }
RSControlsView >> initialize [
	super initialize.
	resizeCanvas := true.
	steps := Set new.
	speed := 1.
	keyDownActions := Dictionary new
		at: 28 put: -1 @ 0; "left"
		at: 29 put: 1 @ 0; "right"
		at: 30 put: 0 @ -1; "up"
		at: 31 put: 0 @ 1; "down"
		yourself.
	keyUpActions := Dictionary new "mac" "TODO review asKeyCombination and this in other os"
		at: 34 put: RSZoomMove in;
		at: 31 put: RSZoomMove out;
		at: 49 put: RSZoomToFitView new;
		at: 46 put: RSMaximizeView new;
		at: 123 put: -1@ 0; "left"
		at: 124 put: 1 @ 0; "right"
		at: 126 put: 0 @ -1; "up"
		at: 125 put: 0 @ 1; "down"
		yourself.
]

{ #category : #public }
RSControlsView >> noResizeCanvas [
	resizeCanvas := false
]

{ #category : #hooks }
RSControlsView >> onElement: aView [
	aView @ RSZoomableView.
	aView @ RSDraggableView.
	
	"the zoom to fit interaction. It sets the first collection of shapes that this view has"
	(keyUpActions at: 49) shapes: aView shapes.
	
	resizeCanvas ifTrue: [ 
		aView zoomToFit.
		aView when: TSExtentChangedEvent do: [ aView zoomToFit ]. 
	 ].
	
	aView
		when: TSKeyDown do: [ :evt | 
			speed ifNil: [| rect |
				rect := aView encompassingRectangle.
				speed := (rect width min: rect height) * 0.01.
			].
			self processKeyDown: evt ];
		when: TSKeyUp do: [ :evt | self processKeyUp: evt.
			speed := nil ].
	self addLegendOn: aView.
	RSMenuActivable new 
		menuDo: [:menu :viw | 
			(menu 
				add: 'Zoom in'
				target: RSZoomMove in
				selector: #onElement: 
				argument: aView)
				icon: (self iconNamed: #glamorousZoomIn).
			(menu 
				add: 'Zoom to fit'
				target: RSZoomToFitView new
				selector: #onElement: 
				argument: aView)
				icon: (self iconNamed: #glamorousZoomToFit).
			(menu 
				add: 'Zoom out'
				target: RSZoomMove out
				selector: #onElement: 
				argument: aView)
				icon: (self iconNamed: #glamorousZoomOut) ];
		onElement: aView.

	
]

{ #category : #hooks }
RSControlsView >> processKeyDown: evt [
	| action mult |
	action := keyDownActions at: evt keyValue ifAbsent: [^ self ].
	
	steps add: action.
	
	mult := evt shiftKeyPressed ifTrue: [ 3 ] ifFalse: [ 1 ].
	translationAnimation ifNil: [  
		translationAnimation := evt canvas newAnimation repeat
			onStepDo: [ :t | | step |
				step := steps inject: 0@0 into: [:p :s |p+s ].
				evt canvas camera translateBy: step / (evt canvas camera scale / (speed*mult) ).
				evt signalUpdate ] ].
]

{ #category : #hooks }
RSControlsView >> processKeyUp: evt [
	| action remove |
	action := keyUpActions at: evt keyValue ifAbsent: [^ self ].
	remove := [ 
		(steps isEmpty and: [ translationAnimation notNil ]) ifTrue:  [ 
			translationAnimation stop.
			translationAnimation := nil ] ].
	action isPoint ifFalse: [
		steps removeAll.
		remove value.
		^ action onElement: evt canvas  ].
	steps remove: action ifAbsent: [ ].
	remove value.
	
]
