"
Abstract class for all tick locators. A tick locator defines where the ticks of a chart should be.
"
Class {
	#name : 'RSTickLocator',
	#superclass : 'Object',
	#category : 'Roassal3-Chart-Ticks',
	#package : 'Roassal3-Chart',
	#tag : 'Ticks'
}

{ #category : 'generate' }
RSTickLocator >> generateTicks: aScale with: numberOfTicks [
	
	^ self subclassResponsibility
]
