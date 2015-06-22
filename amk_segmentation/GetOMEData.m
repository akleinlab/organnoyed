% Date: 13.10.2014 
% Version : 1.0
function OMEData = GetOMEData( filename )
% Get OME Meta Information using BioFormats Library
% The main inconvenience of the bfopen .m function is that it loads all the
% content of an image regardless of its size.
% To access the file reader without loading all the data, use the low?level
% bfGetReader .m function :
reader = bfGetReader(filename);

% You can then access the OME metadata using the getMetadataStore () method :
omeMeta = reader.getMetadataStore();

% THIS IS STILL ISSUE WITHIN BIOFORMTAS OR THE CZI ??>
%       ALWAYS RETURNS ? XYCZT? currently
% THEREFORE THE USER HAS TO SPECIFY THE DIMENSION ORDER 
%OMEData.DimOrder = char(omeMeta.getPixelsDimensionOrder(0).getValue());

% get the actual metadata and store them in a structured array 
% Number of series inside the complete data set
OMEData.SeriesCount = reader.getSeriesCount();
%Dimension Sizes C?T?Z?X?Y
OMEData.SizeC = omeMeta.getPixelsSizeC(0).getValue(); 
OMEData.SizeT = omeMeta.getPixelsSizeT(0).getValue();
OMEData.SizeZ = omeMeta.getPixelsSizeZ(0).getValue(); 
OMEData.SizeX = omeMeta.getPixelsSizeX(0).getValue(); 
OMEData.SizeY = omeMeta.getPixelsSizeY(0).getValue(); 

% Scaling XYZ
OMEData.ScaleX = omeMeta.getPixelsPhysicalSizeX(0).getValue(); % in micron 
OMEData.ScaleY = omeMeta.getPixelsPhysicalSizeY(0).getValue(); % in micron
try
    OMEData.ScaleZ = omeMeta.getPixelsPhysicalSizeZ(0).getValue(); % in micron
catch
    % in case of only a single z?plane set to zero
    OMEData.ScaleZ = 0.0;
end

% close BioFormats Reader
reader.close ()
