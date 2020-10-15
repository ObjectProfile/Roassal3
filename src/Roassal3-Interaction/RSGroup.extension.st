Extension { #name : #RSGroup }

{ #category : #'*Roassal3-Interaction' }
RSGroup >> @ interaction [
	"Apply an interaction on each shape contained in the group.
	
For example:
```Smalltalk
g := RSGroup new.
g add: (RSBox new size: 10; model: 'hello').
g add: (RSBox new size: 10; model: 'World').
RSHorizontalLineLayout on: g.
g @ RSPopup.
c := RSCanvas new.
c addAll: g.
c
```
"
	self do: [ :e | e @ interaction ].
]
