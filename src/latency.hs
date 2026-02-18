import System.Process (readProcess)
import Control.Concurrent (threadDelay)
import Data.List (isInfixOf)
import Text.Read (readMaybe)

host :: String
host = "8.8.8.8"

maxSamples :: Int
maxSamples = 50

graphHeight :: Int
graphHeight = 15

main :: IO ()
main = loop [] Nothing

-- previous latenc stored to calculate jitter
loop :: [Int] -> Maybe Int -> IO ()
loop history prev = do
    out <- readProcess "ping" ["-c","1",host] ""
    let latency = extractLatency (lines out)

    let adjusted =
            case (latency, prev) of
                (Just v, Just p) -> Just (v + abs (v - p) * 2)
                (Just v, Nothing) -> Just v
                _ -> Nothing

    let newHist =
            case adjusted of
                Just v  -> takeLast maxSamples (history ++ [v])
                Nothing -> history

    clearScreen
    drawGraph newHist adjusted

    threadDelay 1000000
    loop newHist latency

extractLatency :: [String] -> Maybe Int
extractLatency [] = Nothing
extractLatency (x:xs)
    | "time=" `isInfixOf` x =
        let val = takeWhile (\c -> c /= ' ' && c /= 'm')
                  (drop 1 (dropWhile (/='=') x))
        in case readMaybe val :: Maybe Double of
            Just v  -> Just (round v)
            Nothing -> Nothing
    | otherwise = extractLatency xs

takeLast :: Int -> [a] -> [a]
takeLast n xs = drop (length xs - min n (length xs)) xs

-- graph with axes
drawGraph :: [Int] -> Maybe Int -> IO ()
drawGraph [] _ = putStrLn "waiting..."
drawGraph xs lastVal = do
    let maxVal = max 1 (maximum xs)
    let scaled = map (\v -> (v * graphHeight) `div` maxVal) xs

    putStrLn ("LATENCY GRAPH  host: " ++ host)
    putStrLn ""

    mapM_ putStrLn
        [ yLabel level maxVal ++ " |" ++
          [ if h >= level then '█' else ' '
          | h <- scaled ]
        | level <- reverse [1..graphHeight]
        ]

    putStrLn ("     +" ++ replicate maxSamples '-')
    putStrLn ("      time →")

    putStrLn (stats xs lastVal)
    putStrLn (trend xs)

-- Y axis labels
yLabel :: Int -> Int -> String
yLabel level maxVal =
    let val = (level * maxVal) `div` graphHeight
        s   = show val ++ "ms"
    in replicate (5 - length s) ' ' ++ s

-- stats footer
stats :: [Int] -> Maybe Int -> String
stats xs lastVal =
    let mn  = minimum xs
        mx  = maximum xs
        avg = sum xs `div` length xs
        lst = maybe "-" show lastVal
    in "LAST " ++ lst ++ "ms   MIN " ++ show mn
       ++ "ms   AVG " ++ show avg
       ++ "ms   MAX " ++ show mx ++ "ms"


trend :: [Int] -> String
trend xs
    | length xs < 6 = "TREND: collecting data..."
    | otherwise =
        let recent = takeLast 6 xs
            firstV = head recent
            lastV  = last recent
            diff   = lastV - firstV
        in if abs diff <= 3
              then "TREND: STABLE"
           else if diff > 0
              then "TREND: INCREASING LATENCY"
           else "TREND: DECREASING LATENCY"

clearScreen :: IO ()
clearScreen = putStr "\ESC[2J\ESC[H"

