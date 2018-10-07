clear;
cam = webcam;
img = snapshot(cam);
 [img2, img3] = createBlueMask(img);
[img4, img5] = createYellowMask(img);
[img6, img7] = createGreenMask(img);
imgTestClr = imadd(img3, img5);
imgFinalClr = imadd(imgTestClr, img7);
imgTestBW = imadd(img4, img6);
imgFinalBW = imadd(imgTestBW, double(img2));
imshow(imgFinalClr);
[coordinates, color] = imageProcess(img)