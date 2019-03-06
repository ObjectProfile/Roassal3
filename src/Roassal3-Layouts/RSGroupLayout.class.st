"
RTGroupLayout is a simple class to order group of connected elements.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=
v := RTView new.
v addAll: (RTBox elementsOn: (1 to: 6)) @ RTPopup.
RTEdgeBuilder new
	view: v;
	useAssociations: { 1 -> 2. 1 -> 3 . 4 -> 5 }.
RTTreeLayout on: v elements.

RTGroupLayout new grid; on: v elements.
v
-=-=-=-=-=-=-=-=-=-=-=-=

Another example:
-=-=-=-=-=-=-=-=-=-=-=-=
clss := Collection allSubclasses.

b := RTMondrian new.
b nodes: clss.
b edges connectFrom: #superclass.
b layout tree.
b build.

RTGroupLayout new grid; on: b view elements.

(RTGroupLayout new getGroupsFrom: b view elements) do: [ :g | 
	c := Color random.
	g do: [ :e | e color: c ] ].

b view.
-=-=-=-=-=-=-=-=-=-=-=-=

The whole picture of Pharo
-=-=-=-=-=-=-=-=-=-=-=-=
classes := Smalltalk globals allClasses copyWithoutAll: { Object . TestCase . Model }.

b := RTMondrian new.
b shape box
	width: [ :c | c numberOfVariables * 6 ];
	height: #numberOfMethods.
b nodes: classes.
b edges connectFrom: #superclass.
b layout tree.
""b normalizer normalizeSize: #numberOfMethods.""
b build.

gl := RTGroupLayout new flow.
gl on: b view elements.
gl lonelyGroup do: #remove.

(RTGroupLayout new getSortedGroupsFrom: b view elements) do: [ :g | 
	c := Color random.
	g do: [ :e | e color: c ] ].

b view @ RTZoomableView.
b view.
-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSGroupLayout,
	#superclass : #RSLayout,
	#instVars : [
		'sortBlock',
		'layout',
		'lonelyGroup'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSGroupLayout >> doExecute: elements [
	layout on: (self getSortedGroupsFrom: elements)
]

{ #category : #'public - configuration' }
RSGroupLayout >> flow [
	layout := RSFlowLayout new
]

{ #category : #'private - utils' }
RSGroupLayout >> getGroupsFrom: elements [
	"Return a list of RTGroup, each being the set of connected elements"
	
	| groups iterativeGroup |
	lonelyGroup := RTGroup new.
	groups := OrderedCollection new.
	iterativeGroup := elements copy.
	[ iterativeGroup notEmpty ] whileTrue: [ 
		| els |
		els := iterativeGroup first withAllConnectedElements.
		els size > 1 
			ifTrue: [ groups add: els asGroup ] 
			ifFalse: [ lonelyGroup addAll: els ].
		iterativeGroup removeAll: els.
	].
	RSGridLayout on: lonelyGroup.
	groups add: lonelyGroup.
	^ groups asArray
]

{ #category : #'private - utils' }
RSGroupLayout >> getSortedGroupsFrom: elements [
	| groups |
	groups := self getGroupsFrom: elements.
	^ groups sortedAs: sortBlock
]

{ #category : #'public - configuration' }
RSGroupLayout >> grid [
	layout := RSGridLayout new
]

{ #category : #initalize }
RSGroupLayout >> initialize [
	super initialize.
	self sortRDecreasingSize.
	self grid
]

{ #category : #accessing }
RSGroupLayout >> lonelyGroup [
	^ lonelyGroup
]

{ #category : #accessing }
RSGroupLayout >> lonelyGroup: anObject [
	lonelyGroup := anObject
]

{ #category : #'public - configuration' }
RSGroupLayout >> sortIncreaseSize [
	sortBlock := [ :g1 :g2 | g1 size < g2 size ]
]

{ #category : #'public - configuration' }
RSGroupLayout >> sortRDecreasingSize [
	sortBlock := [ :g1 :g2 | g1 size > g2 size ]
]
