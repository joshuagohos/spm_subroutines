~/Desktop/moco/code/spm_realign_reslice ~/Desktop/moco/test_spm_1/ADMT048/ADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii 1 ADMT048_mri_spm_realign_reslice 1
~/Desktop/moco/code/spm_slice-timing ~/Desktop/moco/test_spm_1/ADMT048/rADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii 2 2 ADMT048_mri_spm_slice-timing 1
~/Desktop/moco/code/spm_coreg ~/Desktop/moco/test_spm_1/ADMT048/arADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii ~/Desktop/moco/test_spm_1/ADMT048/ADMT048_MPRAGE_Sag_1mm_iso_g2_20160926143104_4.nii 0 ADMT048_mri_spm_coreg_T1-EPI 1
~/Desktop/moco/code/spm_segment ~/Desktop/moco/test_spm_1/ADMT048/ADMT048_MPRAGE_Sag_1mm_iso_g2_20160926143104_4.nii eastern ADMT048_mri_spm_segment 1
~/Desktop/moco/code/spm_normalise_write ~/Desktop/moco/test_spm_1/ADMT048/arADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii ~/Desktop/moco/test_spm_1/ADMT048/y_ADMT048_MPRAGE_Sag_1mm_iso_g2_20160926143104_4.nii 3,3,3 ADMT048_mri_spm_normalise_write 1
~/Desktop/moco/code/spm_smooth ~/Desktop/moco/test_spm_1/ADMT048/warADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii 8,8,8 ADMT048_mri_spm_smooth 1

~/Desktop/moco/code/spm_extract_roi_values ~/Desktop/moco/test_spm_1/ADMT048/arADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii ~/Desktop/moco/test_spm_1/ADMT048/c2ADMT048_MPRAGE_Sag_1mm_iso_g2_20160926143104_4.nii ADMT048_mri_spm_REST_c2dat
~/Desktop/moco/code/spm_extract_roi_values ~/Desktop/moco/test_spm_1/ADMT048/arADMT048_ep2d_moco_4mm_180_REST_20160926143104_15.nii ~/Desktop/moco/test_spm_1/ADMT048/c3ADMT048_MPRAGE_Sag_1mm_iso_g2_20160926143104_4.nii ADMT048_mri_spm_REST_c3dat
