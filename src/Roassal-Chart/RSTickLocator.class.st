"
Abstract class for all tick locators. A tick locator defines where the ticks of a chart should be.
"
Class {
	#name : 'RSTickLocator',
	#superclass : 'Object',
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'generate' }
RSTickLocator >> generateTicks: aScale with: numberOfTicks [

	^ self subclassResponsibility
]
