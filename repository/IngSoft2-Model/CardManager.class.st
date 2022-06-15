Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardManager class >> intializeIn: aZathuraGame [ 
	^self new initializeWith: aZathuraGame .
]

{ #category : #actions }
CardManager >> cancel: aCard from: aShip [ 
	(game getCardHandOf: aShip) using: CancellationCard new removingToAll: aCard in: game.
]

{ #category : #initalization }
CardManager >> initializeWith: aZathuraGame [ 
	game:= aZathuraGame.
]

{ #category : #actions }
CardManager >> throws: aCard from: aShip [ 
	(game getCardHandOf: aShip) using: aCard toAllShipsin: game
]
