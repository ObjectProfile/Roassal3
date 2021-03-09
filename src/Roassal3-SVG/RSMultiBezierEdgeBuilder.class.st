"
I am a special edge builder with some especial contruction with #linePath and #multiBezier

My instances provide a new edges that you can connect with ancestors between models

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
v := RSView new.

classes := Collection withAllSubclasses.
es := RSShapeBuilder circle elementsOn: classes.

v addAll: es.
es @ RSPopup @ RSDraggable.

eb := RSEdgeBuilder line.
eb color: Color gray.
eb view: v.
eb elements: es.
eb withBorderAttachPoint.
""eb following: #superclass.""
eb connectFrom: #superclass.


RSNormalizer size
	elements: es;
	to: 20;
	normalize: #numberOfMethods.
	
RSNormalizer color
	elements: es;
	normalize: #numberOfMethods.

RSClusterLayout on: es.

eb2 := RSMultiBezierEdgeBuilder multiBezier.
eb2 borderColor: (Color blue alpha: 0.5).
eb2 view: v.
eb2 elements: es.
eb2 withBorderAttachPoint.
eb2 following: #superclass.
eb2 connectToAll: #dependentClasses.

v @ RSControlsView.

v  
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSMultiBezierEdgeBuilder,
	#superclass : #RSLineBuilder,
	#instVars : [
		'tension'
	],
	#category : #'Roassal3-SVG-Edges'
}

{ #category : #'as yet unclassified' }
RSMultiBezierEdgeBuilder class >> multiBezier [
	^ self new: RSSVGPathLine new.
]

{ #category : #private }
RSMultiBezierEdgeBuilder >> applyTensionOn: points [
	| n dp p1 ten |
	n := points size - 1.
	p1 := points first.
	dp := points last - p1.
	ten := self tension.
	2 to: n do: [ :i| | p t |
		p := points at: i.
		t := (i -1)/n. 
		points at: i put: (1 - ten) * (p1 + (t * dp)) + (ten * p)].
]

{ #category : #private }
RSMultiBezierEdgeBuilder >> commonAncestor: edge with: selector [
	| a b aNodes bNodes sharedNode remove |
	a := edge from.
	b := edge to.
	a == b ifTrue: [ ^ a ].
	aNodes := self followersOf: a with: selector.
	bNodes := self followersOf: b with: selector.
	a := aNodes removeLast.
	b := bNodes removeLast.
	sharedNode := nil.
	remove := [ :list | list 
		ifEmpty: [ nil ]
		ifNotEmpty: [ list removeLast ] ].
	[ a == b ] whileTrue: [ 
		sharedNode := a.
		sharedNode ifNil: [ ^ nil ].
		a := remove value: aNodes.
		b := remove value: bNodes. ].
	^ sharedNode.
]

{ #category : #private }
RSMultiBezierEdgeBuilder >> commonShapes: edge with: selector [
	"obtaint a list of points from the elements in the view based on a selector"
	| from to ancestor shapes search index |
	from := edge from.
	to := edge to.
	ancestor := self commonAncestor: edge with: selector.
	ancestor ifNil: [ 
		shapes := (self followersOf: from with: selector),
			(self followersOf: to with: selector) reverse.
		^ shapes ].
	search := [ :model | canvas shapeFromModel: (selector rsValue: model) ].
	shapes := OrderedCollection new.
	shapes add: from.
	[ from == ancestor ] whileFalse: [ 
		from := search value: from model.
		shapes add: from ].
	index := shapes size.
	[ to == ancestor ] whileFalse: [ 
		shapes add: to afterIndex: index.
		to := search value: to model ].
	shapes do: [ :e | (e connectedEdges includes: edge)
		ifFalse: [ e addConnectedEdge: edge ] ].
	^ shapes.
	
]

{ #category : #private }
RSMultiBezierEdgeBuilder >> followersOf: element with: selector [
	| t followers |
	followers := OrderedCollection new.
	t := element. 
	[ t notNil ] whileTrue: [ 
		followers add: t.
		t := canvas shapeFromModel: (selector rsValue: t model) ].
	^ followers
]

{ #category : #'public - line path' }
RSMultiBezierEdgeBuilder >> following: selector [
	self shape svgPath: [ :line | [:builder | 
		| points commonShapes att a b |
		att := line properties.
		a := line startPoint.
		b := line endPoint.
		commonShapes := att
			at: #commom
			ifAbsentPut: [ self commonShapes: line with: selector ].
		points := commonShapes collect: [ :e | e position asFloatPoint ].
		points removeFirst; removeLast; addFirst: a; addLast: b.
		self applyTensionOn: points. 
		builder absolute; moveTo: points first.
		2 to: points size - 2 do: [ :i | | p1 p2 |
			p1 := points at: i.
			p2 := points at: i +1.
			builder 
				curveVia: p1
				to: (p1 + p2)/2 ].
		builder
			curveVia:( points at: points size -1)
			to: points last ] ].
]

{ #category : #'public - line path' }
RSMultiBezierEdgeBuilder >> tension [
	^ tension ifNil: [ tension := 0.7 ]
]

{ #category : #'public - line path' }
RSMultiBezierEdgeBuilder >> tension: aNumberOrBlock [
	"tension should evaluate it and return a value between 0 and 1. 
	0 means straight lines
	1 means a curve line"
	tension := aNumberOrBlock
]
