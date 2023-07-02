Class {
	#name : #RSBoxGraphGroupTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSBoxGraphGroupTest >> testAddOffsetToGroup [
	| boxGraphGroup data xCenterBeforeSetOffset xCenterAfterSetOffset |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	xCenterBeforeSetOffset := boxGraphGroup boxGraphics first centerLinePoints first x.
	boxGraphGroup addOffsetToGroup: 2.
	xCenterAfterSetOffset := boxGraphGroup boxGraphics first centerLinePoints first x.
	self assert: xCenterBeforeSetOffset < xCenterAfterSetOffset.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testDefaultOffset [
	| boxGraphGroup data firstBoxXCenter secondBoxXCenter |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	firstBoxXCenter := boxGraphGroup boxGraphics first centerLinePoints first x.
	secondBoxXCenter := boxGraphGroup boxGraphics second  centerLinePoints first x.
	self assert: boxGraphGroup defaultOffset equals: 2.
	self assert: firstBoxXCenter < secondBoxXCenter.
	self assert: firstBoxXCenter equals: 1.
	self assert: secondBoxXCenter equals: 3.
	self assert: (secondBoxXCenter-firstBoxXCenter) equals: boxGraphGroup defaultOffset.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testGroupOfOneBoxGraph [
	| boxGraphGroup data |
	data := { 1. 2. 3. 4. 5. }.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup boxGraphics size equals: 1.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testGroupOfSeveralBoxGraphics [
	| boxGraphGroup data |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup boxGraphics size equals: 2.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testMaxCenterValue [
	| boxGraphGroup data |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup maxCenter closeTo: 3.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testMaxXValue [
	| boxGraphGroup data |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup maxXValue closeTo: 3.7.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testMaxYValue [
	| boxGraphGroup data |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup maxYValue equals: 11.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testMinYValue [
	| boxGraphGroup data |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup minYValue equals: -1.
]

{ #category : #tests }
RSBoxGraphGroupTest >> testNumberOfBoxes [
	| boxGraphGroup data |
	data := {{ 1. 2. 3. 4. 5. }.{5. 6. 7. 8. 9.}}.
	boxGraphGroup := RSBoxGraphGroup data: data.
	self assert: boxGraphGroup numberOfBoxes equals: 2.
]
