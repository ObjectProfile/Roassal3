Extension { #name : #RSObjectWithProperty }

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> isSLeaf [
	^ self schildren isEmpty
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> schildren [
	^ self propertyAt: #schildren
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> schildren: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self propertyAt: #schildren put: anObject
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> sparent [
	^ self propertyAt: #sparent
]

{ #category : #'*Roassal3-Sunburst' }
RSObjectWithProperty >> sparent: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self propertyAt: #sparent put: anObject
]
