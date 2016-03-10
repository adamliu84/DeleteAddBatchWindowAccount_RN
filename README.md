# DeleteAddBatchWindowAccount_RN

Creation of window user account via csv

## Encryption of today window user account

```
runhaskell EncryptTodayUser.hs
```

The script will read *today.csv* and generate out a user account listing with password encrypted.
The file will be in for that day date format of *YYYYMMDD.csv*

## Creation of window user account listing

```
runhaskell SystemDAUser.hs
```

The script will read in the newly encrypted csv to create the user account for the ady.
The script will also read in the previous day user account and remove it from the window account.
