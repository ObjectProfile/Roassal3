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
RSExamplesBrowserPresenter class >> defaultSpec [

	^ SpBoxLayout newLeftToRight
		  borderWidth: 10;
		  add: (SpPanedLayout newHorizontal
			  positionOfSlider: 67 percent;
			  add: #visualization;
			  add: #examplesList;
			  yourself);
		  yourself
]

{ #category : #examples }
RSExamplesBrowserPresenter class >> exampleOpenRSBlocExamples [

	| app presenter |
	app := SpApplication new 
	  useBackend: #Brick;
	  yourself.

	presenter := self newApplication: app model: RSBlocExamples.
	presenter openWithSpec.

]

{ #category : #initialization }
RSExamplesBrowserPresenter >> connectPresenters [

	super connectPresenters.
	
	examplesList whenSelectionChangedDo: [ :aSelection |
		self refreshAccordingToSelectedExample ]
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> initializePresenters [ 

	super initializePresenters.
	
	examplesList := self newList.
	visualization := self instantiate: SpBlElementPresenter.

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
RSExamplesBrowserPresenter >> setModelBeforeInitialization: aExamplesModel [

	examplesClass := aExamplesModel
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> showNullVisualization [

	visualization element: (BlElement new
			 background: Color transparent;
			 yourself)
]

{ #category : #initialization }
RSExamplesBrowserPresenter >> showVisualizationFor: aSelector [

	| aRSCanvas |
	aRSCanvas := examplesClass new perform: aSelector.
	aRSCanvas useBlocHost.
	visualization element: aRSCanvas host mainElement.

]
