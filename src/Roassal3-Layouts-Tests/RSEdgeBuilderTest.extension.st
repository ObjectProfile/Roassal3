Extension { #name : #RSEdgeBuilderTest }

{ #category : #'*Roassal3-Layouts-Tests' }
RSEdgeBuilderTest >> testUseInLayout [
	b
		canvas: canvas;
		connectTo: [ :v | v + 1 ].
	RSTreeLayout on: canvas nodes.
	self assert: (canvas nodes collect: #position) asArray equals: ((Array new: 10) at: 1 put: ((7.5@7.5)); at: 2 put: ((15.5@7.5)); at: 3 put: ((23.5@7.5)); at: 4 put: ((31.5@7.5)); at: 5 put: ((39.5@7.5)); at: 6 put: ((47.5@7.5)); at: 7 put: ((55.5@7.5)); at: 8 put: ((63.5@7.5)); at: 9 put: ((71.5@7.5)); at: 10 put: ((79.5@7.5)); yourself)
]

{ #category : #'*Roassal3-Layouts-Tests' }
RSEdgeBuilderTest >> testUseInLayoutDefault [

	b 
		canvas: canvas;
		connectTo: [ :v | v + 1 ].
	RSTreeLayout on: canvas nodes.
	
	self assert: (canvas nodes collect: #position) asArray equals: ((Array new: 10) at: 1 put: ((7.5@7.5)); at: 2 put: ((7.5@32.5)); at: 3 put: ((7.5@57.5)); at: 4 put: ((7.5@82.5)); at: 5 put: ((7.5@107.5)); at: 6 put: ((7.5@132.5)); at: 7 put: ((7.5@157.5)); at: 8 put: ((7.5@182.5)); at: 9 put: ((7.5@207.5)); at: 10 put: ((7.5@232.5)); yourself)
]
