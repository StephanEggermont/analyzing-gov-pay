Class {
	#name : #FileMetric,
	#superclass : #Object,
	#instVars : [
		'backgroundValue',
		'metricsSize',
		'border'
	],
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #'as yet unclassified' }
FileMetric >> background [
	backgroundValue <1000 ifTrue: [^Color green].
	backgroundValue <2000 ifTrue: [^Color yellow].
	backgroundValue < 3000 ifTrue: [^Color orange].
	^Color red
]

{ #category : #accessing }
FileMetric >> backgroundValue [
	^ backgroundValue
]

{ #category : #accessing }
FileMetric >> backgroundValue: anObject [
	backgroundValue := anObject
]

{ #category : #'as yet unclassified' }
FileMetric >> border [
	border ifNotNil: [^border].
	^ BlBorder paint: Color gray width: 0
]

{ #category : #accessing }
FileMetric >> border1 [
	^ border
]

{ #category : #accessing }
FileMetric >> border: anObject [
	border := anObject
]

{ #category : #'as yet unclassified' }
FileMetric >> metricsSize [
	^metricsSize ifNil: [3@3]
]

{ #category : #accessing }
FileMetric >> metricsSize: anObject [
	metricsSize := anObject
]
