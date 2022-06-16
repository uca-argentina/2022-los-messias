Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyEffectTo: ship in: zathuraGame [

	| aCard  |
	aCard := zathuraGame lastCardThrewOnTable card.
	(aCard isMemberOf: CancellationCard new class)
		ifFalse: [ aCard applyEffectTo: ship in: zathuraGame ]
		ifTrue: [ 
			aCard
				applyEffectTo: ship
				removing: zathuraGame lastCardCancelled
				in: zathuraGame ]
]

{ #category : #action }
RedoCard >> applyEffectToAllShipsIn: aZathuraGame [

	| aCard |
	aCard := (aZathuraGame lastCardThrewOnTable) card.
	aCard applyEffectToAllShipsIn: aZathuraGame
]
