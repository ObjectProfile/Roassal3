"
A RTDynamicEqualizerGrapherTest is a test class for testing the behavior of RTDynamicEqualizerGrapher
"
Class {
	#name : #RTDynamicEqualizerGrapherTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal3-Test-Grapher-Tests-Builder-Grapher'
}

{ #category : #running }
RTDynamicEqualizerGrapherTest >> setUp [
	super setUp.
	b := RTDynamicEqualizerGrapher new
]

{ #category : #tests }
RTDynamicEqualizerGrapherTest >> testBasic [
	self assert: b numberOfMetrics equals: 0
]
