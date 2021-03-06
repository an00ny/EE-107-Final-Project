function [] = RyanEyeDiagram(fs, T, diagram_title, signal, is_matched)
%RyanEyeDiagram Abstracts Eye diagram function
%
%   Inputs:
%       fs = sampling frequency
%       T = bit duration in time
%       diagram_title = title of eye diagram
%       signal = vector representing signal
%       is_matched = true if matched filter output
%   Outputs:
%       None

%used to shift eye diagram to middle of plot
if is_matched
    offset = 0;
else
    offset = fs/2;
end

%plot and combine eye diagrams of positive and negative signal to ensure 
%we have complete and symmetric picture, code to combine figures is from:
%https://www.mathworks.com/matlabcentral/answers/127341-is-there-any-way-
%to-merge-several-figures-already-drawn-into-one-fugure
fhandles(1) = eyediagram(signal, fs, T, offset);
fhandles(2) = eyediagram(-1*signal, fs, T, offset);

handleLine = findobj(fhandles,'type','line');
figure;
title_line_1 = sprintf('Eye Diagram for %s', char(diagram_title(1)));
title({title_line_1; char(diagram_title(2))});
xlabel('Time');
ylabel('Amplitude');
hold on ;
for j = 1 : length(handleLine)
    plot(get(handleLine(j),'XData'), get(handleLine(j),'YData'), 'b') ;
end
hold off;

%close all individual eye diagrams
for k = 1:length(fhandles)
    close(fhandles(k));
end

end

