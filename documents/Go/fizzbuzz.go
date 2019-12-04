package main

import (
	"fmt"
)

func main() {
	for num := 0; num <= 100; num++ {
		if num%3 == 0 && num%5 == 0 {

			fmt.Println("FizzBuzz")
		} else if num%3 == 0 {
			fmt.Println("Fizz")
		} else if num%5 == 0 {
			fmt.Println("Buzz")
		} else {
			fmt.Println(num)
		}

	}

}
