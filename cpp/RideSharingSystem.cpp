#include <iomanip>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

class Ride {
protected:
    std::string rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance;

public:
    Ride(const std::string& rideID,
         const std::string& pickupLocation,
         const std::string& dropoffLocation,
         double distance)
        : rideID(rideID),
          pickupLocation(pickupLocation),
          dropoffLocation(dropoffLocation),
          distance(distance) {}

    virtual ~Ride() = default;

    std::string getRideID() const { return rideID; }
    double getDistance() const { return distance; }

    virtual double fare() const = 0;
    virtual std::string getRideType() const = 0;

    virtual std::string rideDetails() const {
        std::ostringstream out;
        out << "Ride ID: " << rideID
            << " | Type: " << getRideType()
            << " | From: " << pickupLocation
            << " | To: " << dropoffLocation
            << " | Distance: " << std::fixed << std::setprecision(1) << distance << " miles"
            << " | Fare: $" << std::fixed << std::setprecision(2) << fare();
        return out.str();
    }
};

class StandardRide : public Ride {
public:
    StandardRide(const std::string& rideID,
                 const std::string& pickupLocation,
                 const std::string& dropoffLocation,
                 double distance)
        : Ride(rideID, pickupLocation, dropoffLocation, distance) {}

    double fare() const override {
        const double baseFare = 2.00;
        const double perMileRate = 1.50;
        return baseFare + (distance * perMileRate);
    }

    std::string getRideType() const override {
        return "Standard";
    }
};

class PremiumRide : public Ride {
public:
    PremiumRide(const std::string& rideID,
                const std::string& pickupLocation,
                const std::string& dropoffLocation,
                double distance)
        : Ride(rideID, pickupLocation, dropoffLocation, distance) {}

    double fare() const override {
        const double baseFare = 5.00;
        const double perMileRate = 3.00;
        return baseFare + (distance * perMileRate);
    }

    std::string getRideType() const override {
        return "Premium";
    }
};

class Driver {
private:
    std::string driverID;
    std::string name;
    double rating;
    std::vector<std::shared_ptr<Ride>> assignedRides;

public:
    Driver(const std::string& driverID, const std::string& name, double rating)
        : driverID(driverID), name(name), rating(rating) {}

    void addRide(const std::shared_ptr<Ride>& ride) {
        assignedRides.push_back(ride);
    }

    double totalEarnings() const {
        double total = 0.0;
        for (const auto& ride : assignedRides) {
            total += ride->fare();
        }
        return total;
    }

    std::string getDriverInfo() const {
        std::ostringstream out;
        out << "Driver ID: " << driverID
            << " | Name: " << name
            << " | Rating: " << std::fixed << std::setprecision(1) << rating
            << " | Completed Rides: " << assignedRides.size()
            << " | Total Earnings: $" << std::fixed << std::setprecision(2) << totalEarnings();
        return out.str();
    }
};

class Rider {
private:
    std::string riderID;
    std::string name;
    std::vector<std::shared_ptr<Ride>> requestedRides;

public:
    Rider(const std::string& riderID, const std::string& name)
        : riderID(riderID), name(name) {}

    void requestRide(const std::shared_ptr<Ride>& ride) {
        requestedRides.push_back(ride);
    }

    std::string getRiderInfo() const {
        std::ostringstream out;
        out << "Rider ID: " << riderID
            << " | Name: " << name
            << " | Ride Requests: " << requestedRides.size();
        return out.str();
    }

    void viewRides() const {
        std::cout << getRiderInfo() << '\n';
        for (const auto& ride : requestedRides) {
            std::cout << "  - " << ride->rideDetails() << '\n';
        }
    }
};

int main() {
    std::vector<std::shared_ptr<Ride>> rides;
    rides.push_back(std::make_shared<StandardRide>("RIDE-101", "Campus", "Library", 4.2));
    rides.push_back(std::make_shared<PremiumRide>("RIDE-102", "Airport", "Hotel", 12.5));
    rides.push_back(std::make_shared<StandardRide>("RIDE-103", "Mall", "Station", 7.0));

    Rider rider("RIDER-01", "Alice Johnson");
    Driver driver("DRIVER-88", "Michael Reed", 4.9);

    for (const auto& ride : rides) {
        rider.requestRide(ride);
        driver.addRide(ride);
    }

    std::cout << "=== Ride Sharing System Demo (C++) ===\n\n";
    std::cout << "Polymorphic Ride Summary:\n";
    for (const auto& ride : rides) {
        std::cout << ride->rideDetails() << '\n';
    }

    std::cout << "\nRider History:\n";
    rider.viewRides();

    std::cout << "\nDriver Summary:\n";
    std::cout << driver.getDriverInfo() << '\n';

    return 0;
}
