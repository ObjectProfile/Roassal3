"
Takes as input a ""data source"" plot an Occurrence Matrix, a matrix which represents occurrence statistics between data. Each cell (i,j) of a matrix is the number of times the element appear for a row i in column j.

The input data source should implement these methods:

  - `columnNames`
  - `rowNames` 
  - `rows`

## Usage Example

```language=Pharo
	RSCoOccurrenceMatrixBuilder new
		dataSource: ((Smalltalk	at: #DataFrame) readFromCsvWithRowNames: RSCoOccurrenceMatrixBuilder sampleMatrix);
		open.
```

"
Class {
	#name : 'RSCoOccurrenceMatrixBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'colorScale',
		'dataSource',
		'rowSize',
		'columnSize',
		'domainRange'
	],
	#category : 'Roassal-Builders-Core',
	#package : 'Roassal-Builders',
	#tag : 'Core'
}

{ #category : 'examples' }
RSCoOccurrenceMatrixBuilder class >> sampleMatrix [

	^ '"","col_1","col_2","col_3","col_4","col_5","col_6","col_7","col_8","col_9"
"row_1","1","0","1","1","1","1","1","1","1"
"row_2","1","1","0","1","0","1","1","1","0"
"row_3","0","0","0","0","1","0","0","0","0"
"row_4","0","1","0","0","1","0","1","0","0"
"row_5","0","0","0","0","1","0","0","0","0"
"row_6","0","1","0","0","1","0","0","0","1"
"row_7","0","0","0","0","0","0","0","0","0"
"row_8","0","0","0","0","0","0","1","0","0"
"row_9","0","0","0","0","0","0","0","0","0"
"row_10","0","1","0","0","0","0","0","0","0"
"row_11","0","1","0","0","0","0","0","1","0"
"row_12","0","0","0","0","0","0","1","0","0"'
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> colorScale [
	" Answer a scale on the receiver's domain range "

	^ colorScale
		ifNil: [ colorScale := NSScale category20 domain: self domainRange asArray ]
]

{ #category : 'accessing' }
RSCoOccurrenceMatrixBuilder >> colorScale: anObject [

	colorScale := anObject
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> columnNames [
	"Answer a <Collection> of <String> representing the receiver's data source column names"

	^ self dataSource columnNames
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> columnSize [
	"Answer the <Number> of columns in the receiver's data source"

	^ columnSize
		ifNil: [ columnSize :=  self dataSource columns size ]
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createBoundingBoxIn: canvas [

	canvas addShape: (RSBox new
			 extent: self columnSize @ self rowSize + 2;
			 position: self columnSize @ self rowSize / 2;
			 noPaint;
			 border: (RSBorder new
					  color: Color black;
					  joinMiter;
					  width: 0.1);
			 yourself)
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createColumnTicksIn: canvas [

	self columnNames doWithIndex: [ :columnName :x |
		| p1 p2 tickLine label |
		p1 := x @ rowSize + (0 @ 1).
		p2 := p1 - (0 @ 1).
		tickLine := self createTickLineStart: p2 end: p1.
		label := self createLabelFor: columnName.
		label rotateByDegrees: -45.
		RSLocation new
			bottom;
			right;
			orientation: 1 @ -1;
			offset: 0.3 @ 0;
			move: label on: tickLine.
		canvas addShape: tickLine.
		canvas addShape: label ]
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createDataPointAt: x at: y value: value [

	^ RSCircle new
		  model: value;
		  position: x @ y;
		  size: value;
		  color: (self colorScale scale: value);
		  yourself
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createDataPointsIn: canvas [

	self rows doWithIndex: [ :row :y |
		row doWithIndex: [ :value :x |
			value isZero ifFalse: [
				canvas add: (self createDataPointAt: x at: y value: value) ] ] ]
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createInteractionsIn: canvas [

	canvas nodes @ RSHighlightable red.
	canvas nodes @ (RSPopup new
		model: #yourself;
		text: [: shape | shape position ])
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createLabelFor: columnName [

	^ RSLabel new
		  scaleBy: 0.05;
		  text: columnName;
		  color: Color black;
		  yourself
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createLegendIn: canvas [

	| lb |
	lb := RSLegend new.
	lb layout vertical.
	lb location inner; top; right; offset: (-10 @ 10).
	lb container: canvas.
	self domainRange doWithIndex: [ : domainValue : index |
		lb
			text: domainValue asString
			withBoxColor: (self colorScale scale: domainValue) ].
	lb legendDo: [ :l |
		l
			scaleBy: 0.5;
			withBorder;
			padding: 30 ].
	lb onDemand: 'Info'.
	lb build
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createRowTicksIn: canvas [

	self rowNames doWithIndex: [ : rowName : y |
		| p1 p2 tickLine label |

		p1 := -1 @ y.
		p2 := p1 + (1 @ 0).
		tickLine := self createTickLineStart: p2 end: p1.
		label := self createLabelFor: rowName.
		RSLocation new
			left;
			outer;
			offset: -0.3 @ 0;
			move: label on: tickLine.
		canvas addShape: tickLine.
		canvas addShape: label ]
]

{ #category : 'hooks' }
RSCoOccurrenceMatrixBuilder >> createTickLineStart: p2 end: p1 [

	^ RSLine new
		  startPoint: p1;
		  endPoint: p2;
		  color: Color black;
		  width: 0.1;
		  yourself
]

{ #category : 'accessing' }
RSCoOccurrenceMatrixBuilder >> dataSource [

	^ dataSource
]

{ #category : 'accessing' }
RSCoOccurrenceMatrixBuilder >> dataSource: anObject [

	dataSource := anObject
]

{ #category : 'accessing - defaults' }
RSCoOccurrenceMatrixBuilder >> defaultContainer [

	| c |
	c := RSCanvasController new.
	c configuration maxScale: 200.
    ^ RSCanvas new @ c
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> domainRange [

	^ domainRange
		ifNil: [ domainRange := 1 to: 10 ]
]

{ #category : 'accessing' }
RSCoOccurrenceMatrixBuilder >> domainRange: anObject [

	domainRange := anObject
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> renderIn: canvas [

	self createBoundingBoxIn: canvas.
	self createColumnTicksIn: canvas.
	self createRowTicksIn: canvas.
	self createDataPointsIn: canvas.
	self createLegendIn: canvas.
	self createInteractionsIn: canvas
]

{ #category : 'accessing' }
RSCoOccurrenceMatrixBuilder >> rowNames [

	^ self dataSource rowNames
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> rowSize [
	"Answer the <Number> of rows in the receiver's data source"

	^ rowSize
		ifNil: [ rowSize := self dataSource rows size ]
]

{ #category : 'rendering' }
RSCoOccurrenceMatrixBuilder >> rows [
	"Answer a <Collection> of <Object> representing the receiver's data source rows"

	^ self dataSource rows
]
