%% Load Data for Question 2
% Reads data from xlsx spreadsheet into table array
%
% Authors: Bernardo Lozano, Diego Manllo
% Group: S12, G04


    function [filtered_data_Country1,filtered_data_Country2] =  CountryFilter_1(app)

    data = readtable("Latin American Country Data (Filtered).xlsx");
    disp(data)
    data_struct = table2struct(data);

    selectedCountry1 = app.selectedCountries(1); % Change later for app input
    selectedCountry2 = app.selectedCountries(2); % Change later for app input

    % Assign country names based on selected variables
    countries = {'Mexico', 'Honduras', 'Nicaragua', 'Panama', 'Brazil', 'Venezuela', 'Colombia', 'Ecuador', 'Argentina'};

    %% Images 

currentFile = mfilename('fullpath');
[scriptPath, ~, ~] = fileparts(currentFile);

flagPath = fullfile(scriptPath, 'Images/CountryFlags', [countries{app.selectedCountries(1)}, '.png']);
app.Image1_Double.ImageSource = flagPath;

flagPath = fullfile(scriptPath, 'Images/CountryFlags', [countries{app.selectedCountries(2)}, '.png']);
app.Image2_Double.ImageSource = flagPath;

    %% Check if selectedCountry1 and selectedCountry2 are within the valid range
    if selectedCountry1 >= 1 && selectedCountry1 <= 9 && selectedCountry2 >= 1 && selectedCountry2 <= 9
        country1 = countries{selectedCountry1};
        country2 = countries{selectedCountry2};
    end

    % Filter the data_struct to contain only the rows corresponding to the selected countries
    country1_indices = strcmp({data_struct.CountryName}, country1);
    country2_indices = strcmp({data_struct.CountryName}, country2);

    filtered_data_Country1 = data_struct(country1_indices);
    filtered_data_Country2 = data_struct(country2_indices);
    end


