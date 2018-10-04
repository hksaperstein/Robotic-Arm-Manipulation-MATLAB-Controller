function [BW,maskedRGBImage] = createGreenMask(RGB)
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder App. The colorspace and
%  minimum/maximum values for each channel of the colorspace were set in the
%  App and result in a binary mask BW and a composite image maskedRGBImage,
%  which shows the original RGB image values under the mask BW.

% Auto-generated by colorThresholder app on 04-Oct-2018
%------------------------------------------------------


% Convert RGB image to chosen color space
I = rgb2hsv(RGB);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.267;
channel1Max = 0.483;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.287;
channel2Max = 0.691;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.245;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

row = [1/9 1/9 1/9];
BW = imfilter(BW, [row; row; row]);

% Fill holes
BW = imfill(BW, 'holes');

% Dilate mask with disk
radius = 3;
decomposition = 6;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
