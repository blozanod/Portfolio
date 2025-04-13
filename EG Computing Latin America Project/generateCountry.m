function [answer,selected] = generateCountry(app)

countries = app.countries;

selected = randi(20-app.round+1);

currentFile = mfilename('fullpath');
[scriptPath, ~, ~] = fileparts(currentFile);

flagPath = fullfile(scriptPath, 'Images/CountryFlags', [countries{selected}, '.png']);
mapPath = fullfile(scriptPath, 'Images/CountryMaps', [countries{selected}, '.png']);

app.FlagImage.ImageSource = flagPath;
app.MapImage.ImageSource = mapPath;

answer = app.countries(selected);
app.countries(selected) = [];