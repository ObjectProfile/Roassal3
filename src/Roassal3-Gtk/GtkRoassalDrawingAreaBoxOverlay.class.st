"
Store information about the overlay of the GtkRoassalDrawingAreaBox
"
Class {
	#name : #GtkRoassalDrawingAreaBoxOverlay,
	#superclass : #Object,
	#instVars : [
		'overlay',
		'fixed',
		'content',
		'position',
		'extent'
	],
	#pools : [
		'GdkEventMask'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> content [
	^ content
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> content: anObject [
	content := anObject
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> extent [
	^ extent
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> fixed [
	^ fixed
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> fixed: anObject [
	fixed := anObject
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> overlay [
	^ overlay
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> overlay: anObject [
	overlay := anObject
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> position [
	^ position
]

{ #category : #accessing }
GtkRoassalDrawingAreaBoxOverlay >> position: anObject [
	position := anObject
]
