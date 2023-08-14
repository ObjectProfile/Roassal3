Class {
	#name : #RSBarPlotNew,
	#superclass : #RSAbstractBandPlot,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #examples }
RSBarPlotNew class >> example01BarPlot [
	| p1 data1 |
	data1 := {  9. 9. 7. 20. 5. 10. }.
	p1 := self new data: data1.
	^ p1 open.
]

{ #category : #examples }
RSBarPlotNew class >> example02BarPlotHorizontal [
	| p1 data1 |
	data1 := {  9. 9. 7. 19. 5. 10. }.
	p1 := (self new) data: data1.
	p1 horizontal.
	^ p1 open.
]

{ #category : #examples }
RSBarPlotNew class >> exampleClusterBarPlots [
	| p1 p2 chart data1 data2 x |
	data1 := {  10. 9. 7 }. "blue"
	data2	:= { 20. 15. 8 }. "orange"
	x := { 1. 2. 3. }.
	p1 := (self new) data: data1.
	p2 := (self new) data: data2.
	chart := p1 + p2.
	^ chart open.
]

{ #category : #examples }
RSBarPlotNew class >> exampleClusterBarPlots4Bars [
	| p1 p2 chart data1 data2 x p3 p4|
	data1 := {  10. 9. 7 }. "blue"
	data2	:= { 20. 15. 8 }. "orange"
	x := { 1. 2. 3. }.
	p1 := self new data: data1.
	p2 := self new data: data2.
	p3 := self new data: data1.
	p4 := self new data: data2.
	chart := p1 + p2 + p3 + p4.
	^ chart open.
]

{ #category : #'accessing - defaults' }
RSBarPlotNew >> bandValues [
	^ (1 to: self numberOfBands)
]

{ #category : #testing }
RSBarPlotNew >> canHandleCluster [
	^ true
]

{ #category : #accessing }
RSBarPlotNew >> createdShapes [
	^ { bandPlotShapes }
]

{ #category : #public }
RSBarPlotNew >> data: aCollection [
	bandPlotShapes := aCollection collect: [ :value | RSBarPlotShape data: value ].
]

{ #category : #'accessing - defaults' }
RSBarPlotNew >> defaultShape [

	^ RSBox new noPaint
]

{ #category : #initialization }
RSBarPlotNew >> initialize [
	super initialize.
	horizontal := false.
	bandPlotShapes := OrderedCollection new.
	offset := 0.
]

{ #category : #'accessing - defaults' }
RSBarPlotNew >> numberOfBands [
	^ bandPlotShapes size
]

{ #category : #rendering }
RSBarPlotNew >> renderIn: canvas [
	super renderIn: canvas.
	self computeBandsOffset.
	self computeBandsWidth.
	bandPlotShapes doWithIndex: [ :barPlotShape :idx |
		barPlotShape color ifNil: [ barPlotShape color: self computeColor. ].
		barPlotShape bandScale: bandScale.
		barPlotShape dataScale: dataScale.
		barPlotShape renderIn: canvas ].
]
