Extension { #name : #OrderedCollection }

{ #category : #'*IngSoft2-Model' }
OrderedCollection >> asSequence [

	| sequence |
	sequence := Sequence with: self.
	^ sequence
]
