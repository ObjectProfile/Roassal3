"
I am a second different way to draw an UML class, similar to the system Torch
"
Class {
	#name : #RSTorchUMLClassRenderer,
	#superclass : #RSAbstractUMLClassRenderer,
	#instVars : [
		'classNameBoxShape',
		'currentTitleWidth'
	],
	#category : #'Roassal3-UML'
}

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> classBoxShape [
	^ classBoxShape ifNil: [ classBoxShape := RSShapeBuilder box
		noPaint;
		border: (TSBorder new width: 5; joinMiter; color: '666EA0') ]
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> classNameBoxShape [
	^ classNameBoxShape ifNil: [ classNameBoxShape := RSShapeBuilder box
		color: 'AFD2EE' ].
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> classNameBoxShape: aShapeBuilder [
	classNameBoxShape := aShapeBuilder
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> classNameShape [
	"^ super classNameShape"
	^ classNameShape ifNil: [ classNameShape := super classNameShape
		addAction: (RSAction new action: [:el| 
			currentTitleWidth := el textWidth ]) ].
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> currentMaxWidth [
	^ currentTitleWidth max: self minMethodsWidth
]

{ #category : #initialization }
RSTorchUMLClassRenderer >> initializeShape [
	classShape := RSShapeBuilder composite
		shapes: [ :cls | 
			| g title box boxTitle rect |
			g := self basicGroupOn: cls.
			boxTitle := self classNameBoxShape elementOn: cls.
			box := self classBoxShape elementOn: cls.
			title := g first.
			g addFirst: boxTitle.
			g addLast: box.
			padding := self classBoxPadding.
			rect := g encompassingRectangle.
			g size = 3 ifTrue: [ padding := padding x@0. ].
			box 
				extent: rect extent + padding;
				position: rect rsCenter.
			title translateBy: 0@ (padding y / -2).
			
			boxTitle 
				position: rect rsCenter x @ title position y ;
				extent: (box width @ title height).
			g
		];
	popup; draggable.
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> methodShape [ 
	^ methodShape ifNil: [ methodShape := RSShapeBuilder box 
		width: 20;
		height: [ :met | met linesOfCode * 5 + 1];
		interactionDo: [:i | i popup multiline] ]
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> methodsShape [

	^ methodsShape ifNil: [ methodsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := self methodShape elementsOn: (classDescriptor methods rsValue: m).
		RSFlowLayout new 
			gapSize: 2; 
			maxWidth: self currentMaxWidth; 
			on: g.
		g ];
		padding:( Margin 
		 	left: 0
			right: 0
			top: 5
			bottom: 0) ]
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> minMethodsWidth [
	^ 200
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> varShape [
	^ varShape ifNil: [ varShape := RSShapeBuilder triangle
		popup;
		size: 20 ].
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> varsShape [
	^ varsShape ifNil: [ varsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := self varShape elementsOn: (classDescriptor instVars rsValue: m).
		RSFlowLayout new 
			gapSize: 2; 
			maxWidth: self currentMaxWidth; 
			on: g.
		g ]  ]
]
