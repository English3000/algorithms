package practice

func strStr(haystack string, needle string) int {
	needleLength := len(needle)
	for i := 0; i <= len(haystack)-needleLength; i++ {
		if haystack[i:i+needleLength] == needle {
			return i
		}
	}
	return -1
}

// func MinAbsDiff()  {
//
// }

/* Answer: https://www.quora.com/Given-a-matrix-represented-as-int-n-n-rotate-it-90-degrees-clockwise-in-place-In-place-means-minimal-extra-memory-to-be-used-ie-dont-make-a-new-array-to-copy-into


func main() {
	input := [][]int{
	  []int{1, 2, 3},
	  []int{4, 5, 6},
	  []int{7, 8, 9},
	}
	rotate(input)
}

//going from outer layers to inner layers
func rotateMatrixInplace(matrix [][]int) {
	length := len(matrix) - 1;

	for i := 0; i <= (length)/2; i++ { //left bound
		for j := i; j < length-i; j++ { //right bound

			int temp = matrix[i][j];

			matrix[i][j] = matrix[length-j][i];
			matrix[length-j][i] = matrix[length-i][length-j];
			matrix[length-i][length-j] = matrix[j][length-i];
			matrix[j][length-i] = temp;
		}
	}
}
*/
