#ifndef COUNTY_CLASS_H
#define COUNTY_CLASS_H

#include <iostream>
#include <fstream>
#include <vector>
#include <string>

class County
{
private:
    long unsigned int id;
    std::string name;
    double population;
    std::vector<std::vector<double>> color; // [R, G, B] for Residential, Commercial, Industrial, Total
    std::vector<double> coordinates; // Longitude, Latitude
    std::vector<double> consumption; // Residential, Commercial, Industrial, Total
    std::vector<double> per_capita; // Residential, Commercial, Industrial, Total

public:
    // Constructor
    County(const double& longitude, const double& latitude, const double& con_res, const double& con_com, const double& con_ind, const double& cus_res, const double& cus_com, const double& cus_ind);

    // Destructor
    ~County(){}

    // Get Functions
    std::string get_name()const;
    std::vector<double> get_color()const;
    std::vector<double> get_coordinates()const;
    std::vector<double> get_consumption()const;
    double get_population()const;
    std::vector<double> get_per_capita()const;

    // Print Data
    void print_county(int type);
};

#endif