"
A RSKiviatTest is a test class for testing the behavior of RSKiviat
"
Class {
	#name : #RSKiviatTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Radar'
}

{ #category : #tests }
RSKiviatTest >> testBasic [
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 2 3).
	kiviat axisNames: #(name).
	self assert: kiviat shouldUseEllipse.
	self assert: kiviat radius equals: 200.
	self should: [ kiviat build ] raise: Error.
]
