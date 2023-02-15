Extension { #name : #OrderedCollection }

{ #category : #'*IngSoft2-Model' }
OrderedCollection >> asSequence [
	| sequence |
	sequence := Sequence newEmpty.
	self do: [ :element | sequence add: element ].
	^sequence
]
