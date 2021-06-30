Extension { #name : #RSBezier }

{ #category : #'*Roassal3-Bloc' }
RSBezier >> asBlElement [
	"Note: We don't use the geometry's #asElement because it answers an element that doesn't use the 'blPaint' to fill."

	^ BlElement new
		  roassalShape: self;
		  geometry: self asBlGeometry;
		  outskirts: BlOutskirts centered;
		  size: self encompassingRectangle extent;
		  border: self blBorder;
		  background: self blPaint;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSBezier >> asBlGeometry [

	^ BlBezierCurveGeometry controlPoints: self controlPoints
]
