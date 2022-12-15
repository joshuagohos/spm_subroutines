% Script to compute degree centrality for AXC rsfMRI data (vox size = 2.3 mm iso,
% TR = 650 ms, 626 volumes).

clear all

% Set variables
epifn = 'mFiltered_4DVolume.nii'; % Preprocessed residual EPI filename
nbatch = 512;                      % No. of batches (to manage mem limits)

% Read data + header
disp('Loading data')
[Y, xY] = spm_summarise(epifn,'all','',true);
V = spm_vol(epifn);

% Configure batching
fprintf('Configuring analysis for %d batches\n',nbatch)
[i,j] = size(Y);
batch_size = j/nbatch;
vox_range = 0;
! mkdir -p ./r_s

% Get batch voxel ranges
for b = 1:nbatch
  vox_range = [vox_range(end)+1:vox_range(end)+batch_size];
  batch(b).vox_range = vox_range;
end

% Apply batching on cross-correlations
DC = zeros(1,j); % Degree centrality brainvec
linelength = 1;
for b_col = 1:nbatch

  % Report status
  fprintf(repmat('\b',1,linelength+10))
  linelength = fprintf('Running batch %d/%d',b_col,nbatch);

  % Compute correlations
  R = corr(Y,Y(:,batch(b_col).vox_range));
  save(['./r_s/r_col' num2str(b_col)],'R','-v7.3');

  % Set column identity coordinates to NaN
  I = [zeros(batch_size*(b_col-1),batch_size);eye(batch_size);zeros(batch_size*(nbatch-b_col),batch_size)];
  R(find(I)) = NaN;

  % Compute column degree centrality
  DC(1,batch(b_col).vox_range) = mean(atanh(R),'omitnan');
end

% Reshape DC brainvec to DC volume
fprintf('\nWriting DC volume')
DC_Y = reshape(DC,V(1).dim(1),V(1).dim(2),V(1).dim(3));
DC_V = V(1);
DC_V.fname = ['DC_' epifn];
spm_write_vol(DC_V,DC_Y);

fprintf('\nDone!')
