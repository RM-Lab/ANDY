function fWriteLine(id,Content,varargin)
% fWriteLine(id,Content,varargin)
% A wrapper function to write <Content> to the file <id>, an optional third
% input indicates the indent (numbers of TABs).

% Copyright 2018 Robotics & Mechatronics Lab, Virginia Tech.
% Author: Jiamin Wang; Revised: 18-Mar-2018 01:23:48

    if(nargin==3)
        indent=varargin{1};
    else
        indent=0;
    end

    for ii=1:numel(Content)
        for jj=1:indent
            fprintf(id,'\t');
        end
        fprintf(id,'%s\n',Content{ii});
    end
    
    fprintf(id,'\n');
end
