#include <Rcpp.h>
#include <string>
using namespace Rcpp;
using namespace std;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//


// [[Rcpp::export]]
int stringLength(string str) {
  return str.size(); // or str.length()
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

// [[Rcpp::export]]
vector<string> stringLength_vector(vector<string> str_vector) {
  int n = str_vector.size();
  vector<string> length_vector(n);
  
  for (int i = 0; i < n; i++) {
    length_vector[i] = str_vector[i].size();
  }
  
  return length_vector;
}






