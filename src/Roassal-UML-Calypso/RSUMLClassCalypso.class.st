"
UMLClass builder for calypso is a basic calypso tab. 

## Hooks: 

- Activation, use `shouldUseUMLClassTab` to enable or disable uml tabs in your classes.
- Customize, use `createCanvasUMLWithTool:` to create a canvas for each class, if you want. By default a class uses this tool to create the uml builder
"
Class {
	#name : 'RSUMLClassCalypso',
	#superclass : 'RSAbstractUMLCalypso',
	#instVars : [
		'targetClass'
	],
	#category : 'Roassal-UML-Calypso-Core',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Core'
}

{ #category : 'activation' }
RSUMLClassCalypso class >> classUmlTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategyAnnotation for: ClyClass asCalypsoItemContext
]

{ #category : 'testing' }
RSUMLClassCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	^ RSUMLCalypsoSettings useCalypsoUML
		and: [ aBrowserContext isClassSelected
			and: [ aBrowserContext lastSelectedClass shouldUseUMLClassTab ] ]
]

{ #category : 'accessing' }
RSUMLClassCalypso class >> tabOrder [
	^ 200
]

{ #category : 'accessing' }
RSUMLClassCalypso >> activationPriority [
	^ -200
]

{ #category : 'building' }
RSUMLClassCalypso >> buildUmlCanvas [
	| canvas |
	canvas := self targetClass buildUMLCanvasWithBrowserTool: self.
	canvas ifNil: [ canvas := super buildUmlCanvas ].
	RSUMLCalypsoSettings initialSelectionClass new
		targetClass: self targetClass;
		on: canvas.
	^ canvas
]

{ #category : 'accessing' }
RSUMLClassCalypso >> computeClasses [
	| clazzes |
	clazzes := self targetClass withAllSuperAndSubclasses.
	^ clazzes copyWithoutAll: { Object. ProtoObject }
]

{ #category : 'initialization' }
RSUMLClassCalypso >> defaultTitle [
	^'UML-Class'
]

{ #category : 'testing' }
RSUMLClassCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^ self targetClass = anotherBrowserTool targetClass
]

{ #category : 'initialization' }
RSUMLClassCalypso >> setUpModelFromContext [
	self targetClass: context lastSelectedClass
]

{ #category : 'accessing' }
RSUMLClassCalypso >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
RSUMLClassCalypso >> targetClass: aClass [
	targetClass := aClass
]
