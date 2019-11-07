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
	#superclass : #RS3Object,
	#instVars : [
		'isForElement',
		'elementClass',
		'innerClass',
		'commands',
		'actions',
		'hasUniqueCommands',
		'interaction'
	],
	#category : #'Roassal3-Scripting-Builders'
}

{ #category : #actions }
RSAbstractModelBuilder >> actions [
	^ actions ifNil: [ #() ].
]

{ #category : #actions }
RSAbstractModelBuilder >> addAction: action [
	self actions isEmpty 
		ifTrue: [ actions := OrderedCollection new: 2 ].
	self actions add: action.
]

{ #category : #commands }
RSAbstractModelBuilder >> allowRepeatCommands [
	"with this commands are uniques and we keep the last command if they are equal.
	EG with hasUniqueCommands equals true
	.=.=
	RSShapeBuilder box 
		color: [ Color red ];
		color: [ Color blue ];
		color: Color blue;
		color: nil.
	.=.=
	In this case commands collection are { [ red ]. [ blue ]. Color blue. nil }.
	.=.=
	RSShapeBuilder box 
		uniqueCommands;
		color: [ Color red ];
		color: [ Color blue ];
		color: Color blue;
		color: nil.
	.=.=
	In this case commands collection are { nil }.
	"
	hasUniqueCommands := false
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
	el shape: shape.
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

{ #category : #'special objects' }
RSAbstractModelBuilder >> currentGetterValues: element [
	| dict tshape |
	dict := Dictionary new.
	tshape := element shape.
	self commands do: [ :cmd |
		cmd 
			element: element;	
			component: tshape. 
		cmd fillGetterIn: dict ].
	^ dict 
]

{ #category : #'reflective operations' }
RSAbstractModelBuilder >> doesNotUnderstand: aMessage [
	"magic"
	| command |
	((elementClass canUnderstand: aMessage selector) not 
		and: [ (innerClass canUnderstand: aMessage selector) not ])
			ifTrue: [ ^ super doesNotUnderstand: aMessage ].
	command := RSCommand new 
		message: aMessage;
		isForModel: self isForModel;
		yourself.
	(hasUniqueCommands and: [ commands includes: command ]) ifTrue: [ 
		commands 
			remove: command;
			add: command.
	 ] ifFalse: [ commands add: command. ].
	
]

{ #category : #interactions }
RSAbstractModelBuilder >> draggable [
	self interactionDo: #draggable.
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
	g := RSGroup new: aCollection size.
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

{ #category : #testing }
RSAbstractModelBuilder >> hasUniqueCommands [
	^ hasUniqueCommands
]

{ #category : #'reflective operations' }
RSAbstractModelBuilder >> if: booleanBlock then: actionsBlock [
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
	hasUniqueCommands := false.
]

{ #category : #accessing }
RSAbstractModelBuilder >> innerClass [
	^ innerClass 
]

{ #category : #accessing }
RSAbstractModelBuilder >> innerClass: aClass [
	innerClass := aClass
]

{ #category : #interactions }
RSAbstractModelBuilder >> interaction [
	^ interaction ifNil: [
		interaction := RSInteractionBuilder new.
		self addAction: (RSAction new
			action: [ :el | interaction setUpElement: el ]).
		interaction ].
]

{ #category : #interactions }
RSAbstractModelBuilder >> interactionDo: aBlock [
	aBlock value: self interaction
]

{ #category : #testing }
RSAbstractModelBuilder >> isForElement [
	^ isForElement
]

{ #category : #accessing }
RSAbstractModelBuilder >> isForElement: aBool [
	isForElement := aBool
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

{ #category : #interactions }
RSAbstractModelBuilder >> popup [
	self interactionDo: #popup.
]

{ #category : #dependencies }
RSAbstractModelBuilder >> release [ 
	super release.
	actions := nil.
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

{ #category : #commands }
RSAbstractModelBuilder >> uniqueCommands [
	"with this commands are uniques and we keep the last command if they are equal.
	EG with hasUniqueCommands equals true
	.=.=
	RSShapeBuilder box 
		color: [ Color red ];
		color: [ Color blue ];
		color: Color blue;
		color: nil.
	.=.=
	In this case commands collection are { [ red ]. [ blue ]. Color blue. nil }.
	.=.=
	RSShapeBuilder box 
		uniqueCommands;
		color: [ Color red ];
		color: [ Color blue ];
		color: Color blue;
		color: nil.
	.=.=
	In this case commands collection are { nil }.
	"
	hasUniqueCommands := true
]

{ #category : #updating }
RSAbstractModelBuilder >> updateElement: element [
	self 
		updateElement: element 
		innerComponent: element shape
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

{ #category : #updating }
RSAbstractModelBuilder >> updateElement: element withCommand: selector [
	| temp |
	temp := commands.
	commands := commands select: [ :c | c selector = selector ].
	self updateElement: element.
	commands := temp.
		
]

{ #category : #updating }
RSAbstractModelBuilder >> updateElements: elements [
	elements do: [ :e | self updateElement: e ].
]
