% visualize the eigenfunctions
clear all;clc;

addpath([pwd,'/submodules/PlanetaryModels/modelbuilder']);

fmesh  = [pwd,'/submodules/NormalModes/demos/models/input/CONST3k/'];
fout   = [pwd,'/submodules/NormalModes/demos/models/output/CONST3k/'];
fbase  = 'CONST_1L_3k.1';
fdtail = '0.200000003_2.00000000';
JOB = 1;
pOrder = 1;
nproc = 1;
nth = 7;
Radial = 6.371E3;

fmeshorg = [fmesh,fbase];
fdat =  [fout,fbase,'_JOB',int2str(JOB),'_pod',int2str(pOrder),...
    '_np',int2str(nproc),'_',fdtail,'_',int2str(nth),'.dat'];

fvtk = [pwd,'/workflows/containerized/',fbase,'_JOB',int2str(JOB),'_pod',int2str(pOrder),...
    '_np',int2str(nproc),'_',fdtail,'_',int2str(nth),'.vtk'];

fvlist = [fout,fbase,'_pod',int2str(pOrder),...
    '_np',int2str(nproc),'_vlist.dat'];

[pxyz,tet,~,~,~] = read_mesh3d(fmeshorg);

nvtx = size(pxyz,1);

fid = fopen(fvlist,'r'); 
vlist = fread(fid,'int'); 
fclose(fid);

fid = fopen(fdat,'r');
vsol = fread(fid,'float64');
fclose(fid);
eigm0 = reshape(vsol,3,length(vsol)/3);
eigm1(:,vlist) = eigm0;
eigm  = eigm1(:,1:nvtx);

rad = sqrt(sum(pxyz'.*pxyz'));
Rcom = sum(eigm.*pxyz')./rad;

filename = fvtk;
data_title = 'eigenmodes';
% organize data
% .type field must be 'scalar' or 'vector'
% number of vector components must equal dimension of the mesh
data_struct(1).type = 'vector';
data_struct(1).name = 'modes';
data_struct(1).data = eigm(:);

data_struct(2).type = 'scalar';
data_struct(2).name = 'Radial';
data_struct(2).data = Rcom(:);


flipped = false;

stat = vtk_write_tetrahedral_grid_and_data(filename,data_title,pxyz/Radial,...
    tet,data_struct,flipped);
