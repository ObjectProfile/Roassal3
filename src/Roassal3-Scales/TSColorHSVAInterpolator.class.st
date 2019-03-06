"
Same as TSColorRGBAInterpolation but for hsva  
"
Class {
	#name : #TSColorHSVAInterpolator,
	#superclass : #TSColorRGBAInterpolator,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolation }
TSColorHSVAInterpolator >> interpolate: t [
	^ Color
		h: start hue + ((stop hue - start hue) * t)
		s: start hsvSaturation + ((stop hsvSaturation - start hsvSaturation)  * t)
		l: start luminance + ((stop luminance - start luminance) * t)
		alpha: start alpha + ((stop alpha - start alpha) * t)
]
