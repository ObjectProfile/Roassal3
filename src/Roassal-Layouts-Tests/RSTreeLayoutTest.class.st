Class {
	#name : #RSTreeLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSTreeLayoutTest >> computeTreeWithCycles [
	| chars |
	canvas := RSCanvas new.
	chars := $a to: $e.
	shapes := RSComposite models: chars forEach: [ :composite :char |
		| box label |
		label := RSLabel text: char.
		box := RSBox new
			position: label position;
			extent: label extent + 10;
			yourself.

		composite
			draggable;
			add: box;
			add: label;
			yourself.
		].

	canvas addAll: shapes.
	RSLineBuilder arrowedLine
		canvas: canvas;
		withBorderAttachPoint;
		useAssociations:
			{$a -> $b.
			$a -> $e.
			$b -> $c.
			$c -> $d.
			$d -> $a}. "cycle"
]

{ #category : #tests }
RSTreeLayoutTest >> testBasic [
	RSTreeLayout on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(23.5@7.5). (15.5@32.5). (35.5@32.5). (11.5@57.5). (23.5@57.5). (31.5@57.5). (39.5@57.5). (7.5@82.5). (15.5@82.5). (23.5@82.5)}
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithHorizontalGap [
	RSTreeLayout new horizontalGap: 50; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(117.5@7.5). (62.5@32.5). (200.0@32.5). (35.0@57.5). (117.5@57.5). (172.5@57.5). (227.5@57.5). (7.5@82.5). (62.5@82.5). (117.5@82.5)}
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithLeftGap [
	| withNoGap withGap |
	RSTreeLayout new leftGap: 15; on: canvas nodes.
	withNoGap := {(23.5@7.5). (15.5@32.5). (35.5@32.5). (11.5@57.5). (23.5@57.5). (31.5@57.5). (39.5@57.5). (7.5@82.5). (15.5@82.5). (23.5@82.5)}.
	withGap := withNoGap collect: [ :p | p + (10 @ 0) ].
	self assert: (shapes collect: #position) asArray equals: withGap
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithTopGap [
	| withNoGap withGap |
	RSTreeLayout new topGap: 15; on: canvas nodes.
	withNoGap := {(23.5@7.5). (15.5@32.5). (35.5@32.5). (11.5@57.5). (23.5@57.5). (31.5@57.5). (39.5@57.5). (7.5@82.5). (15.5@82.5). (23.5@82.5)}.
	withGap := withNoGap collect: [ :p | p + (0 @ 10) ].
	self assert: (shapes collect: #position) asArray equals: withGap
]

{ #category : #tests }
RSTreeLayoutTest >> testBasicWithVerticalGap [
	RSTreeLayout new verticalGap: 50; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(23.5@7.5). (15.5@62.5). (35.5@62.5). (11.5@117.5). (23.5@117.5). (31.5@117.5). (39.5@117.5). (7.5@172.5). (15.5@172.5). (23.5@172.5)}
]

{ #category : #tests }
RSTreeLayoutTest >> testDoNotValidateCyclesLayoutsEachShapeProperly [
	| groups |
	self computeTreeWithCycles.
	RSTreeLayout new
		horizontalGap: 10;
		childrenSortBlock: [ :a :b | a model < b model ];
		doNotValidateCycles; on: shapes.
	groups := shapes groupedBy: [ :each | each position ].
	"at least each shape should be in a different position"
	self assert: groups size equals: shapes size
]

{ #category : #tests }
RSTreeLayoutTest >> testDoNotValidateCyclesRunsNormally [
	self computeTreeWithCycles.
	RSTreeLayout new doNotValidateCycles; on: shapes
]

{ #category : #tests }
RSTreeLayoutTest >> testValidateCyclesRaisesError [
	self computeTreeWithCycles.
	self should: [ RSTreeLayout new validateCycles on: shapes ] raise: Error
]
