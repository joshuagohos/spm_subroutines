#!/bin/bash
#
# Setup (with option to run) SPM12 slice-timing EPI module using shell 
# script invoking matlab.
#
# Usage: spm_slice-timing inputdat refslice so_spec mbfn rf
#
# inputdat - Singular EPI .nii fullpath or text filename with fullpaths
#            per row per EPI.
# refslice - Target slice to adjust timing to.
# so_spec - 1: Sequential, 2: Asc. Inter 2, 9: Slice-timing (MB).
# mbfn - Matlab batch output file name.
# rf - flag to run matlabbatch, 0: no, 1: yes
#
# 20220518 Created by Josh Goh.

# Assign parameters
inputdat=${1}
refslice=${2}
so_spec=${3}
mbfn=${4}
rf=${5}

# Call matlab with input script
unset DISPLAY
matlab -nosplash > matlab.out << EOF
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
    matlabbatch{1,1}.spm.temporal.st.scans{1,r} = cellstr(strvcat(temp.epivol));
  end
  nslices = ni.ImageSize(3);
  tr = ni.PixelDimensions(4);
  switch ${so_spec}
	case 1
		so = [1:nslices];
	case 2
		so = [2:2:nslices 1:2:nslices];
	case 9
		error('Enter slice-timing')
  end
  matlabbatch{1,1}.spm.temporal.st.nslices = nslices;
  matlabbatch{1,1}.spm.temporal.st.tr = tr;
  matlabbatch{1,1}.spm.temporal.st.ta = tr - (tr/nslices);
  matlabbatch{1,1}.spm.temporal.st.so = so;
  matlabbatch{1,1}.spm.temporal.st.refslice = ${refslice};
  matlabbatch{1,1}.spm.temporal.st.prefix = 'a';
  save('${mbfn}','matlabbatch');
  if ${rf},
    spm_jobman('run',matlabbatch);
  end
exit;
EOF
