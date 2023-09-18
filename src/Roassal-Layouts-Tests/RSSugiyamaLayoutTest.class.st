Class {
	#name : #RSSugiyamaLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSSugiyamaLayoutTest >> testBasic [
	RSSugiyamaLayout on: canvas nodes
]

{ #category : #tests }
RSSugiyamaLayoutTest >> testOnCycle [
	canvas nodes copy do: #remove.
	canvas addAll: ((1 to: 3) collect:  [ :each | RSBox new model: each ]).
	RSLineBuilder line
		shapes: canvas nodes;
		canvas: canvas;
		useAssociations: { 1->2. 2->3. 3->1 }.
	"cycle"
	self should: [RSSugiyamaLayout on: canvas nodes] raise: Error
]
