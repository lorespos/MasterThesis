%% 22/11/2024 Pierfrancesco Ambrosi and Lorenz Esposito
%% OXSA Main

clearvars
close all
    
% zero-filling slightly improves spectral resolution and should not impact
% OXSA considerably as it fits in time-domain
zerofill = 8192;

% folder where results will be
tardir = 'OXSA_3D/';
mkdir(tardir)
mkdir(tardir + "/FIGURE")
folder = '3D/';

% load the customized priorKnowledge (I generally leave them in the
% AMARES/main/priorKnowledge folder)

pk = AMARES.priorKnowledge.PK_3T_Brain_edit_GE_Lorenz;
%pk = AMARES.priorKnowledge.PK_3T_Brain_edit_GE_norm;
%pk = AMARES.priorKnowledge.PK_3T_Brain_edit_Siemens_MAIN;

metamus1 = zeros(1024, 6);

% load data
data_s4 = load('file_location')


%metamus1(:,1:6) = data_s4.spec';



%Motion correctoin 
%moco = SpectRegFiltered(metamus1);
% get the FID, you can take it directly, but with data from FIDALL you generally 
% need to add/subtract a 90° phase; I did it this way to be sure I was
% adding correctly

%fids=moco;
fids = fft(fftshift(data_s4.spec')); %moco
fids = real(fids) - 1j*imag(fids);

%moco = SpectRegFiltered(fids);

% get parameters from the data file
wLarmor = data_s4.par.f0*1e-6;
bw = data_s4.par.bw;
deltat = 1/bw;
ppm = linspace(-bw/2,bw/2, zerofill)'/wLarmor;

% initialize the spec struct to be given to OXSA
spec = struct();
spec.signals = cell(1);
spec.dwellTime = 1/bw;
spec.ppmAxis = ppm;
spec.timeAxis = linspace(0,size(fids,1)*deltat,zerofill)';
spec.imagingFrequency = wLarmor;
spec.samples = zerofill;
spec.beginTime = data_s4.par.repetition_time*1e-3; 
spec.expOffset = 0;

% Initialize an array to store results (for every iteration)
results_storage = {};



for s = 1:size(fids,2)
    
    % Step 1: Zero-fill the FID
    fid(:,s) = [fids(:,s); zeros(zerofill - length(fids),1)]; % apply zero-filling to the FID  
    
    % Max amplitude FID normalization
    % Denne vil vel bare normalisere FID signalene
    max_amp = max(abs(fid(:,s))); 
    fid(:,s) = fid(:,s) / max_amp;

    spec.signals{1} = fid(:,s);
    
    % Main AMARES calculation
    Results = AMARES.amares(spec, 1 ,1, ...
        spec.beginTime, spec.expOffset, pk, 1, 'searchlimit',4,'quite',1,'xlims',[-20 10]);
    
    % Store the results in the results_storage array for every iteration
    results_storage{end+1} = Results;
    
    % Save the figure and results for every iteration
    saveas(gcf, strcat(tardir, 'FIGURE/', num2str(s), '.png'), 'png');
    saveas(gcf, strcat(tardir, 'FIGURE/', num2str(s), '.fig'), 'fig');
    save(strcat(tardir, 'Result', num2str(s)), 'Results', '-mat');
end

% Optionally, save the results_storage array to a MAT file
save(strcat(tardir, 'AllResults.mat'), 'results_storage', '-mat');
