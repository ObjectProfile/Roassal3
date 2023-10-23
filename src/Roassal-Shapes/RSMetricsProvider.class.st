"
A metric provider returns an instance of RSTextExtents, used by RSLabel.
Users can propose a different RSMetricProvider. RSLabel uses by default `RSMetricsProvider default`

"
Class {
	#name : 'RSMetricsProvider',
	#superclass : 'RSObject',
	#classVars : [
		'Default'
	],
	#category : 'Roassal-Shapes-TextMetrics',
	#package : 'Roassal-Shapes',
	#tag : 'TextMetrics'
}

{ #category : 'accessing' }
RSMetricsProvider class >> default [
	^ Default ifNil: [ Default := RSCairoMetricsProvider new ]
]

{ #category : 'accessing' }
RSMetricsProvider class >> default: aRSMetricsProvider [
	Default := aRSMetricsProvider
]

{ #category : 'hooks' }
RSMetricsProvider >> extentsOf: aRSLabel [
	^ self subclassResponsibility
]
