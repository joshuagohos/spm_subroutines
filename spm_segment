#!/bin/bash
#
# Setup (with option to run) SPM12 segment module using shell script 
# invoking matlab.
#
# Usage: spm_segment sourceimgfn affreg mbfn rf
#
# sourceimgfn - Singular source image (to be segmented).
# affreg - Affine registration template, mni | eastern | subj | none | 0 |.
# mbfn - Matlab batch output file name.
# rf - flag to run matlabbatch, 0: no, 1: yes
#
# 20220519 Created by Josh Goh.

# Assign parameters
sourceimgfn=${1}
affreg=${2}
mbfn=${3}
rf=${4}

# Call matlab with input script
unset DISPLAY
matlab -nosplash > matlab.out << EOF
  settings;
  spmpath = which('spm');
  [p n e] = fileparts(spmpath);
  matlabbatch{1,1}.spm.spatial.preproc.channel.vols = {'${sourceimgfn},1'};
  matlabbatch{1,1}.spm.spatial.preproc.channel.biasreg = 1.0000e-3;
  matlabbatch{1,1}.spm.spatial.preproc.channel.biasfwhm = 60;
  matlabbatch{1,1}.spm.spatial.preproc.channel.write = [1 1];
  ngaus = [1 1 2 3 4 2];
  for tissue = 1:6,
    matlabbatch{1,1}.spm.spatial.preproc.tissue(tissue).tpm = {[p '/tpm/TPM.nii,' num2str(tissue)]};
    matlabbatch{1,1}.spm.spatial.preproc.tissue(tissue).ngaus = ngaus(tissue);
    matlabbatch{1,1}.spm.spatial.preproc.tissue(tissue).native = [1 1];
    matlabbatch{1,1}.spm.spatial.preproc.tissue(tissue).warped = [1 1];
  end
  matlabbatch{1,1}.spm.spatial.preproc.warp.mrf = 1;
  matlabbatch{1,1}.spm.spatial.preproc.warp.cleanup = 1;
  matlabbatch{1,1}.spm.spatial.preproc.warp.reg = [0 1.0000e-03 0.5000 0.0500 0.2000];
  if strcmp('${affreg}','0')
	affreg = '';
  else
	affreg = '${affreg}';
  end
  matlabbatch{1,1}.spm.spatial.preproc.warp.affreg = affreg;
  matlabbatch{1,1}.spm.spatial.preproc.warp.fwhm = 0;
  matlabbatch{1,1}.spm.spatial.preproc.warp.samp = 3;
  matlabbatch{1,1}.spm.spatial.preproc.warp.write = [1 1];
  matlabbatch{1,1}.spm.spatial.preproc.warp.vox = NaN;
  matlabbatch{1,1}.spm.spatial.preproc.warp.bb = NaN(2,3);
  save('${mbfn}','matlabbatch');
  if ${rf},
    spm_jobman('run',matlabbatch);
  end
exit;
EOF
