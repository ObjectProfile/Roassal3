"
RTLayoutBuilder is a higher abstract to manage layout. Most builder use it as it significantly shorten the use of layouts.
"
Class {
	#name : #RSLayoutBuilder,
	#superclass : #RSObject,
	#instVars : [
		'layout'
	],
	#category : #'Roassal3-Layouts-Builder'
}

{ #category : #'public layout' }
RSLayoutBuilder >> flow [
	^ layout := RSFlowLayout new.
]

{ #category : #'public layout' }
RSLayoutBuilder >> grid [
	^ layout := RSGridLayout new.
]

{ #category : #'public layout' }
RSLayoutBuilder >> horizontal [
	^ layout := RSHorizontalLineLayout new.
]

{ #category : #'public layout' }
RSLayoutBuilder >> horizontalTree [
	^ layout := RSHorizontalTreeLayout new.
]

{ #category : #initialization }
RSLayoutBuilder >> initialize [
	super initialize.
	self flow.
	
]

{ #category : #accessing }
RSLayoutBuilder >> layout [
	^ layout 
]

{ #category : #'public layout' }
RSLayoutBuilder >> on: elements [
	layout on: elements
]

{ #category : #'public layout' }
RSLayoutBuilder >> tree [
	^ layout := RSTreeLayout new.
]

{ #category : #'public layout' }
RSLayoutBuilder >> vertical [
	^ layout := RSVerticalLineLayout new.
]
