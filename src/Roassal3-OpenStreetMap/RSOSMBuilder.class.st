"
This class is to create maps directly with the correct interactions
"
Class {
	#name : #RSOSMBuilder,
	#superclass : #RSBuilder,
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #rendering }
RSOSMBuilder >> renderIn: aCanvas [
	| osm |
	osm := RSOSM new.
	shapes := { osm }.
	aCanvas add: osm
]
