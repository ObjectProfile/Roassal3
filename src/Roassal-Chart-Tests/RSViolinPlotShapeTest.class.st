Class {
	#name : 'RSViolinPlotShapeTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Core',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
RSViolinPlotShapeTest >> testCreateInstanceWithDataset [
	| data violinShape |
	data := { 5. 1. 2. 3. 4. }.
	violinShape := RSViolinPlotShape data: data.
	self assert: violinShape data equals: data.
	self assert: violinShape dataSorted equals: { 1. 2. 3. 4. 5. }
]

{ #category : 'tests' }
RSViolinPlotShapeTest >> testDensityArea [
	| data violinShape xScale yScale |
	data := { 5. 1. 2. 3. 4. }.
	xScale := NSScale ordinal
		domain: {1};
		rangeBands: {0. 360. }.
	yScale := NSScale linear
		domain: data;
		range: { 0. 360. }.
	violinShape := RSViolinPlotShape data: data.
	violinShape scales: {xScale. yScale}.
	violinShape bandWidth: xScale rangeBand.
	violinShape bandOffset: (xScale scale: 1).
	self assert: violinShape densityArea class equals: RSPolygon
]
