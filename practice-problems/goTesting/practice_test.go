// https://golang.org/pkg/testing/

// Package testing provides support for automated testing of Go packages
// using "go test"

// import "testing"

package practice

import (
	"fmt"
	"testing"
)

var cases = []struct {
	str      string
	substr   string
	expected int
}{
	{
		str:      "hello",
		substr:   "ll",
		expected: 2,
	}, {
		str:      "jello",
		substr:   "he",
		expected: -1,
	}, {
		str:      "",
		substr:   "",
		expected: 0,
	},
}

//test syntax
func TestStrStr(tests *testing.T) {
	for _, test := range cases {
		actual := strStr(test.str, test.substr)
		if test.expected != actual {
			tests.Errorf("strStr(%v, %v)\nEXPECTED: %v\nNOT: %v",
				test.str, test.substr, test.expected, actual)
		}
	}
}

//example syntax
func ExampleStrStr() {
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
