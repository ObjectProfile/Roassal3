Class {
	#name : 'RSQuantile',
	#superclass : 'RSObject',
	#instVars : [
		'data'
	],
	#category : 'Roassal-Chart-Statistics',
	#package : 'Roassal-Chart',
	#tag : 'Statistics'
}

{ #category : 'accessing' }
RSQuantile class >> data: aCollection [
	| aRSQuantile |
	aRSQuantile := self new.
	aRSQuantile data: aCollection.
	^ aRSQuantile
]

{ #category : 'initialize' }
RSQuantile >> compute: populationPercentage [
	^ self subclassResponsibility
]

{ #category : 'initialize' }
RSQuantile >> data: aCollection [
	data := aCollection
]
