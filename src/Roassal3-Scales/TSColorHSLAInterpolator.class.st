"
reate a color with the given hue, saturation, lightness, and alpha.
"
Class {
	#name : #TSColorHSLAInterpolator,
	#superclass : #TSColorRGBAInterpolator,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolation }
TSColorHSLAInterpolator >> interpolate: t [
	^ Color
		h: start hue + ((stop hue - start hue) * t)
		s: start hslSaturation + ((stop hslSaturation - start hslSaturation)  * t)
		l: start luminance + ((stop luminance - start luminance) * t)
		alpha: start alpha + ((stop alpha - start alpha) * t)
]
