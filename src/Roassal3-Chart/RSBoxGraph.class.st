Class {
	#name : #RSBoxGraph,
	#superclass : #RSObject,
	#instVars : [
		'boxPoints',
		'medianLinePoints',
		'centerLinePoints',
		'outliersPoints',
		'centerLine',
		'box',
		'medianLine',
		'outliers'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxGraph >> box [
	^ box
]

{ #category : #accessing }
RSBoxGraph >> box: aRSPolygon [
	box := aRSPolygon
]

{ #category : #accessing }
RSBoxGraph >> boxPoints [
	^ boxPoints
]

{ #category : #accessing }
RSBoxGraph >> boxPoints: aCollectionOfPoints [
	boxPoints := aCollectionOfPoints
]

{ #category : #accessing }
RSBoxGraph >> centerLine [
	^ centerLine
]

{ #category : #accessing }
RSBoxGraph >> centerLine: aRSPolyline [
	centerLine := aRSPolyline
]

{ #category : #accessing }
RSBoxGraph >> centerLinePoints [
	^ centerLinePoints
]

{ #category : #accessing }
RSBoxGraph >> centerLinePoints: aCollectionOfPoints [
	centerLinePoints := aCollectionOfPoints
]

{ #category : #accessing }
RSBoxGraph >> medianLine [
	^ medianLine
]

{ #category : #accessing }
RSBoxGraph >> medianLine: aRSPolyline [
	medianLine := aRSPolyline
]

{ #category : #accessing }
RSBoxGraph >> medianLinePoints [
	^ medianLinePoints
]

{ #category : #accessing }
RSBoxGraph >> medianLinePoints: aCollectionOfPoints [
	medianLinePoints := aCollectionOfPoints
]

{ #category : #accessing }
RSBoxGraph >> outliers [
	^ outliers
]

{ #category : #accessing }
RSBoxGraph >> outliers: aRSGroupOfRSElipses [
	outliers := aRSGroupOfRSElipses
]

{ #category : #accessing }
RSBoxGraph >> outliersPoints [
	^ outliersPoints
]

{ #category : #accessing }
RSBoxGraph >> outliersPoints: aCollectionOfPoints [
	outliersPoints := aCollectionOfPoints
]
