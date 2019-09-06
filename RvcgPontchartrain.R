# Robert Z. Selden, Jr. - HRC/SFASU
# 06082019/iteration1 - preliminary/not final
# mesh processing prior to analysis
# all meshes preprocessed in scanner-specific software
require(devtools)
install_github("zarquon42b/Rvcg", local=FALSE)
library(Rvcg)
library(rgl)
# set working directory
setwd(getwd())
###################
# processing (file)
x<-"ply/005.ply"
# import mesh
mesh<-vcgImport(x, updateNormals = TRUE, readcolor = FALSE, clean = TRUE, silent = FALSE)
# descriptive characteristics of mesh
# number of vertices and triangular faces
meshInfo(mesh)
# check for existance and validity of vertices, faces and vertex normals
meshintegrity(mesh, facecheck = TRUE, normcheck = TRUE)
# compute surface area of mesh
vcgArea(mesh, perface = FALSE)
# identify resolution of mesh for use as voxelSize in remesh
mres<-vcgMeshres(mesh)
mres # mesh resolution
# histogram of average edge length
hist(mres$edgelength)
# visualize average edge length on graph
points(mres$res, 1000, pch=20, col=2, cex=2)
# uniform remesh - voxel size set to mesh resolution
remesh<-vcgUniformRemesh(mesh, voxelSize = 0.02, offset = 0, discretize = FALSE,
                         multiSample = FALSE, absDist = FALSE, mergeClost = FALSE, 
                         silent = FALSE)
# number of vertices and triangular faces after remesh
meshInfo(remesh)
# export as OFF to data file
vcgOffWrite(remesh, filename = "data3d/005s")
# decimate mesh
decimated<-vcgQEdecim(remesh, percent = 0.5)
# number of vertices and triangular faces after remesh
meshInfo(decimated)
# export as OFF to lowres file
vcgOffWrite(decimated, filename = "data3d/lowres/005s")
# end of script