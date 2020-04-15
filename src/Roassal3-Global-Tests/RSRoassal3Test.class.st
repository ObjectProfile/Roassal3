Class {
	#name : #RSRoassal3Test,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Core'
}

{ #category : #'as yet unclassified' }
RSRoassal3Test >> testsRsValue [
	| myCutomObjectValueProvider posiblesValuesForRoassal model colors |
	myCutomObjectValueProvider := NSScale category10.
		
	posiblesValuesForRoassal:= {
		Color red.
		nil.
		Color random.
		[ Color random ].
		#color.
		[ :obj | obj color ].
		myCutomObjectValueProvider  }.
		
	model := Morph new.

	colors := posiblesValuesForRoassal collect: [ :value |
		value rsValue: model ] as: OrderedCollection.
	self assert: (colors includes: nil).
	colors remove: nil.
	colors do: [ :color | self assert: color class equals: Color ]
]
