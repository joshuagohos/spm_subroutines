#!/bin/bash
#
# Setup (with option to run) SPM12 coregistration module using shell 
# script invoking matlab.
#
# Usage: spm_coreg refimgfn sourceimgfn otherimgfn mbfn rf
#
# refimgfn - Reference image (stationary) full path.
# sourceimgfn - Source image (adjusted) full path.
# otherimgfn - Singular other image full path, or text filename with 
#              fullpaths per row per image, or 0.
# mbfn - Matlab batch output file name.
# rf - flag to run matlabbatch, 0: no, 1: yes
#
# 20220519 Created by Josh Goh.

# Assign parameters
refimgfn=${1}
sourceimgfn=${2}
otherimgfn=${3}
mbfn=${4}
rf=${5}

# Call matlab with input script
unset DISPLAY
matlab -nosplash > matlab.out << EOF
  settings;
  matlabbatch{1,1}.spm.spatial.coreg.estimate.ref = {'${refimgfn},1'};
  matlabbatch{1,1}.spm.spatial.coreg.estimate.source = {'${sourceimgfn},1'};
  if strcmp('${otherimgfn}','0')
	other = {''};
  else
	[p n e] = fileparts('${otherimgfn}');
	if strcmp(e,'.nii')
		ni = niftiinfo('${otherimgfn}');
		if length(ni.ImageSize)==4
			nvols = ni.ImageSize(4);
			for t = 1:nvols,
				temp(t).epivol = [deblank(S{r}) ',' num2str(t)];
			end;
			other = cellstr(strvcat(temp.epivol));
		else
			other = '${otherimgfn},1';
		end
	else
		S = textread('${otherimgfn}','%s');
		nfiles = size(S,1);
		i=1;
		for r = 1:nfiles,
			ni = niftiinfo(S{r});
			if length(ni.ImageSize)==4
				nvols = ni.ImageSize(4);
				for t = 1:nvols,
					temp(i).epivol = [deblank(S{r}) ',' num2str(t)];
					i=i+1;
				end;
			else
				temp(i).epivol = '${otherimgfn},1';
				i=i+1;
			end	
		end
		other = cellstr(strvcat(temp.epivol));
	end
  end
  matlabbatch{1,1}.spm.spatial.coreg.estimate.other = other;
  matlabbatch{1,1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
  matlabbatch{1,1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
  matlabbatch{1,1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
  matlabbatch{1,1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
  save('${mbfn}','matlabbatch');
  if ${rf},
    spm_jobman('run',matlabbatch);
  end
exit;
EOF
