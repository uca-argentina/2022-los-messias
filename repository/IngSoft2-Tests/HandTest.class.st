Class {
	#name : #HandTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HandTest >> testHandCanBeInitializedWithTwoRandomCards [

	| cards aHand  |
	cards := CardGenerator initializeNew generate: 2.
	aHand := Hand with: cards.
	self assert: aHand cards size equals: 2
]

{ #category : #tests }
HandTest >> testHandCanThrowACard [

	|  aHand card overload speed |
	overload := OverloadCard new.
	speed := SpeedCard new.
	aHand := Hand with: { 
			         overload.
			         speed }.
	card := aHand throw: overload.
	self assert: card equals: overload
]

{ #category : #tests }
HandTest >> testHandMustBeInitializedWithTwoCardsOtherwiseThrowsError [

	self
		should: [ Hand with: {  } ]
		raise: Error
		withMessage: 'Hand must be initialized with 2 cards'
]

{ #category : #tests }
HandTest >> testHandThrowsErrorIfThrowsCardNotInHand [

	| aHand overload speed accelaration |
	overload := OverloadCard new.
	speed := SpeedCard new.
	accelaration := AccelerationCard new.
	aHand := Hand with: { 
			         overload.
			         speed }.
	self
		should: [ aHand throw: accelaration ]
		raise: Error
		withMessage: 'Card is not in Hand'
]
