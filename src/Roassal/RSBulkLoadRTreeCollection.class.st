"
This class is created for example09BigVisualization2raised19.
This class is just an example of how you can speed the loading process of new elements.

This class balance de tree using equal number or nodes for each tree. because of that.
users should provide a (2 raisedTo: n) number of nodes to compute the tree.
rembember a balance tree offers a better search experience 
"
Class {
	#name : 'RSBulkLoadRTreeCollection',
	#superclass : 'RSRTreeShapeCollection',
	#category : 'Roassal-Rendering',
	#package : 'Roassal',
	#tag : 'Rendering'
}

{ #category : 'adding' }
RSBulkLoadRTreeCollection >> bulkLoad: aCollection [
	aCollection ifEmpty: [ ^ self ].
	root := RSRNode new.
	root bulkLoad: aCollection from: 1 to: aCollection size
]
