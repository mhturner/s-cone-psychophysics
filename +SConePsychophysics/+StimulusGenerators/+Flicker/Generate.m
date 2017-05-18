% generation is easier for this case, it will just need to return a cycler
% with the approriate offset values (this will be a map that goes from keys
% of offset step position to actual offsets in radians)
function cycler = Generate(stimulusParameters, hardwareParameters)

% figure out constraints on offset step sizes
maxOffsetStepNum = floor(stimulusParameters.maxOffset / stimulusParameters.offsetStepSize);
minOffsetStepNum = ceil(stimulusParameters.minOffset / stimulusParameters.offsetStepSize);

% make an array of offset steps (these will be the containers.Map keys)
offsetSteps = (minOffsetStepNum:maxOffsetStepNum);

% multiply that array by the step size to get an array of offset sizes
offsetSizes = offsetSteps * stimulusParameters.offsetStepSize;

% make these into a lookup for the cycler
offsetLookup = containers.Map(num2cell(offsetSteps), num2cell(offsetSizes));

% make the cylcer to return
cycler = SConePsychophysics.Cyclers.Oscillator(hardwareParameters, stimulusParameters, offsetLookup);
end