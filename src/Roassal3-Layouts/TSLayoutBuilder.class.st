"
RTLayoutBuilder is a higher abstract to manage layout. Most builder use it as it significantly shorten the use of layouts.
"
Class {
	#name : #TSLayoutBuilder,
	#superclass : #TSObject,
	#instVars : [
		'layout'
	],
	#category : #'Roassal3-Layouts-Builder'
}

{ #category : #'public layout' }
TSLayoutBuilder >> cell [
	^ layout := TSCellLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> circle [
	^ layout := TSCircleLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> cluster [
	^ layout := TSClusterLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> flow [
	^ layout := TSFlowLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> grid [
	^ layout := TSGridLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> horizontal [
	^ layout := TSHorizontalLineLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> horizontalTree [
	^ layout := TSHorizontalTreeLayout new.
]

{ #category : #initialization }
TSLayoutBuilder >> initialize [
	super initialize.
	self flow.
	
]

{ #category : #accessing }
TSLayoutBuilder >> layout [
	^ layout 
]

{ #category : #'public layout' }
TSLayoutBuilder >> none [
	layout := TSNoLayout new.
	^ layout
]

{ #category : #'public layout' }
TSLayoutBuilder >> on: elements [
	layout on: elements
]

{ #category : #'public layout' }
TSLayoutBuilder >> radial [
	^ layout := TSRadialTreeLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> sugiyama [
	^ layout := TSSugiyamaLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> tree [
	^ layout := TSTreeLayout new.
]

{ #category : #'public layout' }
TSLayoutBuilder >> vertical [
	^ layout := TSVerticalLineLayout new.
]
