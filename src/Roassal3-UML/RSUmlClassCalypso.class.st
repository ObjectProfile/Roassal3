"
UMLClass builder for calypso is a basic calypso tab. 

## Hooks: 

- Activation, use `shouldUseUMLClassTab` to enable or disable uml tabs in your classes.
- Customize, use `createCanvasUMLWithTool:` to create a canvas for each class, if you want. By default a class uses this tool to create the uml builder
"
Class {
	#name : #RSUMLClassCalypso,
	#superclass : #RSAbstractUMLCalypso,
	#instVars : [
		'targetClass'
	],
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #activation }
RSUMLClassCalypso class >> classUmlTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategyAnnotation for: ClyClass asCalypsoItemContext
]

{ #category : #testing }
RSUMLClassCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	^ RSUMLCalypsoSettings useCalypsoUML 
		and: [ aBrowserContext isClassSelected 
			and: [ aBrowserContext lastSelectedClass shouldUseUMLClassTab ] ].
	
]

{ #category : #accessing }
RSUMLClassCalypso class >> tabOrder [
	^ 200
]

{ #category : #accessing }
RSUMLClassCalypso >> activationPriority [
	^ -200
]

{ #category : #building }
RSUMLClassCalypso >> addAnimationToCanvas: canvas [
	| shape p d|
	shape := canvas shapeFromModel: self targetClass.
	(shape isNil or: [ canvas nodes size < 3 ]) ifTrue: [ ^ self ].
	p := shape position.
	d := 20.
	canvas newAnimation
		duration: 1 second;
		scale: (NSScale linear 
			domain: #(0 0.25 0.5 0.75 1);
			range: {p. p+d. p. p+d. p});
		on: shape set: #translateTo: . 
	
]

{ #category : #building }
RSUMLClassCalypso >> buildUmlCanvas [
	| canvas |
	canvas := self targetClass buildUMLCanvasWithBrowserTool: self.
	canvas ifNil: [ canvas := super buildUmlCanvas ].
	self addAnimationToCanvas: canvas.
	^ canvas
]

{ #category : #accessing }
RSUMLClassCalypso >> computeClasses [
	| clazzes |
	clazzes := self targetClass withAllSuperAndSubclasses.
	^ clazzes copyWithoutAll: { Object. ProtoObject }.
	
]

{ #category : #initialization }
RSUMLClassCalypso >> defaultTitle [
	^'UML-Class'
]

{ #category : #testing }
RSUMLClassCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^ self targetClass = anotherBrowserTool targetClass
]

{ #category : #initialization }
RSUMLClassCalypso >> setUpModelFromContext [
	self targetClass: context lastSelectedClass
]

{ #category : #accessing }
RSUMLClassCalypso >> targetClass [
	^ targetClass
]

{ #category : #accessing }
RSUMLClassCalypso >> targetClass: aClass [
	targetClass := aClass
]
