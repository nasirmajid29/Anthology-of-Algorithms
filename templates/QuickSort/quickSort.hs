
qsort :: [Int] -> [Int]
qsort [] = []
-- qsort [x] = [x]
qsort (x:xs) = qsort lte ++ [x] ++ qsort gt
    where
        (lte,gt) = partition (<= x) xs

partition :: (a -> Bool) -> [a] -> ([a],[a])
partition p xs = (filter p xs, filter (not.p) xs)