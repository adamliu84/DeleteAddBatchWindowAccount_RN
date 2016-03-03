import Data.List.Split
import Data.List
import qualified EncryptController
import qualified CsvfileController (getTodayCsvFilename, parseUserPwCsv)

main = do
    -- Read today user
    lRawUsers <- CsvfileController.parseUserPwCsv "today.csv"
    let lEnUsers = map (\x->(fst x, enPW x)) lRawUsers    
	csvfilename = CsvfileController.getTodayCsvFilename
    -- Write today user with encrypted password
    writeCSVHeader csvfilename
    mapM_ (writeCSVData csvfilename) lEnUsers
    where enPW = EncryptController.encryptPassword.snd

-- CSV writer
writeCSVHeader csvfilename = do
    writeFile csvfilename $ "username;password\n"
writeCSVData csvfilename (x,y) = do
    appendFile csvfilename $ intercalate  ";" [x,y] ++ "\n"
