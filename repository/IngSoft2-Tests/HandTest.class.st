Class {
	#name : #HandTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HandTest >> testHandMustBeInitializedWithTwoCardsOtherwiseThrowsError [

	self
		should: [ Hand with: {  } ]
		raise: Error
		withMessage: 'Hand must be initialized with 2 cards'
]
