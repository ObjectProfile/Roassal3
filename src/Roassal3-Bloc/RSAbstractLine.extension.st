Extension { #name : #RSAbstractLine }

{ #category : #'*Roassal3-Bloc' }
RSAbstractLine >> asBlElement [

	^ self asBlGeometry asElement
		  roassalShape: self;
		  size: self encompassingRectangle extent;
		  border: self blBorder;
		  background: self blPaint;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSAbstractLine >> asBlGeometry [

	^ self subclassResponsibility
]
