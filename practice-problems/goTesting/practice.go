package main

func main() {
	strStr("hello", "ll")
	strStr("jello", "hi")
  strStr("", "")
}

func strStr(haystack string, needle string) int {
  needle_length := len(needle)
  for i := 0; i <= len(haystack) - needle_length; i++ {
    if haystack[i:i + needle_length] == needle {
      return i
    }
  }
  return -1
}

// func MinAbsDiff()  {
//
// }
