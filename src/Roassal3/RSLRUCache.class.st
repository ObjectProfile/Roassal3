"
used because LRUCache some times throws an error
"
Class {
	#name : #RSLRUCache,
	#superclass : #LRUCache,
	#category : #'Roassal3-Rendering'
}

{ #category : #private }
RSLRUCache >> evict [
	| link value |
	link := lruList removeFirst.
	value := link value.
	weight remove: value value.
	keyIndex removeKey: value key ifAbsent: [].
]
