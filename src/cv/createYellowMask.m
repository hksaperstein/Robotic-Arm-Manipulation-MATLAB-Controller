function [BW,maskedRGBImage] = create(image)
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder App. The colorspace and
%  minimum/maximum values for each channel of the colorspace were set in the
%  App and result in a binary mask BW and a composite image maskedRGBImage,
%  which shows the original RGB image values under the mask BW.

% Auto-generated by colorThresholder app on 03-Oct-2018
%------------------------------------------------------


% Convert RGB image to chosen color space
I = rgb2hsv(image);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.120;
channel1Max = 0.205;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.441;
channel2Max = 0.856;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.456;
channel3Max = 0.805;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

row = [1/9 1/9 1/9];
BW = imfilter(BW, [row; row; row]);

BW = imfill(BW, 'holes');

radius = 7;
decomposition = 4;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% Initialize output masked image based on input image.
maskedRGBImage = image;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end
