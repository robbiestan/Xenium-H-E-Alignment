function output_image = warp_image(imtowarp,tformresized,warpfieldresized,Rfixed)


imtowarp=imwarp(imtowarp,tformresized,'OutputView',Rfixed);
output_image=imwarp(imtowarp,warpfieldresized);%dont need to change output view

end