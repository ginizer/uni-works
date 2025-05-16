function condA = cond(A)
    A_inv = Gauss_elimnation(A)
    condA = norm(A) * norm(A_inv);
end




