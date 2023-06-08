Class {
	#name : #RSFlowChartTest,
	#superclass : #TestCase,
	#instVars : [
		'f'
	],
	#category : #'Roassal3-FlowChart'
}

{ #category : #running }
RSFlowChartTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	f := RSFlowChart new
]

{ #category : #tests }
RSFlowChartTest >> testEmpty [

	self assert: f numberOfElements equals: 0
]

{ #category : #tests }
RSFlowChartTest >> testSimpleChart [

	| c |
	f processLabeled: 'User Click Registration' as: #init.
	f inputOutputLabeled: 'Enters Employee number' as: #employee.
	f processLabeled: 'Create Registration' as: #createRegistration.
	f processLabeled: 'Error Message' as: #errorMessage.
	f decisionLabeled: 'User already exist in MopMap database?'
		as: #doesExist
		yes: #errorMessage
		no: #createRegistration.

	f flowFrom: #init to: #employee.
	f flowFrom: #employee to: #doesExist.

	self assert: f numberOfElements equals: 7.

	f build.
	c := f canvas.
	self assert: c numberOfShapes equals: 9
]
