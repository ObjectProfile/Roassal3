Extension { #name : 'AthensAffineTransform' }

{ #category : '*Roassal' }
AthensAffineTransform >> asFloatTransform [
	^ self copy floatValues; yourself
]

{ #category : '*Roassal' }
AthensAffineTransform >> floatValues [
	"convert all the values to float"
	x := x asFloat.
	y := y asFloat.
	sx := sx asFloat.
	sy := sy asFloat.
	shx := shx asFloat.
	shy := shy asFloat
]

{ #category : '*Roassal' }
AthensAffineTransform >> printOn: stream [
	stream << 'x: '. x printOn: stream.
	stream << ' y: '. y printOn: stream.
	stream << ' sx: '. sx printOn: stream.
	stream << ' sy: '. sy printOn: stream.
	stream << ' shx: '. shx printOn: stream.
	stream << ' shy: '. shy printOn: stream
]
