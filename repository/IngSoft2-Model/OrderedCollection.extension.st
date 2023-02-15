Extension { #name : #OrderedCollection }

{ #category : #'*IngSoft2-Model' }
OrderedCollection >> asSequence [
	| sequence |
	sequence := Sequence new.
	self do: [ :element | sequence add: element ].
	^sequence
]
