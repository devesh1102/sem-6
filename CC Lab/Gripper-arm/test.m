function move_obj
% Use serial data to communicate with Arduino and tell it to move arm in
% manner predetermined by image processing video from camera input.

% *************************************************************************
%    Set up Video input device
% *************************************************************************

    
% *************************************************************************
%    Set up communication with arduino
% *************************************************************************
    
    arduino = serial('COM14', 'Baudrate' , 9600);
    fopen(arduino);
    fprintf(arduino,'A');
    fclose(arduino);

    
end