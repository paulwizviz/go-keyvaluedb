package main

import (
	"fmt"
	"log"
	"os"
	"path"

	badger "github.com/dgraph-io/badger/v3"
)

func main() {
	wd, _ := os.Getwd()
	tmpDir := path.Join(wd, "tmp", "badger")
	db, err := badger.Open(badger.DefaultOptions(tmpDir))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.Update(func(txn *badger.Txn) error {
		err := txn.Set([]byte("answer"), []byte("42"))
		return err
	})
	if err != nil {
		log.Fatal(err)
	}

	err = db.View(func(txn *badger.Txn) error {
		item, err := txn.Get([]byte("answer"))
		if err != nil {
			log.Fatal(err)
		}

		var valNot, valCopy []byte
		err = item.Value(func(val []byte) error {
			// This func with val would only be called if item.Value encounters no error.

			// Accessing val here is valid.
			fmt.Printf("The answer is: %s\n", val)

			// Copying or parsing val is valid.
			valCopy = append([]byte{}, val...)

			// Assigning val slice to another variable is NOT OK.
			valNot = val // Do not do this.
			return nil
		})
		if err != nil {
			return err
		}

		// DO NOT access val here. It is the most common cause of bugs.
		fmt.Printf("NEVER do this. %s\n", valNot)

		// You must copy it to use it outside item.Value(...).
		fmt.Printf("The answer is: %s\n", valCopy)

		// Alternatively, you could also use item.ValueCopy().
		valCopy, err = item.ValueCopy(nil)
		if err != nil {
			return err
		}
		fmt.Printf("The answer is: %s\n", valCopy)

		return nil
	})

	if err != nil {
		log.Fatal(err)
	}
}
