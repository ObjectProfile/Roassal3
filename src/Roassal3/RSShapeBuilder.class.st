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
RSShapeBuilder class >> label [

"Here is an exampe on how to use it
-=-=-=-=-=
v := RSView new.
v @ RSControlsView.

sb := RSShapeBuilder label.
sb interactionDo: #draggable.
sb text: #asString.
elements := sb elementsOn: (Collection withAllSubclasses).

elements do: [ :e | e translateTo: (Random new nextInt: 300) @ (Random new nextInt: 300) ].
v addAll: elements.

RSNormalizer fontSize
	elements: elements;
	to: 30;
	normalize: #numberOfMethods.

v zoomToFit.
v open
-=-=-=-=-=
"

	^ self new
		innerClass: TSLabel;
		elementClass: RSElement;
		color: Color black;
		addAction: (RSAction new action: [:el | 
			| text |
			text := el text.
			text ifNil: [ text := el model ].
			el text: text asString ] ) 
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
		elementClass: RSElement;
		size: 5;
		color: Color gray
]
