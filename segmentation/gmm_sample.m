function [probs] = gmm_sample(gmm, data)

data_hsv = rgb2hsv(double(data) / 255);

probs_skin = mvnpdf(data_hsv, gmm.mu(1, :), ...
    gmm.Sigma(:, :, 1)) * gmm.ComponentProportion(1);
probs_shirt = mvnpdf(data_hsv, gmm.mu(2, :), ...
    gmm.Sigma(:, :, 2)) * gmm.ComponentProportion(2);
probs_pants = mvnpdf(data_hsv, gmm.mu(3, :), ...
    gmm.Sigma(:, :, 3)) * gmm.ComponentProportion(3);

probs_all = probs_skin + probs_shirt + probs_pants;

probs_skin = probs_skin ./ probs_all;
probs_shirt = probs_shirt ./ probs_all;
probs_pants = probs_pants ./ probs_all;

probs = [probs_skin, probs_shirt, probs_pants];

% probs_skin = ...
%     mvnpdf(data_hsv, gmm.skin.mu(1, :), gmm.skin.Sigma(:, :, 1)) * gmm.skin.ComponentProportion(1) + ...
%     mvnpdf(data_hsv, gmm.shirt.mu(1, :), gmm.shirt.Sigma(:, :, 1)) * gmm.shirt.ComponentProportion(1) + ...
%     mvnpdf(data_hsv, gmm.pants.mu(1, :), gmm.pants.Sigma(:, :, 1)) * gmm.pants.ComponentProportion(1);
% 
% probs_shirt = ...
%     mvnpdf(data_hsv, gmm.skin.mu(2, :), gmm.skin.Sigma(:, :, 2)) * gmm.skin.ComponentProportion(2) + ...
%     mvnpdf(data_hsv, gmm.shirt.mu(2, :), gmm.shirt.Sigma(:, :, 2)) * gmm.shirt.ComponentProportion(2) + ...
%     mvnpdf(data_hsv, gmm.pants.mu(2, :), gmm.pants.Sigma(:, :, 2)) * gmm.pants.ComponentProportion(2);
% 
% probs_pants = ...
%     mvnpdf(data_hsv, gmm.skin.mu(3, :), gmm.skin.Sigma(:, :, 3)) * gmm.skin.ComponentProportion(3) + ...
%     mvnpdf(data_hsv, gmm.shirt.mu(3, :), gmm.shirt.Sigma(:, :, 3)) * gmm.skin.ComponentProportion(3) + ...
%     mvnpdf(data_hsv, gmm.pants.mu(3, :), gmm.pants.Sigma(:, :, 3)) * gmm.skin.ComponentProportion(3);
% 
% probs = [probs_skin, probs_shirt, probs_pants];

end

