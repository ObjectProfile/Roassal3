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

{ #category : #'public - layout' }
RSLayoutBuilder >> cell [
	^ layout := RSCellLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> circle [
	^ layout := RSCircleLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> cluster [
	^ layout := RSClusterLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> flow [
	^ layout := RSFlowLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> force [
	^ layout := RSSimpleForceBasedLayout new
]

{ #category : #'public - layout' }
RSLayoutBuilder >> grid [
	^ layout := RSGridLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> horizontal [
	^ layout := RSHorizontalLineLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> horizontalTree [
	^ layout := RSHorizontalTreeLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> ifConnected: aLayout [
	^ self ifConnected: aLayout ifNotConnected: RSGridLayout new
]

{ #category : #'public - layout' }
RSLayoutBuilder >> ifConnected: aLayout ifNotConnected: anotherLayout [

	^ layout := RSConditionalLayout new
					 ifNotConnectedThen: anotherLayout;
					 else: aLayout
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

{ #category : #'public - layout' }
RSLayoutBuilder >> none [
	layout := RSNoLayout new.
	^ layout
]

{ #category : #'public - layout' }
RSLayoutBuilder >> on: shapes [
	layout on: shapes
]

{ #category : #'public - layout' }
RSLayoutBuilder >> radial [
	^ layout := RSRadialTreeLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> rawForce [
	^ layout := RSForceBasedLayout new useProgressBar.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> sugiyama [
	^ layout := RSSugiyamaLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> tidyTree [
	"For example:
	
```
packages := RPackage organizer packages select: [ :pak | pak packageName beginsWith: 'Roassal3' ].
classes := packages flatCollect: #definedClasses.

m := RSMondrian new.
m nodes: classes.
m line connectFrom: #superclass.
m layout tidyTree.
m 
```"


	^ layout := RSConditionalLayout new
					 ifNotConnectedThen: RSGridLayout new;
					 else: (RSClusteringLayout new 
					    clustersLayout: RSFlowLayout new;
					    forEachLayout: RSTreeLayout new)
]

{ #category : #'public - layout' }
RSLayoutBuilder >> tree [
	^ layout := RSTreeLayout new.
]

{ #category : #'public - layout' }
RSLayoutBuilder >> vertical [
	^ layout := RSVerticalLineLayout new.
]
