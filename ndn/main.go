package main


import (
    "fmt"
    "github.com/alexflint/go-arg"
)

var cli_args struct {
	target string `arg:"required"`
}

func main() {
    arg.MustParse(&cli_args)
    fmt.Println("hello world")
}