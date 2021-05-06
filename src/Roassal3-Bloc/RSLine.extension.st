Extension { #name : #RSLine }

{ #category : #'*Roassal3-Bloc' }
RSLine >> asBlElement [

	^ self asBlGeometry asElement
		  size: self encompassingRectangle extent;
		  border: self blBorder;
		  background: self blPaint;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSLine >> asBlGeometry [
	
	^ BlLineGeometry from: self startPoint to: self endPoint
]
