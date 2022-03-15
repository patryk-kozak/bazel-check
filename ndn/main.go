package main

import (
	"fmt"
	"github.com/jessevdk/go-flags"
)

type Options struct {
    Verbose []bool `short:"v" long:"verbose" description:"Show verbose debug information"`
}


func main() {
    flags.Parse(&Options)
	fmt.Println(Options.Verbose)
}
