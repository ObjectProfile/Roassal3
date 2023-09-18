Class {
	#name : #RSSankeyTest,
	#superclass : #RSTest,
	#instVars : [
		'sankey'
	],
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #running }
RSSankeyTest >> setUp [

	super setUp.
	sankey := RSSankey withAllAssociations: {
			          (#Source1 -> 5 -> #Target1).
			          (#Source2 -> 1 -> #Target1).
			          (#Target1 -> 2 -> #Target2).
			          (#Target1 -> 4 -> #Target3) }.
	sankey boxShape
		withBorder;
		borderColor: Color black;
		width: 15.
	sankey
		extent: 960 @ 500;
		iterations: 32;
		nodePadding: 10.
	sankey build
]

{ #category : #tests }
RSSankeyTest >> testBoxDy [

	self assert: (sankey boxes at: 1) dy equals: 1225 / 3.
	self assert: (sankey boxes at: 2) dy equals: 490.
	self assert: (sankey boxes at: 3) dy equals: 245 / 3.
	self assert: (sankey boxes at: 4) dy equals: 490 / 3.
	self assert: (sankey boxes at: 5) dy equals: 980 / 3
]

{ #category : #tests }
RSSankeyTest >> testBoxLast [

	self deny: (sankey boxes at: 1) last.
	self deny: (sankey boxes at: 2) last.
	self deny: (sankey boxes at: 3) last.
	self assert: (sankey boxes at: 4) last.
	self assert: (sankey boxes at: 5) last
]

{ #category : #tests }
RSSankeyTest >> testBoxModel [

	self assert: (sankey boxes at: 1) model equals: #Source1.
	self assert: (sankey boxes at: 2) model equals: #Target1.
	self assert: (sankey boxes at: 3) model equals: #Source2.
	self assert: (sankey boxes at: 4) model equals: #Target2.
	self assert: (sankey boxes at: 5) model equals: #Target3
]

{ #category : #tests }
RSSankeyTest >> testBoxValue [

	self assert: (sankey boxes at: 1) value equals: 5.
	self assert: (sankey boxes at: 2) value equals: 6.
	self assert: (sankey boxes at: 3) value equals: 1.
	self assert: (sankey boxes at: 4) value equals: 2.
	self assert: (sankey boxes at: 5) value equals: 4
]

{ #category : #tests }
RSSankeyTest >> testBoxX [

	self assert: (sankey boxes at: 1) x equals: 0.
	self assert: (sankey boxes at: 2) x equals: 480.
	self assert: (sankey boxes at: 3) x equals: 0.
	self assert: (sankey boxes at: 4) x equals: 960.
	self assert: (sankey boxes at: 5) x equals: 960
]

{ #category : #tests }
RSSankeyTest >> testBoxY [

	self assert: ((sankey boxes at: 1) y closeTo: 0 precision: 10e-2).
	self assert: ((sankey boxes at: 2) y closeTo: 2.02 precision: 10e-2).
	self assert: ((sankey boxes at: 3) y closeTo: 418.33 precision: 10e-2).
	self assert: ((sankey boxes at: 4) y closeTo: 336.66 precision: 10e-2).
	self assert: ((sankey boxes at: 5) y closeTo: 0 precision: 10e-2)
]

{ #category : #tests }
RSSankeyTest >> testGenerateSankeyUsingSet [

	RSSankey withAllAssociations: {
			(#Source1 -> 5 -> #Target1).
			(#Source2 -> 1 -> #Target1).
			(#Target1 -> 2 -> #Target2).
			(#Target1 -> 4 -> #Target3) } asSet
]

{ #category : #tests }
RSSankeyTest >> testLineDy [

	self assert: (sankey lines at: 1) dy equals: 1225 / 3.
	self assert: (sankey lines at: 2) dy equals: 245 / 3.
	self assert: (sankey lines at: 3) dy equals: 490 / 3.
	self assert: (sankey lines at: 4) dy equals: 980 / 3
]

{ #category : #tests }
RSSankeyTest >> testLineModel [

	self
		assert: (sankey lines at: 1) model
		equals: (RSSankeyLink on: #Source1 -> 5 -> #Target1).
	self
		assert: (sankey lines at: 2) model
		equals: (RSSankeyLink on: #Source2 -> 1 -> #Target1).
	self
		assert: (sankey lines at: 3) model
		equals: (RSSankeyLink on: #Target1 -> 2 -> #Target2).
	self
		assert: (sankey lines at: 4) model
		equals: (RSSankeyLink on: #Target1 -> 4 -> #Target3)
]

{ #category : #tests }
RSSankeyTest >> testLineSy [

	self assert: (sankey lines at: 1) sy equals: 0.
	self assert: (sankey lines at: 2) sy equals: 0.
	self assert: (sankey lines at: 3) sy equals: 980 / 3.
	self assert: (sankey lines at: 4) sy equals: 0
]

{ #category : #tests }
RSSankeyTest >> testLineTy [

	self assert: (sankey lines at: 1) ty equals: 0.
	self assert: (sankey lines at: 2) ty equals: 1225 / 3.
	self assert: (sankey lines at: 3) ty equals: 0.
	self assert: (sankey lines at: 4) ty equals: 0
]

{ #category : #tests }
RSSankeyTest >> testLineValue [

	self assert: (sankey lines at: 1) value equals: 5.
	self assert: (sankey lines at: 2) value equals: 1.
	self assert: (sankey lines at: 3) value equals: 2.
	self assert: (sankey lines at: 4) value equals: 4
]

{ #category : #tests }
RSSankeyTest >> testNodeAndLinksOrders [

	self
		assert: sankey nodes
		equals:
		#( #Source1 #Target1 #Source2 #Target2 #Target3 )
			asOrderedCollection.
	self assert: sankey links equals: ({
			 (#Source1 -> 5 -> #Target1).
			 (#Source2 -> 1 -> #Target1).
			 (#Target1 -> 2 -> #Target2).
			 (#Target1 -> 4 -> #Target3) } collect: [ :each |
			 RSSankeyLink on: each ])
]
