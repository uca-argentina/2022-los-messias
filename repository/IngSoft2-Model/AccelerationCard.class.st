Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AccelerationCard class >> thrownBy: sourceShip [ 
	
	^ self new initializeThrownBy: sourceShip
]

{ #category : #accesing }
AccelerationCard >> changeOfRoll [
	^1
]

{ #category : #action }
AccelerationCard >> effectOn: aCardManager [

	^ PermanentCard new
		  returnsEffectOf: self thrownBy: sourceShip
		  on: aCardManager
]

{ #category : #initialization }
AccelerationCard >> initializeThrownBy: aSourceShip [
	
	sourceShip := aSourceShip
]
