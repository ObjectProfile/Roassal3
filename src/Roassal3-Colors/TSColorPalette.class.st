"
Each ColorPalette is a set of beautiful color schemes in a context for a specific purpose.

Each palette contains several color schemes. Each scheme can be selected in different numbers of colors: 3 or 5 or 11 (depends on each scheme).

We have three palettes:
- Qualitative: helps to distinguish different classes of data. 
- Sequential: useful for showing graduable data with a very light ""low color"" increasing darkness to ""high color"".
- Diverging: it contains color scales with diverging colors on the extremes and transition colors from one extreme to the other. 

More detailed information is on it class comments.

---Copyright:
All colors, palettes and schemes are from www.ColorBrewer.org by Cynthia A. Brewer, Geography, Pennsylvania State University.
"
Class {
	#name : #TSColorPalette,
	#superclass : #TSObject,
	#category : #'Roassal3-Colors'
}

{ #category : #'instance creation' }
TSColorPalette class >> diverging [
	^ TSCPDiverging new
]

{ #category : #'instance creation' }
TSColorPalette class >> qualitative [
	^ TSCPQualitative new
]

{ #category : #'instance creation' }
TSColorPalette class >> sequential [
	^ TSCPSequential new
]

{ #category : #'instance creation' }
TSColorPalette >> fromTriplet: array [
	^ TSScale ordinal
		range: (array collect: [ :arr | 
			Color
				r: arr first
				g: arr second
				b: arr third
				range: 255 ]);
		yourself
]
