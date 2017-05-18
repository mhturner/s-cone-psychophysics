classdef KeyboardInputTimer < handle
    properties (Access = private)
        startTime
        minimumCheckInterval
    end
    
    methods
        function obj = Timer(minimumCheckInterval)
            obj.minimiumCheckInterval = minimumCheckInterval;
            obj.startTime = tic;
        end
        
        function tf = ToCheckKeyboard(obj)
            tf = (toc - obj.startTime) >= obj.minimumCheckInterval;
        end
        
        function Reset(obj)
           obj.startTime = tic; 
        end
    end
end