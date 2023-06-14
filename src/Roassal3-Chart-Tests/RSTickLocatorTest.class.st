Class {
	#name : #RSTickLocatorTest,
	#superclass : #RSTest,
	#instVars : [
		'ticks'
	],
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #running }
RSTickLocatorTest >> setUp [

	super setUp.
	ticks := RSHorizontalTick new.
	ticks xScale: NSScale linear.
	ticks xScale
		domain: #( 0 6 );
		range: #( 0 200 )
]

{ #category : #tests }
RSTickLocatorTest >> testAutoLocatorDataIsOk [

	| data |
	ticks numberOfTicks: 8.
	data := ticks ticksData.

	self assert: (data at: 3) equals: 2.
	self assert: (data at: 5) equals: 4
]

{ #category : #tests }
RSTickLocatorTest >> testAutoLocatorIsDefault [

	self assert: ticks locator class equals: RSAutoLocator
]

{ #category : #tests }
RSTickLocatorTest >> testAutoLocatorNumberOfTicksIsOk [

	ticks numberOfTicks: 3.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 3
]

{ #category : #tests }
RSTickLocatorTest >> testAutoLocatorNumberOfTicksIsOk2 [

	ticks numberOfTicks: 8.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 7
]

{ #category : #tests }
RSTickLocatorTest >> testAutoLocatorNumberOfTicksIsOk3 [

	ticks numberOfTicks: 11.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 13
]

{ #category : #tests }
RSTickLocatorTest >> testLinearLocatorDataIsOk [

	| data |
	ticks
		numberOfTicks: 8;
		locator: RSLinearLocator new.
	data := ticks ticksData.

	self assert: (data at: 3) equals: 12 / 7.
	self assert: (data at: 5) equals: 24 / 7
]

{ #category : #tests }
RSTickLocatorTest >> testLinearLocatorNumberOfTicksIsOk [

	ticks
		numberOfTicks: 8;
		locator: RSLinearLocator new.
	ticks ticksData.

	self assert: ticks configuration numberOfTicks equals: 8
]

{ #category : #tests }
RSTickLocatorTest >> testTickLocatorCorrectlyChanged [

	ticks locator: RSLinearLocator new.
	ticks ticksData.

	self assert: ticks locator class equals: RSLinearLocator
]
