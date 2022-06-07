Class {
	#name : #BoardDefinitionGenerator,
	#superclass : #Object,
	#instVars : [
		'lockerGenerator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardDefinitionGenerator class >> with: lockerGenerator [

	^ self new initializeWith: lockerGenerator
]

{ #category : #creation }
BoardDefinitionGenerator >> generatesWith: lockers and: parsecs played: laps [
	
	^ BoardDefinition with: (lockerGenerator generateRandomObjectsWith: lockers) and: parsecs played: laps
]

{ #category : #creation }
BoardDefinitionGenerator >> initializeWith: aLockerGenerator [

lockerGenerator := aLockerGenerator
]
