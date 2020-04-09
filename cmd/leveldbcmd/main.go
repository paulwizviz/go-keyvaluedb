package main

import (
	"log"

	"github.com/syndtr/goleveldb/leveldb"
)

func main() {
	db, err := leveldb.OpenFile("./db", nil)
	if err != nil {
		log.Fatalf("Unable to create db. Reason: %v", err)
	}
	defer db.Close()

	key := []byte("name")

	err = db.Put(key, []byte("test"), nil)
	if err != nil {
		log.Fatalf("Unable to insert value. Reason: %v", err)
	}

	value, err := db.Get(key, nil)
	if err != nil {
		log.Fatalf("Unable to retrieve value. Reason: %v", err)
	}

	log.Printf("Key: %s Value: %s", string(key), string(value))
}
