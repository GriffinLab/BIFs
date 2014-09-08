function writeBIFs(BIFs, path)

load('BIFColorMap','mycmap')

imwrite(ind2rgb(BIFs,colormap(mycmap)),path);

end
