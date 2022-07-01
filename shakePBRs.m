function [alphaoutput,alphastoppled,locs] = shakePBRs(alphainput,alphathreshold, alpha0,alpha0sd)
%reset the alphas for those PBRs whose alpha is less than the threshold
locs=find(alphainput<alphathreshold); %find the toppled PBRs
alphastoppled=alphainput(locs); %pull the toppled PBRs out
alphaoutput=alphainput;
temp=alpha0+alpha0sd.*randn(length(locs),1);
for i = 1:length(locs)
    alphaoutput(locs(i))=temp(i); %reset those toppled PBRs
end
end
