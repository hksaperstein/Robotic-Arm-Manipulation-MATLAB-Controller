clear;
cam = webcam;
img = snapshot(cam);
[img2, img3] = createBlueMask(img);
[img4, img5] = createYellowMask(img);
[img6, img7] = createGreenMask(img);
imgTest = imadd(img4, img6);
imgFinal = imadd(imgTest, double(img2));
 imshow(imgFinal)


