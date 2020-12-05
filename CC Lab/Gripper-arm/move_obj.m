function move_obj
% Use serial data to communicate with Arduino and tell it to move arm in
% manner predetermined by image processing video from camera input.

% *************************************************************************
%    Set up Video input device
% *************************************************************************
    vid = videoinput('winvideo',1,'YUY2_640x480');
    triggerconfig(vid,'manual');
    set(vid,'FramesPerTrigger',1 );
    set(vid,'TriggerRepeat', Inf);
    set(vid,'ReturnedColorSpace','rgb');

    
    
% *************************************************************************
%    Tweak your preferences
% *************************************************************************
    thresh_color = 60;
    thresh_area = 30;
    thresh_grab = 99; 
    
    
% *************************************************************************
%    Set up communication with arduino
% *************************************************************************
    



% *************************************************************************
%    Start execution of program
% *************************************************************************
    
    start(vid); %Starts camera device
    dist = thresh_grab + 1;
    
    
    % Change this loop structure according to your logic. You could keep a
    % for loop here for known number of iterations or end loop if you want
    % a flexible condition
    % while dist > thresh_grab
        trigger(vid);
        pause(.5)
        im = getdata(vid,1);
        figure(1);
        
        imshow(im); % Shows image in a figure

        % Store separate RGB values in matrices
        r = im(:,:,1);
        g = im(:,:,2);
        b = im(:,:,3);

        % The given values are used to make a Green and a Red selection
        % respectively by ignoring other remaining colors.
        % Values may be changed according to environmental factors. If
        % extremely interested in how/why, please ask later.
        justSelection_g = g - r/2 - b/2;
        justSelection_r = r - g/2 - b/2;
        
        % Converting to binary black/white for clarity and decision making.
        black_white_g = justSelection_g > thresh_color;
        black_white_r = justSelection_r > thresh_color;
        
        colormap(gray);
        
        % Removes smaller (noise) areas and concentrates on the major
        % object of choice only. To get good values, keep thresh larger;
        % but be careful.
        object_g_area = bwareaopen(black_white_g, thresh_area);
        object_r_area = bwareaopen(black_white_r, thresh_area);
        
        % Obtain centroid locations and respective areas of major object
        % groups of respective colors from image.
        stats_g = regionprops(object_g_area, {'centroid', 'area'});
        stats_r = regionprops(object_r_area, {'centroid', 'area'});
        
        [~, id_g] = max([stats_g.Area]);
        [~, id_r] = max([stats_r.Area]);
        
        if (id_g > 0) & (id_r > 0) % Please don't change & to && even though MATLAB tells you to
            
            % X and Y coordinates of centres 
            x_g = stats_g(id_g).Centroid(1);
            y_g = stats_g(id_g).Centroid(2);
            x_r = stats_r(id_r).Centroid(1);
            y_r = stats_r(id_r).Centroid(2);

            % Calculate distance between centres
            dist = sqrt((x_r-x_g)^2 + (y_r-y_g)^2);
            
            % Uncomment this if you want to look at your centres
             figure(1);
             hold on
             imshow(im);
             plot([x_g, x_r], [y_g, y_r],'*')
             text(540,400,num2str(dist));
             hold off
        end
        
        % *****************************************************************
        %    Rest of your logic for giving control instructions to Arduino
        %    goes here.
        % *****************************************************************
        
        
        
    % end
    
    stop(imaqfind); % Necessary operation for closing program
    
end