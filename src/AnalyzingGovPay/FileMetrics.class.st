Class {
	#name : #FileMetrics,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
FileMetrics class >> on: aFileReference [
	^self new
		file: aFileReference;
		yourself
]

{ #category : #accessing }
FileMetrics >> file [
	^ file
]

{ #category : #accessing }
FileMetrics >> file: aFileReference [ 
	file := aFileReference
]
