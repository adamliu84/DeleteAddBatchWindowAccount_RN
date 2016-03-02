module CsvfileController
( getTodayCSV,
getYesterdayCSV
) where  

import Data.Time
import Data.Time.Format
import System.IO.Unsafe

getYesterdayCSV :: String
getYesterdayCSV = unsafeDupablePerformIO $ generateCsvFilename (-1)

getTodayCSV :: String
getTodayCSV = unsafeDupablePerformIO $ generateCsvFilename (0)

generateCsvFilename:: Integer -> IO String
generateCsvFilename y = do
    getCurrentTime >>= return.utctDay >>= return.addDays y >>= return.toGregorian >>= return.yymmddCsv  
    where yymmddCsv (y,m,d) =  concat [show y, pad2zero m, pad2zero d, ".csv"]
          pad2zero x = if x < 10 then
                        reverse.show $ x * 10
                       else
                        show x
