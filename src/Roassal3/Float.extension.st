Extension { #name : 'Float' }

{ #category : '*Roassal3' }
Float class >> bronzeRatio [

	^ 1.0 - self silverRatio
]

{ #category : '*Roassal3' }
Float class >> goldenPlatinumRatio [

	^ self goldenRatio + self platinumRatio
]

{ #category : '*Roassal3' }
Float class >> goldenRatio [

	^ 1.61803398874989484820458683436563811772030917980576286213544862270526046281890244970720720418939113748475
]

{ #category : '*Roassal3' }
Float class >> platinumRatio [

	^ self goldenRatio + 1
]

{ #category : '*Roassal3' }
Float class >> silverRatio [

	^ self goldenRatio - 1
]

{ #category : '*Roassal3' }
Float class >> π [

	^ self pi
]
