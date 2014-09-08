function displayBIFs(bifs)
%DISPLAYBIFS Display BIFs as computed by the computeBIFs
% Used to display BIFs with the original Mathematica implementation
% colormap
%
% Note: should _not_ be used to display filterd images, used the
% binarize option of the filterBIFs functio and display the image using
% imshow(bifs).
%
% bifs = BIFs as computed by the compteBIFs function
%
% Matlab implementation by  Nicolas Jaccard (nicolas.jaccard@gmail.com)

% Load the BIF color map
load('OBIFcolormap.mat','OBIFcolormap')

directionOffsets=[
    0,1;...     % EAST 1
    -1,1;...    % NORTH EAST 2 
    -1,0;...    % NORTH 3
    -1,-1;...   % NORTH WEST 4
    0,-1;...    % WEST 5
    1,-1;...    % SOUTH WEST 6 
    1,0;...     % SOUTH 7
    1,1;...     % SOUTH EAST 8
    ];

directionOffsetsOppositesAll=[
    0,-1;...    % WEST 5
    1,-1;...    % SOUTH WEST 6 
    1,0;...     % SOUTH 7
    1,1;...     % SOUTH EAST 8     
    0,1;...     % EAST 1
    -1,1;...    % NORTH EAST 2 
    -1,0;...    % NORTH 3
    -1,-1;...   % NORTH WEST 4
    ];

directionOffsetsOppositesFour=[
    0,-1;...    % WEST 5
    1,-1;...    % SOUTH WEST 6 
    1,0;...     % SOUTH 7
    1,1;...     % SOUTH EAST 8
    ];

directionOffsetPerpendicular=[
    -1,0;...    % NORTH 3
    -1,-1;...   % NORTH WEST 4
    0,-1;...    % WEST 5
    1,-1;...    % SOUTH WEST 6 
    ];


directionOffsetPerpendicularOpposite=[
    1,0;...     % SOUTH 7
    1,1;...     % SOUTH EAST 8
    0,1;...     % EAST 1
    -1,1;...    % NORTH EAST 2 
    ];


% Display the imge
fh=figure('Units', 'pixels', 'visible', 'on');
imshow(ind2rgb(bifs,colormap(OBIFcolormap)));
hold on
for i = [2,5,6,7]
    if(i==2)
        mask = bifs>1 & bifs <10;
        indices = find(mask);
        [x,y]=ind2sub(size(bifs),indices);
        
        for j=1:numel(x)
            u(j) = directionOffsets(bifs(x(j),y(j))-1,1)/5;
            v(j) = directionOffsets(bifs(x(j),y(j))-1,2)/5;
            u2(j) = directionOffsetsOppositesAll(bifs(x(j),y(j))-1,1)/5;
            v2(j) = directionOffsetsOppositesAll(bifs(x(j),y(j))-1,2)/5;                     
        end
        
        if(numel(x)>0)
            quiver(y,x,u',v',0,'white','ShowArrowHead','off','LineWidth',2);
            quiver(y,x,u2',v2',0,'black','ShowArrowHead','off','LineWidth',2);
        end

    elseif(i==5)
        u = [];
        v = [];
        
        u2=[];
        v2=[];
        
        mask = bifs>11 & bifs <16;
        indices = find(mask);
        [x,y]=ind2sub(size(bifs),indices);
        
        for j=1:numel(x)
            u(j) = directionOffsets(bifs(x(j),y(j))-11,1)/4;
            v(j) = directionOffsets(bifs(x(j),y(j))-11,2)/4;
            u2(j) = directionOffsetsOppositesFour(bifs(x(j),y(j))-11,1)/4;
            v2(j) = directionOffsetsOppositesFour(bifs(x(j),y(j))-11,2)/4;
        end
        
        quiver(y,x,v',u',0,'black','ShowArrowHead','off','LineWidth',2);
        quiver(y,x,v2',u2',0,'black','ShowArrowHead','off','LineWidth',2);
        %unique(bifs(mask))
    elseif(i==6)
        u = [];
        v = [];
        
        u2=[];
        v2=[];
        
        mask = bifs>15 & bifs <20;
        indices = find(mask);
        [x,y]=ind2sub(size(bifs),indices);
        
        for j=1:numel(x)
            u(j) = directionOffsets(bifs(x(j),y(j))-15,1)/4;
            v(j) = directionOffsets(bifs(x(j),y(j))-15,2)/4;
            u2(j) = directionOffsetsOppositesFour(bifs(x(j),y(j))-15,1)/4;
            v2(j) = directionOffsetsOppositesFour(bifs(x(j),y(j))-15,2)/4;
        end
        
        quiver(y,x,v',u',0,'w','ShowArrowHead','off','LineWidth',2);
        quiver(y,x,v2',u2',0,'w','ShowArrowHead','off','LineWidth',2);  
        %unique(bifs(mask))    
    elseif(i==7)
        u = [];
        v = [];
        
        u2=[];
        v2=[];
        
        u3=[];
        v3=[];
        
        mask = bifs>19 & bifs <24;
        indices = find(mask);
        [x,y]=ind2sub(size(bifs),indices);
        
        for j=1:numel(x)
            u(j) = directionOffsets(bifs(x(j),y(j))-19,1)/4;
            v(j) = directionOffsets(bifs(x(j),y(j))-19,2)/4;
            u2(j) = directionOffsetsOppositesFour(bifs(x(j),y(j))-19,1)/4;
            v2(j) = directionOffsetsOppositesFour(bifs(x(j),y(j))-19,2)/4;
            u3(j) = directionOffsetPerpendicular(bifs(x(j),y(j))-19,1)/4;
            v3(j) = directionOffsetPerpendicular(bifs(x(j),y(j))-19,2)/4;
            u4(j) = directionOffsetPerpendicularOpposite(bifs(x(j),y(j))-19,1)/4;
            v4(j) = directionOffsetPerpendicularOpposite(bifs(x(j),y(j))-19,2)/4;
        end
        
        if(numel(x)>0)
            quiver(y,x,v',u',0,'black','ShowArrowHead','off','LineWidth',2);
            quiver(y,x,v2',u2',0,'black','ShowArrowHead','off','LineWidth',2);
            quiver(y,x,v3',u3',0,'w','ShowArrowHead','off','LineWidth',2);
            quiver(y,x,v4',u4',0,'w','ShowArrowHead','off','LineWidth',2); 
        end
    end

end

hold off
