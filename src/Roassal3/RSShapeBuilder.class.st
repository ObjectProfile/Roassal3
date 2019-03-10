"
I can create shapes for roassal based on a model
"
Class {
	#name : #RSShapeBuilder,
	#superclass : #RSAbstractShapeBuilder,
	#category : #'Roassal3-Core'
}

{ #category : #'instance creation' }
RSShapeBuilder class >> arc [
	"TODO find the best name, ring, arc, circle sector, ellipse segment, foobar, etc"
	^ self new
		shapeClass: TSPieSlice;
		yourself 
]

{ #category : #'instance creation' }
RSShapeBuilder class >> box [
	^ self rectangle
]

{ #category : #'instance creation' }
RSShapeBuilder class >> circle [
	^ self ellipse
]

{ #category : #'instance creation' }
RSShapeBuilder class >> ellipse [
	^ self new
		shapeClass: TSEllipse;
		yourself 
]

{ #category : #'instance creation' }
RSShapeBuilder class >> rectangle [
	^ self new
		shapeClass: TSBox;
		yourself 
]

{ #category : #'public - accessing' }
RSShapeBuilder >> elementOn: object index: index [
	^ self basicElementOn: object index: index
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass [
	^ self innerClass 
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass: aClass [
	self innerClass: aClass;
		size: 5;
		color: Color gray;
		elementClass: RSElement.
]
