"
I am an abstract class to create builders for roassal using DNU

I can:
* create commands.
* create conditios
* create a basic start for a new subclasses

This class allows you to create a builder of classes with a lot of methods like BlElement, and send blocks or values in their arguments


"
Class {
	#name : #RSAbstractModelBuilder,
	#superclass : #RSObject,
	#instVars : [
		'isForElement',
		'elementClass',
		'innerClass',
		'commands',
		'actions'
	],
	#category : #'Roassal3-Core'
}

{ #category : #actions }
RSAbstractModelBuilder >> actions [
	^ actions ifNil: [ #() ].
]

{ #category : #actions }
RSAbstractModelBuilder >> addAction: action [
	self actions isEmpty 
		ifTrue: [ actions := OrderedCollection new ].
	self actions add: action.
]

{ #category : #private }
RSAbstractModelBuilder >> basicElementOn: object index: index [
	| el shape |
	self assert: [ self elementClass notNil ] description: 'Need to set a shape'.
	el := self elementClass new.
	el
		model: object;
		index: index.
	shape := self innerClass new.
	el trachelShape: shape.
	self executeActions: #isPreload on: el.
	self updateElement: el innerComponent: shape.
	self executeActions: #isPostload on: el.
	^ el
	
]

{ #category : #commands }
RSAbstractModelBuilder >> commands [
	^ commands ifNil: [ #() ]
]

{ #category : #commands }
RSAbstractModelBuilder >> commands: aCollection [
	commands := aCollection 
]

{ #category : #'reflective operations' }
RSAbstractModelBuilder >> doesNotUnderstand: aMessage [
	"magic"
	((elementClass canUnderstand: aMessage selector) not 
		and: [ (innerClass canUnderstand: aMessage selector) not ])
			ifTrue: [ ^ super doesNotUnderstand: aMessage ].
		
	commands add: (RSCommand new 
		message: aMessage;
		isForModel: self isForModel;
		yourself).
]

{ #category : #'public - accessing' }
RSAbstractModelBuilder >> element [
	^ self elementOn: nil
]

{ #category : #accessing }
RSAbstractModelBuilder >> elementClass [
	^ elementClass
]

{ #category : #accessing }
RSAbstractModelBuilder >> elementClass: aClass [
	elementClass := aClass
]

{ #category : #'public - accessing' }
RSAbstractModelBuilder >> elementOn: object [
	^ self elementOn: object index: nil
]

{ #category : #'public - accessing' }
RSAbstractModelBuilder >> elementOn: object index: index [
	self subclassResponsibility
]

{ #category : #'public - accessing' }
RSAbstractModelBuilder >> elementsOn: aCollection [
	| g |
	g := TSGroup new: aCollection size.
	aCollection doWithIndex: [ :obj : index |
		g add: (self elementOn: obj index: index) ].
	^ g
]

{ #category : #actions }
RSAbstractModelBuilder >> executeActions: block on: element [
	self actions do: [ :action |
		action element: element.
		(block rsValue: action) 
			ifTrue: [ action execute ] ].
]

{ #category : #'reflective operations' }
RSAbstractModelBuilder >> executeCommand: name [
	
	| res |
	res := nil.
	self commands 
		select: [ :cmd | cmd selector = name ]
		thenDo: [ :cmd | res := cmd execute ].
	^ res
]

{ #category : #'reflective operations' }
RSAbstractModelBuilder >> executeDuring: aBlock element: element component: component [
	| bool cmds |
	cmds := commands.
	bool := isForElement.
	commands := OrderedCollection new.
	aBlock rsValue: self.
	self updateElement: element innerComponent: component.
	commands := cmds.
	isForElement := bool.
	
]

{ #category : #'reflective operations' }
RSAbstractModelBuilder >> if: booleanBlock actions: actionsBlock [
	commands add: (RSConditionCommand new 
		message: actionsBlock;
		builder: self;
		condition: booleanBlock;
		isForModel: self isForModel;
		yourself).
]

{ #category : #initialization }
RSAbstractModelBuilder >> initialize [
	super initialize.
	self onModel.
	commands := OrderedCollection new.
]

{ #category : #accessing }
RSAbstractModelBuilder >> innerClass [
	^ innerClass 
]

{ #category : #accessing }
RSAbstractModelBuilder >> innerClass: aClass [
	innerClass := aClass
]

{ #category : #testing }
RSAbstractModelBuilder >> isForElement [
	^ isForElement
]

{ #category : #testing }
RSAbstractModelBuilder >> isForModel [
	^ isForElement not
]

{ #category : #'public - accessing' }
RSAbstractModelBuilder >> onElement [
	isForElement := true
]

{ #category : #'public - accessing' }
RSAbstractModelBuilder >> onModel [
	isForElement := false
]

{ #category : #dependencies }
RSAbstractModelBuilder >> release [ 
	super release.
	self commands do: #release.
	self commands: nil.
]

{ #category : #commands }
RSAbstractModelBuilder >> removeCommandsBySelector: selector [
	^ self removeCommandsBySelectors: { selector }.
]

{ #category : #commands }
RSAbstractModelBuilder >> removeCommandsBySelectors: selectors [
	| toDelete |
	toDelete := commands select: [ :cmd | selectors includes: cmd selector ].
	toDelete do: [ :cmd | commands remove: cmd ].
	^ toDelete
]

{ #category : #updating }
RSAbstractModelBuilder >> updateElement: element innerComponent: component [
	| copy |
	copy := self commands copy.
	copy do: [ :command |
		command 
			element: element;
			component: component ].
	copy do: #execute
]
