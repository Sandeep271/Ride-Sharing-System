Object subclass: #Ride
	instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
	classVariableNames: ''
	package: 'RideSharingSystem'!

!Ride class methodsFor: 'instance creation'!
rideID: anID pickupLocation: aPickup dropoffLocation: aDropoff distance: aDistance
	^ self new
		initializeRideID: anID pickupLocation: aPickup dropoffLocation: aDropoff distance: aDistance;
		yourself!
!

!Ride methodsFor: 'initialization'!
initializeRideID: anID pickupLocation: aPickup dropoffLocation: aDropoff distance: aDistance
	rideID := anID.
	pickupLocation := aPickup.
	dropoffLocation := aDropoff.
	distance := aDistance!
!

!Ride methodsFor: 'accessing'!
rideID
	^ rideID!

distance
	^ distance!
!

!Ride methodsFor: 'behavior'!
fare
	self subclassResponsibility!

rideType
	self subclassResponsibility!

rideDetails
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Ride ID: '; nextPutAll: rideID;
			nextPutAll: ' | Type: '; nextPutAll: self rideType;
			nextPutAll: ' | From: '; nextPutAll: pickupLocation;
			nextPutAll: ' | To: '; nextPutAll: dropoffLocation;
			nextPutAll: ' | Distance: '; print: distance;
			nextPutAll: ' miles | Fare: $'; print: self fare ]!
!


Ride subclass: #StandardRide
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'RideSharingSystem'!

!StandardRide methodsFor: 'behavior'!
fare
	^ 2.0 + (distance * 1.5)!

rideType
	^ 'Standard'!
!


Ride subclass: #PremiumRide
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'RideSharingSystem'!

!PremiumRide methodsFor: 'behavior'!
fare
	^ 5.0 + (distance * 3.0)!

rideType
	^ 'Premium'!
!


Object subclass: #Driver
	instanceVariableNames: 'driverID name rating assignedRides'
	classVariableNames: ''
	package: 'RideSharingSystem'!

!Driver class methodsFor: 'instance creation'!
driverID: anID name: aName rating: aRating
	^ self new
		initializeDriverID: anID name: aName rating: aRating;
		yourself!
!

!Driver methodsFor: 'initialization'!
initializeDriverID: anID name: aName rating: aRating
	driverID := anID.
	name := aName.
	rating := aRating.
	assignedRides := OrderedCollection new!
!

!Driver methodsFor: 'behavior'!
addRide: aRide
	assignedRides add: aRide!

totalEarnings
	^ assignedRides inject: 0.0 into: [ :sum :each | sum + each fare ]!

getDriverInfo
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Driver ID: '; nextPutAll: driverID;
			nextPutAll: ' | Name: '; nextPutAll: name;
			nextPutAll: ' | Rating: '; print: rating;
			nextPutAll: ' | Completed Rides: '; print: assignedRides size;
			nextPutAll: ' | Total Earnings: $'; print: self totalEarnings ]!
!


Object subclass: #Rider
	instanceVariableNames: 'riderID name requestedRides'
	classVariableNames: ''
	package: 'RideSharingSystem'!

!Rider class methodsFor: 'instance creation'!
riderID: anID name: aName
	^ self new
		initializeRiderID: anID name: aName;
		yourself!
!

!Rider methodsFor: 'initialization'!
initializeRiderID: anID name: aName
	riderID := anID.
	name := aName.
	requestedRides := OrderedCollection new!
!

!Rider methodsFor: 'behavior'!
requestRide: aRide
	requestedRides add: aRide!

getRiderInfo
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Rider ID: '; nextPutAll: riderID;
			nextPutAll: ' | Name: '; nextPutAll: name;
			nextPutAll: ' | Ride Requests: '; print: requestedRides size ]!

viewRides
	Transcript show: self getRiderInfo; cr.
	requestedRides do: [ :each |
		Transcript show: '  - '; show: each rideDetails; cr ]!
!


"Workspace demo script"
| rider driver rides |

Transcript clear.
rides := OrderedCollection new.
rides add: (StandardRide rideID: 'RIDE-101' pickupLocation: 'Campus' dropoffLocation: 'Library' distance: 4.2).
rides add: (PremiumRide rideID: 'RIDE-102' pickupLocation: 'Airport' dropoffLocation: 'Hotel' distance: 12.5).
rides add: (StandardRide rideID: 'RIDE-103' pickupLocation: 'Mall' dropoffLocation: 'Station' distance: 7.0).

rider := Rider riderID: 'RIDER-01' name: 'Alice Johnson'.
driver := Driver driverID: 'DRIVER-88' name: 'Michael Reed' rating: 4.9.

rides do: [ :each |
	rider requestRide: each.
	driver addRide: each ].

Transcript show: '=== Ride Sharing System Demo (Smalltalk) ==='; cr; cr.
Transcript show: 'Polymorphic Ride Summary:'; cr.
rides do: [ :each |
	Transcript show: each rideDetails; cr ].

Transcript cr.
Transcript show: 'Rider History:'; cr.
rider viewRides.

Transcript cr.
Transcript show: 'Driver Summary:'; cr.
Transcript show: driver getDriverInfo; cr.
