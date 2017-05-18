function Main(stimulusParameters, generator, savePath, varargin)
% parse the inputs
ip = inputParser();
ip.addOptional('DebugMode', false, @(x) islogical(x));
isPositiveNumber = @(x) isnumeric(x) && numel(x) == 1 && x > 0;
ip.addOptional('KeyboardCheckInterval', 0.250, isPositiveNumber); % in seconds
ip.addOptional('MaxRunTime', 60, @(x) @(x) isnumeric(x) && numel(x) == 1 && x > 0); % in seconds
ip.parse(varargin{:});

% initialize things for Datapixx (if not debugging), Psychimaging, Window
% as hardware is initialized, add data to hardware properties
hardwareParameters = SConePsychophysics.Utils.HardwareParameters();
SConePsychophysics.Utils.Initialization.Datapixx(hardwareParameters, 'DebugMode', ip.Results.DebugMode);
SConePsychophysics.Utils.Initialization.PsychImaging();
SConePsychophysics.Utils.Initialization.Window(hardwareParameters);

% create the stimuli, stimulus generator will return the appropriate cycler
cycler = generator(stimulusParameters, hardwareParameters);

% run the experiment
results = SConePsychophysics.RunExperiment(cycler, ip.Results.KeyboardCheckInterval, ip.Results.MaxRunTime);

% save the parameters and results
hardwareParameters.Save(fullfile(savePath, 'hardwareParametesr.txt'));
stimulusParameters.Save(fullfile(savePath, 'stimulusParameters.txt'));
results.Save(fullfile(savePath, 'results.txt'));
end