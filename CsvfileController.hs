module CsvfileController
( getYesterdayCsvFilename,
getTodayCsvFilename,
parseUserPwCsv
) where  

import Data.Time
import Data.Time.Format
import System.IO.Unsafe
import Data.List.Split

getYesterdayCsvFilename :: String
getYesterdayCsvFilename = unsafeDupablePerformIO $ generateCsvFilename (-1)

getTodayCsvFilename :: String
getTodayCsvFilename = unsafeDupablePerformIO $ generateCsvFilename (0)

generateCsvFilename:: Integer -> IO String
generateCsvFilename y = do
    getCurrentTime >>= return.utctDay >>= return.addDays y >>= return.toGregorian >>= return.yymmddCsv  
    where yymmddCsv (y,m,d) =  concat [show y, pad2zero m, pad2zero d, ".csv"]
          pad2zero x = if x < 10 then
                        reverse.show $ x * 10
                       else
                        show x

parseUserPwCsv szFile = (\x -> return $ map (\y -> (y!!0,y!!1)) x)
                 =<< (\x-> return $ map (splitOn ";") x)
                 =<< return.tail.lines =<< readFile szFile
