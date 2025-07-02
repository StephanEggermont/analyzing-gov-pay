Class {
	#name : #RepoModel,
	#superclass : #Object,
	#instVars : [
		'url',
		'rootDirectory',
		'files',
		'gitUrl',
		'repository',
		'visualization',
		'workingDirectory'
	],
	#classVars : [
		'default'
	],
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
RepoModel class >> default [
	^ default ifNil: [default := self new]
]

{ #category : #accessing }
RepoModel class >> default: anObject [
	default := anObject
]

{ #category : #'as yet unclassified' }
RepoModel class >> reset [
	default := nil
]

{ #category : #'as yet unclassified' }
RepoModel >> addFilesMatching: aString [
	files := repository location allChildrenMatching:  aString
]

{ #category : #'as yet unclassified' }
RepoModel >> clone [
	| notDone |
	workingDirectory := FileLocator temp resolve / 'example-clone'.
	workingDirectory exists ifTrue: [ workingDirectory deleteAll ].
	gitUrl := PureGitUrl with: url.
	notDone := true.
	(gitUrl cloneWithOwnerPrefixIn: workingDirectory)
		then: [ :result | 
			repository := result repository.
			rootDirectory := repository location .
			notDone := false.].
	[0.1 seconds wait] doWhileTrue: [notDone].
]

{ #category : #accessing }
RepoModel >> files [
	^ files
]

{ #category : #accessing }
RepoModel >> files: anObject [
	files := anObject
]

{ #category : #'as yet unclassified' }
RepoModel >> initialize [
	files := OrderedCollection new
]

{ #category : #accessing }
RepoModel >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
RepoModel >> rootDirectory: anObject [
	rootDirectory := anObject
]

{ #category : #accessing }
RepoModel >> url [
	^ url
]

{ #category : #accessing }
RepoModel >> url: anObject [
	url := anObject
]

{ #category : #accessing }
RepoModel >> visualize [
	visualization := Visualisation javaFiles: files.
	^visualization
	
]
