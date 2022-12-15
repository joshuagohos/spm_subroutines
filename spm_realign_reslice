#!/bin/bash
#
# Setup (with option to run) SPM12 realign and reslice EPI module using 
# shell script invoking matlab.
#
# Usage: spm_realign_reslice inputdat rtm mbfn rf
#
# inputdat - Singular EPI .nii fullpath or text filename with fullpaths
#            per row per EPI.
# rtm - Register to mean, 0: register to first, 1: register to mean
# mbfn - Matlab batch output file name.
# rf - flag to run matlabbatch, 0: no, 1: yes
#
# 20220518 Created by Josh Goh.

# Assign parameters
inputdat=${1}
rtm=${2}
mbfn=${3}
rf=${4}

# Call matlab with input script
unset DISPLAY
matlab -nosplash -nodesktop > matlab.out << EOF
  settings;
  [p n e] = fileparts('${inputdat}');
  if strcmp(e,'.nii'),
	nrun = 1;
	S = {'${inputdat}'};
  else
	S = textread('${inputdat}','%s');
	nrun = size(S,1);
  end
  for r = 1:nrun,
	ni = niftiinfo(S{r});
	nvols = ni.ImageSize(4);
	for t = 1:nvols,
		temp(t).epivol = [deblank(S{r}) ',' num2str(t)];
	end;
	matlabbatch{1,1}.spm.spatial.realign.estwrite.data{1,r} = cellstr(strvcat(temp.epivol));
  end;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.rtm = ${rtm};
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
  matlabbatch{1,1}.spm.spatial.realign.estwrite.eoptions.weight = {''};
  matlabbatch{1,1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
  matlabbatch{1,1}.spm.spatial.realign.estwrite.roptions.interp = 4;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
  matlabbatch{1,1}.spm.spatial.realign.estwrite.roptions.mask = 1;
  matlabbatch{1,1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
  save('${mbfn}','matlabbatch');
  if ${rf},
    spm_jobman('run',matlabbatch);
  end
exit;
EOF
