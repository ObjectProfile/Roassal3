Extension { #name : #RSShape }

{ #category : #'*Roassal3-Sunburst' }
RSShape >> isSLeaf [
	^ self schildren isEmpty
]

{ #category : #'*Roassal3-Sunburst' }
RSShape >> schildren [
	^ self propertyAt: #schildren
]

{ #category : #'*Roassal3-Sunburst' }
RSShape >> schildren: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self propertyAt: #schildren put: anObject
]

{ #category : #'*Roassal3-Sunburst' }
RSShape >> sparent [
	^ self propertyAt: #sparent
]

{ #category : #'*Roassal3-Sunburst' }
RSShape >> sparent: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self propertyAt: #sparent put: anObject
]
