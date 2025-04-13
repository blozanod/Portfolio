%% Load Data for Question 3
% Reads data from xlsx spreadsheet into table array
%
% Authors: Bernardo Lozano, Diego Manllo
% Group: S12, G04


    function [filtered_data_Country] =  CountryFilter_2(app)

    data = readtable("Latin American Country Data (Filtered).xlsx");
    disp(data)
    data_struct = table2struct(data);

    selectedCountry = app.selectedCountries(1); % Change later for app input

    % Assign country names based on selected variables
    countries = {'Mexico', 'Honduras', 'Nicaragua', 'Panama', 'Brazil', 'Venezuela', 'Colombia', 'Ecuador', 'Argentina'};

    %% Images 

currentFile = mfilename('fullpath');
[scriptPath, ~, ~] = fileparts(currentFile);

flagPath = fullfile(scriptPath, 'Images/CountryFlags', [countries{app.selectedCountries(1)}, '.png']);
app.Image_Single.ImageSource = flagPath;

    %% Check if selectedCountry1 and selectedCountry2 are within the valid range
    if selectedCountry >= 1 && selectedCountry <= 9 
        country = countries{selectedCountry};
    end

    % Filter the data_struct to contain only the rows corresponding to the selected countries
    country_indices = strcmp({data_struct.CountryName}, country);
   

    filtered_data_Country = data_struct(country_indices);
    end


