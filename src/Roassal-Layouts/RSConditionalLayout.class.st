"
`RSConditionalLayout` applies two layouts on a set of shapes using a condition

*Responsibility*: Shapes matching a given condition use a particular layout, else another layout is applied 

*Collaborators*: Shapes and layouts

*Variables*:
- `if`: one-arg block or symbol to be applied on a shape. Must return a boolean when applied. 
- `thenLayout`: a layout used for the shapes that matches the condition
- `thenLayout `: a layout used for the shapes that do not match the condition

"
Class {
	#name : #RSConditionalLayout,
	#superclass : #RSLayout,
	#instVars : [
		'if',
		'thenLayout',
		'elseLayout',
		'clusterLayout'
	],
	#category : #'Roassal-Layouts-Core'
}

{ #category : #accessing }
RSConditionalLayout >> clusterLayout [

	^ clusterLayout
]

{ #category : #accessing }
RSConditionalLayout >> clusterLayout: anObject [

	clusterLayout := anObject
]

{ #category : #hook }
RSConditionalLayout >> doExecute: shapes [
	"Performs the layout"

	| thenShapes elseShapes |
	thenShapes := (shapes select: if) asGroup.
	elseShapes := (shapes reject: if) asGroup.
	thenLayout on: thenShapes.
	elseLayout on: elseShapes.
	
	clusterLayout on: { thenShapes. elseShapes }.
]

{ #category : #accessing }
RSConditionalLayout >> else [
	^ elseLayout
]

{ #category : #accessing }
RSConditionalLayout >> else: aLayout [
	elseLayout := aLayout
]

{ #category : #accessing }
RSConditionalLayout >> if [
	^ if
]

{ #category : #accessing }
RSConditionalLayout >> if: aOneArgBlockOrSymbol [
	"Take as argument a block that will be used on the shapes. The block should return a boolean"
	if := aOneArgBlockOrSymbol
]

{ #category : #accessing }
RSConditionalLayout >> ifConnectedThen: aLayout [
	self if: [ :shape | shape hasEdges ].
	self then: aLayout
]

{ #category : #accessing }
RSConditionalLayout >> ifNotConnectedThen: aLayout [
	self if: [ :shape | shape hasEdges not ].
	self then: aLayout
]

{ #category : #initialization }
RSConditionalLayout >> initialize [
	super initialize.
	self if: [ :each | true ].
	self clusterLayout: RSHorizontalLineLayout new.
	thenLayout := clusterLayout.
	elseLayout := clusterLayout.
]

{ #category : #accessing }
RSConditionalLayout >> then [

	^ thenLayout
]

{ #category : #accessing }
RSConditionalLayout >> then: aLayout [
	thenLayout := aLayout
]

{ #category : #accessing }
RSConditionalLayout >> thenLayout [

	^ thenLayout
]
