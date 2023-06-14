Class {
	#name : #RSExamplesBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'examplesList',
		'visualization',
		'examplesClass'
	],
	#category : #'Roassal3-Bloc-Examples'
}

{ #category : #specs }
RSExamplesBrowserPresenter class >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  borderWidth: 10;
		  add: (SpPanedLayout newHorizontal
			  positionOfSlider: 33 percent;
			  add: #examplesList;
			  add: #visualization;
			  yourself);
		  yourself
]

{ #category : #examples }
RSExamplesBrowserPresenter class >> exampleOpenRSBlocExamples [

	| app presenter |
	app := SpApplication new.

	presenter := self newApplication: app model: RSBlocExamples.
	presenter open

]

{ #category : #initialization }
RSExamplesBrowserPresenter >> connectPresenters [

	super connectPresenters.

	examplesList
		whenSelectionChangedDo: [ :aSelection | 
			self refreshAccordingToSelectedExample ];
		whenActivatedDo: [ :aSelection | 
			(examplesClass >> aSelection selectedItem) browse ]
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> initializePresenters [ 

	super initializePresenters.
	
	examplesList := self newList.
	visualization := self instantiate: SpBlSpaceInMorphPresenter.

	self refresh.
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Roassal3 Examples Browser - ', examplesClass name;
		initialExtent: 800 @ 600;
		centered
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> refresh [

	examplesList
		unselectAll;
		items: examplesClass allExampleSelectors.

	self refreshAccordingToSelectedExample
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> refreshAccordingToSelectedExample [

	examplesList selectedItem
		ifNil: [ self showNullVisualization ]
		ifNotNil: [ :item | self showVisualizationFor: item ]
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> setModelBeforeInitialization: aClass [

	examplesClass := aClass
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> showNullVisualization [

	visualization space root 
		removeChildren;
		addChild: (BlElement new
			 background: Color transparent;
			 yourself)
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> showVisualizationFor: aSelector [

	| aRSCanvas |
	aRSCanvas := examplesClass new perform: aSelector.
	aRSCanvas useBlocHost.
	visualization space root 
		removeChildren;
		addChild: aRSCanvas host canvasElement
]
