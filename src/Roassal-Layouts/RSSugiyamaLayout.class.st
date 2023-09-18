"
The SugiyamaLayout class implements the Sugiyama algorithm, a popular graph layout algorithm used to create hierarchical layouts of directed acyclic graphs (DAGs). 

This algorithm organizes nodes into multiple layers and minimizes the number of edge crossings, resulting in a visually appealing and easy-to-understand representation of the input graph.

Based on Coffman-Graham-Layering. Di Battista Book, page 275, chapter, 9.2.1
"
Class {
	#name : #RSSugiyamaLayout,
	#superclass : #RSAbstractGraphLayout,
	#instVars : [
		'labels',
		'layers',
		'layerNrs',
		'connections',
		'visited',
		'stack',
		'childrenWithoutCycles',
		'parentWithoutCycles'
	],
	#category : #'Roassal-Layouts-ByConnection'
}

{ #category : #utilities }
RSSugiyamaLayout class >> sort: assocA to: assocB [
	| a b offset |
	offset := 0.
	a := assocA value.
	b := assocB value.
	[(a size > offset)
		and: [(b size > offset) and: [(a at: a size - offset) = (b at: b size - offset)]]]
		whileTrue: [offset := offset + 1].	"Corner cases"
	(a size = b size and: [b size = offset]) ifTrue: [ ^ true ].	"[3, 3], [3, 3]"
	(a size > offset and: [b size = offset]) ifTrue: [ ^ true ].	"[3, 3, 6], [3, 3]"
	(b size > offset and: [a size = offset]) ifTrue: [ ^ false ].	"[3, 3], [3, 3, 6]"	"Normal case"
	^ (a at: a size - offset) >= (b at: b size - offset)
]

{ #category : #utilities }
RSSugiyamaLayout class >> sortBlock [

	^ [ :assocA :assocB | self sort: assocA to: assocB ]
]

{ #category : #private }
RSSugiyamaLayout >> addDummyNodes [

	| layer layerNr |
	connections := RSIdentityMatrix new.
	self edgesDo: [ :edge |
		| layerFrom layerTo span fromNode toNode |
		"edge hints removeAll."
		layerFrom := layerNrs at: edge from.
		layerTo := layerNrs at: edge to.
		span := layerTo - layerFrom.

		"Normal case where nodes are in adjacent layers"
		span abs = 1 ifTrue: [ connections at: edge from at: edge to put: true ].

		fromNode := edge from.
		[ span > 1 or: [ span < -1 ] ] whileTrue: [
			span := span > 0
				ifTrue: [ span - 1]
				ifFalse: [ span + 1].
			layerNr := layerTo - span.
			layer := layers at: layerNr.
			toNode := RSDummyNode on: edge slot: layerFrom - span.
			layer add: toNode.
			layerNrs at: toNode put: layerNr.
			connections at: fromNode at: toNode put: true.
			fromNode := toNode ].

		(layerFrom - layerTo) abs > 1 ifTrue: [
			connections at: fromNode at: edge to put: true ] ]
]

{ #category : #private }
RSSugiyamaLayout >> assignLabels: aNodeCollection [

	"Initialize label dictionary"

	| label vertices parentLabels |
	labels := IdentityDictionary new.
	label := 1. "Assign labels to the roots"
	(self rootNodesFor: aNodeCollection) do: [ :node |
		labels at: node put: label.
		label := label + 1 ]. "Assign labels to the rest"
	[ labels keys size < aNodeCollection size ] whileTrue: [
		vertices := SortedCollection sortBlock: self sortBlock.
		aNodeCollection do: [ :node |
			(labels includesKey: node) ifFalse: [
				parentLabels := ((self parentsWithoutCylesFor: node) collect: [
					                 :pn | labels at: pn ifAbsent: [ self maxFloat ] ])
					                asSortedCollection.
				parentLabels last ~= self maxFloat ifTrue: [
					vertices add: node -> parentLabels ] ] ].
		labels at: vertices first key put: label.
		label := label + 1 ]
]

{ #category : #private }
RSSugiyamaLayout >> buildLayers: g [

	| w layerNr u vertices vertex layer done |
	w := self maxFloat.
	u := OrderedCollection new.
	layers := IdentityDictionary new.
	layerNrs := IdentityDictionary new. "Assign all nodes to layers"
	[ g isEmpty ] whileFalse: [
		vertices := g select: [ :e |
			            (self parentsWithoutCylesFor: e) allSatisfy: [ :node |
				            u includes: node ] ].
		vertex := vertices detectMax: [ :e | labels at: e ].
		done := false.
		layerNr := 1.
		[ done ] whileFalse: [
			layer := layers at: layerNr ifAbsentPut: [ OrderedCollection new ].
			(layer size >= w or: [
				 (self parentsWithoutCylesFor: vertex) anySatisfy: [ :n |
					 (layerNrs at: n) >= layerNr ] ])
				ifTrue: [ layerNr := layerNr + 1 ]
				ifFalse: [ done := true ] ].
		layer add: vertex.
		layerNrs at: vertex put: layerNr.
		u add: vertex.
		g remove: vertex ]
]

{ #category : #accessing }
RSSugiyamaLayout >> childrenWithoutCyclesFor: aRSComposite [

	childrenWithoutCycles ifNil: [ childrenWithoutCycles := IdentityDictionary new ].
	^ childrenWithoutCycles at: aRSComposite ifAbsentPut: [ (self childrenFor: aRSComposite) copy ]
]

{ #category : #private }
RSSugiyamaLayout >> cl: layer u: u v: v [
	"Calculates cuv. Di Battista, chapter 9.2.2, page 283"
	| partnersOfU partnersOfV c partnersOfUIndex partnersOfVIndex layerNr |
	layerNr := layerNrs at: u.	":= layerNrs at: v"
	partnersOfU := (connections at: u)
		select: [:each | (layerNrs at: each) = (layerNr - 1)].
	partnersOfV := (connections at: v)
		select: [:each | (layerNrs at: each) = (layerNr - 1)].
	c := 0.
	partnersOfUIndex := partnersOfU collect: [:node | layer indexOf: node].
	partnersOfVIndex := partnersOfV collect: [:node | layer indexOf: node].
	partnersOfUIndex
		do:
			[:uIndex | partnersOfVIndex do: [:vIndex | vIndex < uIndex ifTrue: [c := c + 1]]].
	^c
]

{ #category : #hook }
RSSugiyamaLayout >> doExecute: aNodeCollection [
	"Coffman-Graham-Layering. Di Battista Book, page 275, chapter, 9.2.1"

	self removeCycles: aNodeCollection.
	self assignLabels: aNodeCollection.
	self buildLayers: aNodeCollection copy.
	self addDummyNodes.
	self reduceCrossing.
	self layoutAt: self verticalGap @ self horizontalGap
]

{ #category : #private }
RSSugiyamaLayout >> layoutAt: aPoint [

	| treeWidth layerKeys layer layerWidth horizontalPosition verticalPosition layerHeight |
	treeWidth := layers values
		             inject: self maxFloat negated
		             into: [ :max :e |
			             max max:
				             (e sumNumbers: #width)
				             + ((e size - 1) * self horizontalGap) ].
	verticalPosition := self horizontalGap. "For visual reasons NOT: self class verticalGap"
	layerKeys := layers keys asSortedCollection.
	layerKeys do: [ :aKey |
		layer := layers at: aKey.
		layerWidth := (layer sum: #width)
		              + ((layer size - 1) * self horizontalGap).
		layerHeight := (layer detectMax: #height) height.
		horizontalPosition := treeWidth / 2.0 + aPoint x
		                      - (layerWidth / 2.0).
		layer do: [ :node |
			translator
				translateTopLeftOf: node
				to: horizontalPosition @ verticalPosition.

			horizontalPosition := horizontalPosition + node width
			                      + self horizontalGap ].
		verticalPosition := verticalPosition + layerHeight
		                    + self verticalGap ]
]

{ #category : #private }
RSSugiyamaLayout >> maxFloat [
	^ 1e10
]

{ #category : #'real sugiyama' }
RSSugiyamaLayout >> parentsWithoutCylesFor: aRSComposite [

	parentWithoutCycles ifNil: [ parentWithoutCycles := IdentityDictionary new ].
	^ parentWithoutCycles at: aRSComposite ifAbsentPut: [ (self parentsFor: aRSComposite) copy ]
]

{ #category : #'real sugiyama' }
RSSugiyamaLayout >> recursiveRemoveCyclesFrom: aNode [

	(visited includes: aNode) ifTrue: [ ^ self ].
	visited add: aNode.
	stack push: aNode.

	(self childrenFor: aNode) do: [ :e |
		(stack includes: e) ifTrue: [
			self removeCycleFrom: aNode to: e
		] ifFalse: [
			self recursiveRemoveCyclesFrom: e.
		]
	].

	stack pop
]

{ #category : #private }
RSSugiyamaLayout >> reduceCrossing [

	"Crossing reduction"

	| layer2 u v c1 c2 layer1 done |
	2 to: layers keys size do: [ :index |
		layer1 := layers at: index - 1.
		layer2 := layers at: index.
		done := false.
		[ done ] whileFalse: [
			done := true.
			2 to: layer2 size do: [ :i |
				u := layer2 at: i - 1.
				v := layer2 at: i.
				c1 := self cl: layer1 u: u v: v.
				c2 := self cl: layer1 u: v v: u.
				c1 > c2 ifTrue: [
					layer2 rsSwapElement: u withElement: v.
					done := false ] ] ] ]
]

{ #category : #'real sugiyama' }
RSSugiyamaLayout >> removeCycleFrom: aRSComposite to: aRSComposite2 [

	(self childrenWithoutCyclesFor: aRSComposite) remove: aRSComposite2.
	(self parentsWithoutCylesFor: aRSComposite2) remove: aRSComposite
]

{ #category : #'real sugiyama' }
RSSugiyamaLayout >> removeCycles: aCollection [

	| roots |
	roots := self rootNodesFor: aCollection.
	visited := Set new.
	stack := Stack new.
	roots do: [ :root | self recursiveRemoveCyclesFrom: root ]
]

{ #category : #private }
RSSugiyamaLayout >> sortBlock [
	^ self class sortBlock
]
