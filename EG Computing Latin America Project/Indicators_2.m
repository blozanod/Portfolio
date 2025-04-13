function Indicators_2(app)

% Get the selected indicator from the list box

selectedCorrelation = app.RecommendedCorrelationsListBox.Value;
switch selectedCorrelation
    case "Population growth and unemployment"
        correlation1 = "Population growth (annual %)";
        correlation2 = "Unemployment (% of labor force)";
    case "Foreign direct investment and gov. debt"
        correlation1 = "Foreign direct investment (% of GDP)";
        correlation2 = "Government debt (% of GDP)";
    case "Access to electricity and renewable production"
        correlation1 = "Electricity access (% of population)";
        correlation2 = "Renewable electricty (% of total)";
    case "Inflation and corruption"
        correlation1 = "Inflation (annual %)";
        correlation2 = "Control of Corruption (-2.5 to 2.5)";
    case "Forest area and CO2 emissions"
        correlation1 = "Forest area (% of land area)";
        correlation2 = "CO2 emissions (metric tons pp)";
    case "Choose your own"
        correlation1 = app.Indicator1DropDown.Value;
        correlation2 = app.Indicator2DropDown.Value;
end


Indicator_index_1 = strcmp({app.filtered_data_Country.IndicatorName}, correlation1);
Indicator_index_2 = strcmp({app.filtered_data_Country.IndicatorName}, correlation2);
   
filtered_data_correlation_indicator1 = app.filtered_data_Country(Indicator_index_1);
filtered_data_correlation_indicator2 = app.filtered_data_Country(Indicator_index_2);

%% Subset for Indicator 1 1
all_field_names_indicator_1 = fieldnames(filtered_data_correlation_indicator1);

% Extract the field names from 4 to 26
selected_field_names_indicator_1 = all_field_names_indicator_1(4:26);

% Extract the corresponding field values
subset_struct_indicator_1 = struct();
for i = 1:numel(selected_field_names_indicator_1)
    field_name_indicator_1 = selected_field_names_indicator_1{i};
    disp(field_name_indicator_1);
    subset_struct_indicator_1.(field_name_indicator_1) = filtered_data_correlation_indicator1.(field_name_indicator_1);
    disp(subset_struct_indicator_1);
end

%% Subset for Indicator 2

all_field_names_indicator_2 = fieldnames(filtered_data_correlation_indicator2);

% Extract the field names from 4 to 26
selected_field_names_indicator_2 = all_field_names_indicator_2(4:26);

% Extract the corresponding field values
subset_struct_indicator_2 = struct();
for i = 1:numel(selected_field_names_indicator_2)
    field_name_indicator_2 = selected_field_names_indicator_2{i};
    subset_struct_indicator_2.(field_name_indicator_2) = filtered_data_correlation_indicator2.(field_name_indicator_2);
end

%% Plot Indicator 1

% Get all field names of the struct
field_names_indicator_1 = fieldnames(subset_struct_indicator_1);

% Initialize a cell array to store the data points corresponding to each field
data_points_indicator_1 = zeros(1, numel(field_names_indicator_1));

% Iterate over each field
for i = 1:numel(field_names_indicator_1)
    % Get the name of the current field
    field_name_indicator_1 = field_names_indicator_1{i};
    
    % Retrieve the data points corresponding to the current field
    data_points_indicator_1(i) = subset_struct_indicator_1.(field_name_indicator_1);
end

plot(app.UIAxes1_Single,app.UIAxes1_Single.XTick,data_points_indicator_1)
title(app.UIAxes1_Single,filtered_data_correlation_indicator1.IndicatorName)
%% Plot Indicator 2

% Get all field names of the struct
field_names_indicator_2 = fieldnames(subset_struct_indicator_1);

% Initialize a cell array to store the data points corresponding to each field
data_points_indicator_2 = zeros(1, numel(field_names_indicator_2));

% Iterate over each field
for i = 1:numel(field_names_indicator_2)
    % Get the name of the current field
    field_name_indicator_2 = field_names_indicator_2{i};
    
    % Retrieve the data points corresponding to the current field
    data_points_indicator_2(i) = subset_struct_indicator_2.(field_name_indicator_2);
end

plot(app.UIAxes2_Single,app.UIAxes2_Single.XTick,data_points_indicator_2)
title(app.UIAxes2_Single,filtered_data_correlation_indicator2.IndicatorName)
end

