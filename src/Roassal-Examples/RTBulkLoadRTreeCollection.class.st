"
This class is created for example02BigVisualizationHalfMillion.
This class is just an example of how you can speed the loading process of new elements.

This class balance de tree using equal number or nodes for each tree. because of that.
users should provide a (2 raisedTo: n) number of nodes to compute the tree.
rembember a balance tree offers a better search experience 
"
Class {
	#name : 'RTBulkLoadRTreeCollection',
	#superclass : 'RTreeCollection',
	#category : 'Roassal-Examples-Basic',
	#package : 'Roassal-Examples',
	#tag : 'Basic'
}

{ #category : 'adding' }
RTBulkLoadRTreeCollection >> bulkLoad: aCollection [
	aCollection ifEmpty: [ ^ self ].
	root := RTNode new.
	root bulkLoad: aCollection from: 1 to: aCollection size
]
