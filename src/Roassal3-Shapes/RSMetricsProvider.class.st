"
A metric provider returns an instance of RSTextExtents, used by RSLabel.
Users can propose a different RSMetricProvider. RSLabel uses by default `RSMetricProvider defaultProvider`

"
Class {
	#name : #RSMetricsProvider,
	#superclass : #RSObject,
	#classVars : [
		'default'
	],
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #accessing }
RSMetricsProvider class >> default [
	^ default ifNil: [ default := RSCairoMetricsProvider new ].
]

{ #category : #accessing }
RSMetricsProvider class >> default: aRSMetricsProvider [
	default := aRSMetricsProvider
]

{ #category : #hooks }
RSMetricsProvider >> extentsOf: aRSLabel [
	^ self subclassResponsibility
]
