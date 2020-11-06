
msort :: [Int] -> [Int]
msort []  = []
msort [x] = [x]
msort xs  = merge (msort us)(msort vs)
    where
        (us,vs) = splitAt (n `div` 2) xs
        n = length xs

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs 
merge xxs@(x:xs) yys@(y:ys)
  | x <= y    = x : merge xs yys
  | otherwise = y : merge xxs ys