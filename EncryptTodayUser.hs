import Data.List.Split
import Data.List
import qualified EncryptController
import qualified CsvfileController (getTodayCsvFilename)

main = do
    -- Read today user
    lRawUsers <- readUserCSV "today.csv"
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

-- CSV Reading
readUserCSV szFile = (\x -> return $ map (\y -> (y!!0,y!!1)) x)
                 =<< (\x-> return $ map (splitOn ";") x)
                 =<< return.tail.lines =<< readFile szFile
