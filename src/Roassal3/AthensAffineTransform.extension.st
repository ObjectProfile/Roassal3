Extension { #name : #AthensAffineTransform }

{ #category : #'*Roassal3' }
AthensAffineTransform >> asFloatTransform [
	^ self copy floatValues; yourself
]

{ #category : #'*Roassal3' }
AthensAffineTransform >> floatValues [
	"convert all the values to float"
	x := x asFloat.
	y := y asFloat.
	sx := sx asFloat.
	sy := sy asFloat.
	shx := shx asFloat.
	shy := shy asFloat
]

{ #category : #'*Roassal3' }
AthensAffineTransform >> printOn: stream [
	stream << 'x: '. x printOn: stream.
	stream << ' y: '. y printOn: stream.
	stream << ' sx: '. sx printOn: stream.
	stream << ' sy: '. sy printOn: stream.
	stream << ' shx: '. shx printOn: stream.
	stream << ' shy: '. shy printOn: stream
]
