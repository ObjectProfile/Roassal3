"
RSNoLayout represents a no-layout strategy.
This class is used when no specific layout is required for visualizing objects in Roassal.
It serves as a placeholder for situations where the user wants to display objects without applying any layout algorithms.
"
Class {
	#name : #RSNoLayout,
	#superclass : #RSLayout,
	#category : #'Roassal-Layouts-Core'
}

{ #category : #hook }
RSNoLayout >> doExecute: elements [
	"Do nothing"
]
