"
Each ColorPalette is a set of beautiful color schemes in a context for a specific purpose.

Each palette contains several color schemes. Each scheme can be selected in different numbers of colors: 3 or 5 or 11 (depends on each scheme).

We have three palettes:
- Qualitative: helps to distinguish different classes of data. 
- Sequential: useful for showing graduable data with a very light ""low color"" increasing darkness to ""high color"".
- Diverging: it contains color scales with diverging colors on the extremes and transition colors from one extreme to the other. 

More detailed information is on it class comments.

To see the palettes:
RSShapeBasicExamples new example34PaletteVisualization open

---Copyright:
All colors, palettes and schemes are from www.ColorBrewer.org by Cynthia A. Brewer, Geography, Pennsylvania State University.
Code by Cynthia is under the Apache License 2.0 (https://github.com/axismaps/colorbrewer/blob/master/LICENCE.txt)
Roassal3 is distributed under the MIT License, which is compatible with Apache License 2.0 
"
Class {
	#name : #RSColorPalette,
	#superclass : #RSObject,
	#category : #'Roassal3-Colors'
}

{ #category : #'instance creation' }
RSColorPalette class >> diverging [
	^ RSDivergingColorPalette new
]

{ #category : #accessing }
RSColorPalette class >> paletteName [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
RSColorPalette class >> qualitative [
	^ RSQualitativeColorPalette new
]

{ #category : #'instance creation' }
RSColorPalette class >> sequential [
	^ RSSequentialColorPalette new
]

{ #category : #'instance creation' }
RSColorPalette >> fromTriplet: array [
	^ NSScale ordinal
		range: (array collect: [ :arr |
			Color
				r: arr first
				g: arr second
				b: arr third
				range: 255 ]);
		yourself
]
