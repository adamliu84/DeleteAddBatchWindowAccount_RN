import System.Process
import System.Exit
import Data.List.Split
import qualified CsvfileController

main = do
    -- Remove previous day user    
    lDUsers <- readUserCSV $ CsvfileController.getYesterdayCsvFilename
    mapM_ deleteWindowUser lDUsers
    -- Add current day user
    lAUsers <- readUserCSV $ CsvfileController.getTodayCsvFilename
    mapM_ addWindowUser lAUsers    
    print "Fin"

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
