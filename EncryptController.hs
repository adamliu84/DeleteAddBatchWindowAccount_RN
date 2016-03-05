{-# LANGUAGE OverloadedStrings #-}

module EncryptController
( encryptPassword,
decryptPassword
) where  

import Data.ByteString.Base64 (decode)
import Data.Bits (xor)
import qualified Data.ByteString.Char8 as C8
import qualified Data.ByteString as B
import qualified Data.List as DL

-- https://www.schoolofhaskell.com/school/to-infinity-and-beyond/pick-of-the-week/bytestring-bits-and-pieces
Right key = decode.C8.pack $ (DL.concat $ DL.replicate 30 "ABCD")
encrypt = B.pack.B.zipWith xor key
encrypt' = C8.unpack.encrypt.C8.pack
encryptPassword = encrypt'
decryptPassword = encrypt'


