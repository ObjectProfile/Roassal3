Class {
	#name : 'RSTickLocatorTest',
	#superclass : 'RSTest',
	#instVars : [
		'ticks'
	],
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'running' }
RSTickLocatorTest >> setUp [

	super setUp.
	ticks := RSHorizontalTick new.
	ticks xScale: NSScale linear.
	ticks xScale
		domain: #( 0 6 );
		range: #( 0 200 )
]

{ #category : 'tests' }
RSTickLocatorTest >> testAutoLocatorDataIsOk [

	| data |
	ticks numberOfTicks: 8.
	data := ticks ticksData.

	self assert: (data at: 3) equals: 2.
	self assert: (data at: 5) equals: 4
]

{ #category : 'tests' }
RSTickLocatorTest >> testAutoLocatorIsDefault [

	self assert: ticks locator class equals: RSAutoLocator
]

{ #category : 'tests' }
RSTickLocatorTest >> testAutoLocatorNumberOfTicksIsOk [

	ticks numberOfTicks: 3.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 3
]

{ #category : 'tests' }
RSTickLocatorTest >> testAutoLocatorNumberOfTicksIsOk2 [

	ticks numberOfTicks: 8.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 7
]

{ #category : 'tests' }
RSTickLocatorTest >> testAutoLocatorNumberOfTicksIsOk3 [

	ticks numberOfTicks: 11.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 13
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorDataIsOk [

	| ticksCol data |
	ticksCol := { 0. 1. 4. 6 }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).
	data := ticks ticksData.

	self assert: data equals: #( 0 1 4 6 )
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorDataIsOkWithCollectionTooLarge [

	| ticksCol data |
	ticksCol := { -1. 0. 1. 4. 6. 9 }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).
	data := ticks ticksData.

	self assert: data equals: #( 0 1 4 6 )
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorDataIsOkWithUnsortedCollection [

	| ticksCol data |
	ticksCol := { 6. 1. 0. 4 }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).
	data := ticks ticksData.

	self assert: data equals: #(0 1 4 6)
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorNumberOfTicksIsOk [

	| ticksCol data |
	ticksCol := { 0. 1. 4. 6 }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).
	data := ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 4
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorNumberOfTicksIsOkWithCollectionTooLarge [

	| ticksCol data |
	ticksCol := { -1. 0. 1. 4. 6. 9 }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).
	data := ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 4
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorNumberOfTicksIsOkWithUnsortedCollection [

	| ticksCol data |
	ticksCol := { 6. 1. 0. 4 }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).
	data := ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 4
]

{ #category : 'tests' }
RSTickLocatorTest >> testFixedLocatorRaisesErrorWithEmptyCollection [

	| ticksCol |
	ticksCol := {  }.
	ticks locator: (RSFixedLocator new ticks: ticksCol).

	self should: [ ticks ticksData ] raise: Error
]

{ #category : 'tests' }
RSTickLocatorTest >> testLinearLocatorDataIsOk [

	| data |
	ticks
		numberOfTicks: 8;
		locator: RSLinearLocator new.
	data := ticks ticksData.

	self assert: (data at: 3) equals: 12 / 7.
	self assert: (data at: 5) equals: 24 / 7
]

{ #category : 'tests' }
RSTickLocatorTest >> testLinearLocatorNumberOfTicksIsOk [

	ticks
		numberOfTicks: 8;
		locator: RSLinearLocator new.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 8
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorBaseIsCorrectlyChanged [

	| locator |
	locator := RSLogLocator new base: 2.

	self assert: locator base equals: 2
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorDataIsOk [

	| data |
	ticks xScale: (NSLogScale new domain: #( 0.001 1000 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: (data at: 1) equals: 1/1000.
	self assert: (data at: 2) equals: 1/100.
	self assert: (data at: 3) equals: 1/10.
	self assert: (data at: 4) equals: 1.
	self assert: (data at: 5) equals: 10.
	self assert: (data at: 6) equals: 100.
	self assert: (data at: 7) equals: 1000
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorDataIsOkStartingAtNegative [

	| data |
	ticks xScale: (NSLogScale new domain: #( -1 1000 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: (data at: 1) equals: 1/1000.
	self assert: (data at: 2) equals: 1/100.
	self assert: (data at: 3) equals: 1/10.
	self assert: (data at: 4) equals: 1.
	self assert: (data at: 5) equals: 10.
	self assert: (data at: 6) equals: 100.
	self assert: (data at: 7) equals: 1000
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorDataIsOkStartingAtZero [

	| data |
	ticks xScale: (NSLogScale new domain: #( 0 1000 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: (data at: 1) equals: 1/1000.
	self assert: (data at: 2) equals: 1/100.
	self assert: (data at: 3) equals: 1/10.
	self assert: (data at: 4) equals: 1.
	self assert: (data at: 5) equals: 10.
	self assert: (data at: 6) equals: 100.
	self assert: (data at: 7) equals: 1000
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorDataIsOkWithReversedDomain [

	| data |
	ticks xScale: (NSLogScale new domain: #( 1000 0.001 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: (data at: 1) equals: 1/1000.
	self assert: (data at: 2) equals: 1/100.
	self assert: (data at: 3) equals: 1/10.
	self assert: (data at: 4) equals: 1.
	self assert: (data at: 5) equals: 10.
	self assert: (data at: 6) equals: 100.
	self assert: (data at: 7) equals: 1000
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorDefaultBaseIs10 [

	| locator |
	locator := RSLogLocator new.

	self assert: locator base equals: 10
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorDefaultSmallestPowerIsMinus3 [

	| locator |
	locator := RSLogLocator new.

	self assert: locator smallestPower equals: -3
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorNumberOfTicksIsOk [

	| data |
	ticks xScale: (NSLogScale new domain: #( 0.001 1000 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: data size equals: 7
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorNumberOfTicksIsOkStartingAtNegative [

	| data |
	ticks xScale: (NSLogScale new domain: #( -1 1000 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: data size equals: 7
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorNumberOfTicksIsOkStartingAtZero [

	| data |
	ticks xScale: (NSLogScale new domain: #( 0 1000 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: data size equals: 7
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorNumberOfTicksIsOkWithReversedDomain [

	| data |
	ticks xScale: (NSLogScale new domain: #( 1000 0.001 )).
	ticks locator: RSLogLocator new.
	data := ticks ticksData.

	self assert: data size equals: 7
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorRaisesErrorWithNegativeData [

	ticks xScale: (NSLogScale new domain: #( -10 -1 )).
	ticks locator: RSLogLocator new.
	self should: [ ticks ticksData ] raise: DomainError
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorSmallestIndexIsCorrect [

	| locator |
	locator := RSLogLocator new.

	self assert: locator smallestIndex equals: 10**(-3)
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorSmallestIndexIsCorrectAfterChangingBase [

	| locator |
	locator := RSLogLocator new base: 2.

	self assert: locator smallestIndex equals: 2**(-3)
]

{ #category : 'tests' }
RSTickLocatorTest >> testLogLocatorSmallestIndexIsCorrectAfterChangingSmallestPower [

	| locator |
	locator := RSLogLocator new smallestPower: -2.

	self assert: locator smallestIndex equals: 10**(-2)
]

{ #category : 'tests' }
RSTickLocatorTest >> testTickLocatorCorrectlyChanged [

	ticks locator: RSLinearLocator new.
	ticks ticksData.

	self assert: ticks locator class equals: RSLinearLocator
]
