using Images, SIUnits
using Base.Test

const savedir = joinpath(tempdir(), "Images")
const writedir = joinpath(savedir, "write")

if !isdir(savedir)
    mkdir(savedir)
end
if !isdir(writedir)
    mkdir(writedir)
end


# Gray, raw
img = imread(joinpath(Pkg.dir(), "Images", "test", "io", "small.nrrd"))
@assert colorspace(img) == "Gray"
@assert ndims(img) == 3
@assert colordim(img) == 0
@assert eltype(img) == Float32
outname = joinpath(writedir, "small.nrrd")
imwrite(img, outname)
imgc = imread(outname)
@assert img.data == imgc.data

img = imread(joinpath(Pkg.dir(), "Images", "test", "io", "units.nrrd"))
ps = pixelspacing(img)
@test_approx_eq ps[1]/(0.1*Milli*Meter) 1
@test_approx_eq ps[2]/(0.2*Milli*Meter) 1
@test_approx_eq ps[3]/(1*Milli*Meter) 1

# Gray, compressed (gzip)
img = imread(joinpath(Pkg.dir(), "Images", "test", "io", "smallgz.nrrd"))
@assert colorspace(img) == "Gray"
@assert ndims(img) == 3
@assert colordim(img) == 0
@assert eltype(img) == Float32
outname = joinpath(writedir, "smallgz.nrrd")
imwrite(img, outname)
imgc = imread(outname)
@assert img.data == imgc.data
