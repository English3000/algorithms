// https://golang.org/pkg/testing/

// Package testing provides support for automated testing of Go packages
// using "go test"

// import "testing"

package main

import (
  "fmt"
)

func ExampleHello() {
  result1 := strStr("hello", "ll")
	result2 := strStr("jello", "hi")
  result3 := strStr("", "")
  fmt.Printf("%v, %v, %v", result1, result2, result3)
  // Output: 2, -1, 0
}

// func TestStrStr(t *testing.T) {
//
// }

// func TestMinAbsDiff() {
//
// }
