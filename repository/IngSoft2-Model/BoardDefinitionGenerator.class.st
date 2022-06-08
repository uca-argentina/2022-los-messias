"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
!
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	lockerGenerator:		<Object>


    Implementation Points
"
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
