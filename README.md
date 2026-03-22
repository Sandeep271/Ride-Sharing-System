# Ride Sharing System

This repository contains a class-based Ride Sharing System implemented in **C++** and **Smalltalk** for the Advanced Programming Languages course at the University of the Cumberlands.

## GitHub Repository

https://github.com/Sandeep271/Ride-Sharing-System

## Repository Structure

- `cpp/RideSharingSystem.cpp` - C++ implementation
- `cpp/cpp_output.txt` - sample output generated from the compiled C++ program
- `smalltalk/RideSharingSystem.st` - Smalltalk implementation
- `smalltalk/smalltalk_expected_output.txt` - sample transcript used to illustrate the Smalltalk demo
- `screenshots/` - screenshots included in the report appendix

## OOP Principles Demonstrated

### Encapsulation
- `Driver` keeps `assignedRides` private and updates it only through `addRide`.
- `Rider` keeps `requestedRides` private and updates it only through `requestRide`.
- Ride data is managed through class methods and instance behavior rather than direct external modification.

### Inheritance
- `StandardRide` and `PremiumRide` inherit from the base `Ride` class.

### Polymorphism
- Both implementations store ride objects of different subclasses in a single collection.
- The system calls `fare()` / `rideDetails()` on the base type, and the correct subclass behavior runs automatically.

## How to Run

### C++
Compile and run with:
```bash
g++ -std=c++17 RideSharingSystem.cpp -o ride_demo
./ride_demo
```

### Smalltalk
Load `RideSharingSystem.st` into a Smalltalk environment such as Pharo or Squeak and execute the workspace demo script included at the bottom of the file.
