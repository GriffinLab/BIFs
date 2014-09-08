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

i = 6;
atan2d(directionOffsets(i,1),directionOffsets(i,2))