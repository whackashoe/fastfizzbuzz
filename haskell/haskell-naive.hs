fizzy :: Integer -> String
fizzy n
    | mod n 15 == 0 = "FizzBuzz"
    | mod n 5  == 0 = "Buzz"
    | mod n 3  == 0 = "Fizz"
    | otherwise     = show n

main :: IO()
main = mapM_ putStrLn (take 1000000 . map fizzy $ [1..])
