import System.Process
import System.Exit
import Data.List.Split
import Data.Time
import Data.Time.Format
import Text.Printf

main = do
    c <- getCurrentTime
    -- Remove previous day user    
    lDUsers <- readUserCSV $ generateCsvFilename $ toGregorian $ addDays (-1) $utctDay c
    mapM_ deleteWindowUser lDUsers
    -- Add current day user
    lAUsers <- readUserCSV $  generateCsvFilename $ toGregorian $ utctDay c
    mapM_ addWindowUser lAUsers    
    print "Fin"
    where generateCsvFilename (y,m,d) =  concat [show y, pad2zero m, pad2zero d, ".csv"]
          pad2zero x = if x < 10 then
                         reverse.show $ x * 10
                       else
                         show x

-- CSV Reading
readUserCSV szFile = (\x -> return $ map (\y -> (y!!0,y!!1)) x)
                 =<< (\x-> return $ map (splitOn ";") x)
                 =<< return.tail.lines =<< readFile szFile
    
-- Window user operation
addWindowUser (username,password) = do    
    executeWindowCMD $ "net user \""++username++"\" \""++password++"\" /ADD"
deleteWindowUser (username,password) = do
    executeWindowCMD $ "net user \""++username++"\" /DELETE"
executeWindowCMD szCmd = do
    print szCmd
    --exitCode <- system szCmd
    --case exitCode of
        --ExitSuccess -> return ()
        --(ExitFailure x) -> print $ "Error code:" ++ show x
