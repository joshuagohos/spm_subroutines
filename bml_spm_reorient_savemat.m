   [p n e] = fileparts(T1fn);
   matlabbatch{1}.spm.util.reorient.srcfiles = {[T1fn ',1']};
   matlabbatch{1}.spm.util.reorient.transform.transF = {[n '_reorient.mat,1']};
   matlabbatch{1}.spm.util.reorient.prefix = '';
   spm_jobman('run',matlabbatch);
