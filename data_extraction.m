
%
matlabFolder = ('folder_location') 
%lag en ny mappe der du vil lagre data og kopier sti

%Loop to save important inforamtion for one block of stimuli for each
%patient

for i = 1:6
resultsChemShift(i,:) = results_storage{1,i}.ChemicalShiftsIncOffset;

resultsAmpli(i,:) = results_storage{1,i}.Amplitudes;

resultsPeak(i,:) = results_storage{1,i}.PeakAreas;

resultsSTDAmp(i,:) = results_storage{1,i}.Standard_deviation_of_Amplitudes;   
end

%Iterate over series and save to designated folder.
save('series7','resultsChemShift', 'resultsAmpli', 'resultsPeak','resultsSTDAmp', 'results_storage');
cd(matlabFolder);
