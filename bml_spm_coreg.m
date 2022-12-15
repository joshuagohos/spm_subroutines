   EPIfn = 'SampleEPIfilename.nii';
   T2fn  = 'SampleT2filename.nii';
   matlabbatch{1}.spm.spatial.coreg.estimate.ref = {[EPIfn ',1']};
   matlabbatch{1}.spm.spatial.coreg.estimate.source = {[T2fn ',1']};
   matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
   matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
   matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
   matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.0200 0.0200 0.0200 1.0000e-03 1.0000e-03 1.0000e-03 0.0100 0.0100 0.0100 1.0000e-03 1.0000e-03 1.0000e-03];
   matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
   spm_jobman('run',matlabbatch);