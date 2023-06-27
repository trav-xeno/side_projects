#ifndef AIRCRAFT_H_
#define AIRCRAFT_H_

#include <vector>
#include <string>

class Aircraft {
    public: 
        //constructor
        Aircraft(string aircraft_id, int available_seats, vector<double>fairs, vector<int>num_of_class_seats);

        //destructor
        ~Aircraft();

        //getters
        int get_available_seats();
        vector<double> get_fairs();
        double get_first_class_fair();
        double get_business_class_fair();
        double get_economy_class_fair();
        int get_first_class_seats();
        int get_business_class_seats();
        int get_economy_class_seats();
        bool needs_repair();
        bool is_available();
        bool in_flight();
        
        string get_aircraft_id();

        //setters
        void set_available_seats(int purchased_seats);
        //might change these too bools to these below
        void set_first_class_seats(int purchased_seats);
        void set_business_class_seats(int purchased_seats);
        void set_economy_class_seats(int purchased_seats);
        void set_needs_repair(bool needs_repair);
        void set_is_available(bool is_available);
        void set_is_repairing(bool is_repairing);
        void set_in_flight(bool in_flight);


    private:
        int  num_available_seats;
        bool needs_repair; //after 100 flights
        bool is_available; //after repair or flight
        bool is_repairing; //in repair state plane is not available
        bool in_flight; // plane is in flight
        //fair split into 3 classes
        vector<double>fairs;
        vector<int>num_of_class_seats; 
        int total_seats;
        string aircraft_id;
        int num_before_repair;
        bool is_seat_available();

}
#endif