function Indicators_1(app)

% Get the selected indicator from the list box

selectedIndicator = app.RecommendedComparisonsListBox.Value;

Indicator_index1 = strcmp({app.filtered_data_Country1.IndicatorName}, selectedIndicator);
Indicator_index2 = strcmp({app.filtered_data_Country2.IndicatorName}, selectedIndicator);
   
filtered_data_Country1_indicator = app.filtered_data_Country1(Indicator_index1);
filtered_data_Country2_indicator = app.filtered_data_Country2(Indicator_index2);

%% Subset for Country 1
all_field_names_1 = fieldnames(filtered_data_Country1_indicator);

% Extract the field names from 4 to 26
selected_field_names_1 = all_field_names_1(4:26);

% Extract the corresponding field values
subset_struct_Country1 = struct();
for i = 1:numel(selected_field_names_1)
    field_name_1 = selected_field_names_1{i};
    subset_struct_Country1.(field_name_1) = filtered_data_Country1_indicator.(field_name_1);
end

%% Subset for Country 2

all_field_names_2 = fieldnames(filtered_data_Country2_indicator);

% Extract the field names from 4 to 26
selected_field_names_2 = all_field_names_2(4:26);

% Extract the corresponding field values
subset_struct_Country2 = struct();
for i = 1:numel(selected_field_names_2)
    field_name_2 = selected_field_names_2{i};
    subset_struct_Country2.(field_name_2) = filtered_data_Country2_indicator.(field_name_2);
end

%% Plot Country 1

% Get all field names of the struct
field_names_1 = fieldnames(subset_struct_Country1);

% Initialize a cell array to store the data points corresponding to each field
data_points_1 = zeros(1, numel(field_names_1));

% Iterate over each field
for i = 1:numel(field_names_1)
    % Get the name of the current field
    field_name_1 = field_names_1{i};
    
    % Retrieve the data points corresponding to the current field
    data_points_1(i) = subset_struct_Country1.(field_name_1);
end

plot(app.UIAxes1_Double,app.UIAxes1_Double.XTick,data_points_1)
title(app.UIAxes1_Double,filtered_data_Country1_indicator.CountryName)
ylabel(app.UIAxes1_Double,filtered_data_Country1_indicator.IndicatorName)
%% Plot Country 2

% Get all field names of the struct
field_names_2 = fieldnames(subset_struct_Country2);

% Initialize a cell array to store the data points corresponding to each field
data_points_2 = zeros(1, numel(field_names_2));

% Iterate over each field
for i = 1:numel(field_names_2)
    % Get the name of the current field
    field_name_2 = field_names_2{i};
    
    % Retrieve the data points corresponding to the current field
    data_points_2(i) = subset_struct_Country2.(field_name_2);
end

plot(app.UIAxes2_Double,app.UIAxes2_Double.XTick,data_points_2)
title(app.UIAxes2_Double,filtered_data_Country2_indicator.CountryName)
ylabel(app.UIAxes2_Double,filtered_data_Country2_indicator.IndicatorName)
end

