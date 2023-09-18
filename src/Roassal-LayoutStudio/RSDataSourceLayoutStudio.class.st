"
Data source based on `FTExampleDataSource` to have a custom table
"
Class {
	#name : #RSDataSourceLayoutStudio,
	#superclass : #FTExampleDataSource,
	#category : #'Roassal-LayoutStudio-Utils'
}

{ #category : #private }
RSDataSourceLayoutStudio >> colorFor: rowIndex [
	^ (super colorFor: rowIndex) alpha: 0.5
]
