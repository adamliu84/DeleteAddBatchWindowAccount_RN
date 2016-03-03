import System.Process
import System.Exit
import qualified CsvfileController

main = do
    -- Remove previous day user    
    lDUsers <- CsvfileController.parseUserPwCsv $ CsvfileController.getYesterdayCsvFilename
    mapM_ deleteWindowUser lDUsers
    -- Add current day user
    lAUsers <- CsvfileController.parseUserPwCsv $ CsvfileController.getTodayCsvFilename
    mapM_ addWindowUser lAUsers    
    print "Fin"

    
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
