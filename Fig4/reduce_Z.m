function X2 = reduce_Z(Z, time)


ext_time=Z(:,1);

for l=1:length(time)
    possible_ix=find(time(l)==ext_time);
    ix_time(l,1) = possible_ix(end);
end
X2=Z(ix_time,:);