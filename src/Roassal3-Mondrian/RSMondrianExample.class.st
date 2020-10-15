Class {
	#name : #RSMondrianExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Examples'
}

{ #category : #examples }
RSMondrianExample >> example01 [
	<script: 'self new example01 inspect'>
	| b |
	b := RSMondrian new.

	b shape box.
	b nodes: (Collection withAllSubclasses first: 30) forEach: [ :cls |
		b shape box color: Color blue.
		b nodes: cls methods.
		b line 
			color: Color red;
			connectToAll: #dependentMethods.
		b layout grid ].
	b orthoVerticalLine connectFrom: #superclass.
	b layout tree.
	^ b 
]
