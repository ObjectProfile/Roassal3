"
Used to select a layout class with filter enabled
"
Class {
	#name : #RSSelectDialog,
	#superclass : #SpSelectDialog,
	#instVars : [
		'fastTable'
	],
	#category : #'Roassal3-Spec-Examples-Layouts-Utils'
}

{ #category : #layout }
RSSelectDialog class >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: #list;
		yourself
]

{ #category : #initialization }
RSSelectDialog >> initializePresenters [
	super initializePresenters.
	list := SpMorphPresenter new.
	
	fastTable := FTTableMorph new
		enableFilter;
		explicitFunction;
		selectionColor: self theme selectionColor;
		secondarySelectionColor: Color red;
		onAnnouncement: FTStrongSelectionChanged do: [ :evt | self accept ];
		yourself.
	list morph: fastTable
]

{ #category : #api }
RSSelectDialog >> items: aCollection [
	| dataSource |
	"create a new FTExampleDataSource to have selection in the list"
	dataSource := RSDataSourceLayoutStudio elements: aCollection.
	fastTable dataSource: dataSource.
	fastTable selectIndex: 1.
	
]

{ #category : #'api - showing' }
RSSelectDialog >> openModal [
	| dialog |
	
	dialog := self asModalWindow open.
	^ dialog isOk
		ifTrue: [ fastTable dataSource elementAt: fastTable selectedIndex ]
		ifFalse: [ nil ]
]
