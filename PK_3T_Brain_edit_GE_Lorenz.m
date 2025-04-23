function outStruct = PK_3T_Brain_edit_GE()
%% .M file to assemble the bounds, priorKnowledge and initialValues structs for the matlab implementation of AMARES

%Each of B, PK and IV is a 1xN struct, where N is the number of peaks. Note
%multiplets are counted as one peak. The fields are as follows: bounds
%initialValues          priorKnowledge

%peakName         peakName               peakName chemShift
%chemShift              multiplet linewidth        linewidth
%chemShiftDelta amplitude        amplitude              amplitudeRatio
%phase            phase                  G_linewidth chemShiftDelta
%G_amplitude amplitudeRatio                          G_phase
%                                        G_chemShiftDelta refPeak

%% Bounds
fields.Bounds = {
'peakName',                          'chemShift',     'linewidth',   'amplitude',    'phase',  'chemShiftDelta',   'amplitudeRatio'};
values.boundsCellArray = {...
{'ATP_BETA1','ATP_BETA2','ATP_BETA3'},   [-19,-15],       [0,inf],        [0,inf],     [0,360],      [],                [];
{'ATP_ALPHA1','ATP_ALPHA2'},             [-8.1,-7.4],       [0,inf],        [0,inf],     [0,360],      [],                []; 
{'ATP_GAMMA1','ATP_GAMMA2'},             [-3.2,-2.4],    [0,50],        [0,inf],     [0,360],      [],                [];
'PCR',                                   [-1,1],       [0,30],        [0,inf],     [0,360],      [],                [];
'GPC',                                   [2,10],       [0,80],        [0,inf],     [0,360],      [],                []; 
'GPE',                                   [2.5,3.5],       [0,80],        [0,inf],     [0,360],      [],                [];
'Pi',                                    [4.5,5],       [0,40],        [0,inf],     [0,360],      [],                [];
'Pc',                                    [5.5,6.15],       [0,40],        [0,inf],     [0,360],      [],                [];
'PE',                                    [5.5,7.9],       [0,40],        [0,inf],     [0,360],      [],                [];
%{'NADP1','NADP2','NADP3','NADP4'},      [-8.45,-8.3],  [0, inf],       [0,inf],     [0,360],      [],                [];
'MP',                                    [1.9,2.3],       [0,inf],        [0,inf],     [0,360],      [],                [];
};%8.312 is ppm of NAD+

% %% initialValues fields.IV = { 'peakName',
% 'chemShift',     'linewidth',   'amplitude',    'phase', 'addlinewidth'};
% values.IVCellArray = {... {'ATP_BETA1','ATP_BETA2','ATP_BETA3'},
% -16.3,           50,         1,               0,        30;
% {'NADP1','NADP2','NADP3','NADP4'},               -8.312,            8.5,
% 1,               0,    10; 'NAD',
% -8.0,            8.5,           0.25,               0,    10;
% {'ATP_ALPHA1','ATP_ALPHA2'},                     -7.5,           8.5,
% 2,               0,        10; {'ATP_GAMMA1','ATP_GAMMA2'},
% -2.5,           20,         1,               0,        30; 'PCR',
% 0.01,           5,          3,               0,       30; 'PDE',
% 3.0,           5,          1,               0,        30; 'Pi',
% 4.6,            5,          1,               0,       30; 'PME',
% 6.9,           5,         1,               0,        30; };
% 
% initialValues
fields.IV = {
'peakName',                                 'chemShift',     'linewidth',   'amplitude',    'phase', 'addlinewidth'};
values.IVCellArray = {...
{'ATP_BETA1','ATP_BETA2','ATP_BETA3'},          -16.7,           30,         0.3,              0,           1;
{'ATP_ALPHA1','ATP_ALPHA2'},                     -7.8,           20,        0.0739,                 0,           1;
{'ATP_GAMMA1','ATP_GAMMA2'},                     -2.564,           30,         0.0808,               0,           1;
%'PCR',                                            -0.2728,
%23.13,          0.1383,                0,           1;
'PCR',                                              0.001,          15,             1,                  0,              10;
'GPC',                                            3.19,           20,         0.0928,               0,           1;
'GPE',                                            2.727,           20,         0.1472,               0,           1;
'Pi',                                             4.7,           10,         0.1470,                 0,           1;
'Pc',                                             5.908,           20.0,         0.05,                0,           1; 
'PE',                                              6.5081,          21.55,         0.0886,                0,           1;
%{'NADP1','NADP2','NADP3','NADP4'},                                              -8.35,          30,             0.1,                      0,          10;
'MP',                                              2.2,           15,         1,               0,           30;
};

%% 
fields.PK = {
'peakName',                             'multiplet',     'chemShiftDelta',   'amplitudeRatio',    'G_linewidth',   'G_amplitude',    'G_phase'  ,'RelPhase'   'G_chemShiftDelta',    'refPeak'};
values.PKCellArray = {...
{'ATP_BETA1','ATP_BETA2','ATP_BETA3'},      [1,0,1],         15 / 51.6995,         0.5,                 [],            [],               1,          [] ,             [],                            0;
{'ATP_ALPHA1','ATP_ALPHA2'},                 [0,0],          16 / 51.6995,         [],                  [],            [],               1,          [] ,             [],                          0;
{'ATP_GAMMA1','ATP_GAMMA2'},                 [0,0],          15 / 51.6995,         [],                  [],            [],               1,          [] ,             [],                            0;
'PCR',                                        [],             [],                 [],                 [],            [],               1,          [] ,             [],                             1;
'GPC',                                        [],             [],                [],                  [],            [],               1,              [] ,      [],                    0;   
'GPE',                                        [],             [],                [],                  [],            [],               1,             [] ,          [],                    0;    
'Pi',                                         [],             [],               [],                  [],            [],               1,             [] ,      [],                    0;
'Pc',                                         [],             [],                [],                  [],            [],               1,            [] ,         [],                    0;
'PE',                                         [],             [],                [],                  [],            [],               1,            [] ,         [],                    0;
%{'NADP1','NADP2','NADP3','NADP4'},                               [1,0,0,1],              [20 / 51.6995],             [0.0134],                     2,             [],              1,             [],          [],                    0;
'MP',                                         [],             [],              [],                  [],            [],               1,              [] ,         [],                    0;     

};



%% Pass to the function which assembles the constraints into structs and saves them
outStruct = AMARES.priorKnowledge.preparePriorKnowledge(fields,values);
outStruct.svnVersion = '$Rev: 8888 $';
outStruct.svnHeader = '$Header: PK_3T_Brain_edit_GE.m 8888 $';