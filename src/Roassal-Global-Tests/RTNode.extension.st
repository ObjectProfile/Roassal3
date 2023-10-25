Extension { #name : 'RTNode' }

{ #category : '*Roassal-Global-Tests' }
RTNode class >> example [
	| root left right |
	"you can manually manipulate the RNode, but you should use RSRTreeShapeCollection"
	root := self new.
	left := self new.
	right := self new.
	root left: left.
	root right: right.
	left contents: (RSBox model: 'A'); rectangle: (0 asPoint corner: 20 asPoint); height: 1.
	right contents: (RSBox model: 'B'); rectangle: (30 asPoint corner: 50 asPoint); height: 1.
	root rectangle: (5 asPoint corner: 45 asPoint); height: 2.

	^ StInspectorPresenter openOn: root
]

{ #category : '*Roassal-Global-Tests' }
RTNode class >> exampleAdd [
	| root |
	"same result but with balance"
	root := self new: (RSBox model: 'A').
	root addChild: (RSBox new model: 'B'; position: 20@20).
	^ StInspectorPresenter openOn: root
]
