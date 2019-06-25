"
Add horizontal lines for some values

-=-=-=-=-=
	| b ds p |
	b := RTGrapher new.

	ds := RTData new.
	ds dotShape color: Color red.
	ds points: #( 0 1 2 5 10).
	ds x: #yourself.
	ds y: #yourself.
	b add: ds.

	b minY: -3.33.

	p := RTHorizontalLineDecorator new.
	p add: 1; add: 5; add: 3.34.
	p shape line color: (Color red alpha: 0.3).
	b addDecorator: p.

	p := RTVerticalLineDecorator new.
	p add: 5.
	p shape line color: (Color blue alpha: 0.3).
	b addDecorator: p.

	b 
-=-=-=-=-=
"
Class {
	#name : #RTHorizontalLineDecorator,
	#superclass : #RTAbstractLineDecorator,
	#category : #'Roassal3-Grapher-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTHorizontalLineDecorator >> render [	
	| from to |
	values do: [ :aValue |
		from := builder getPixelPositionOf: builder minX @ aValue.
		to := builder getPixelPositionOf: builder maxX @ aValue.
		self lineFrom: from to: to ]
		
	
]
