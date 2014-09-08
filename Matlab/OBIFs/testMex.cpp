#include "mex.h"
#include <math.h>
//nlhs	Number of expected mxArrays (Left Hand Side)
//plhs	Array of pointers to expected outputs
//nrhs	Number of inputs (Right Hand Side)
//prhs	Array of pointers to input data. The input data is read-only and should not be altered by your mexFunction .

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
 int i, index, outputX, outputY;
 double *inputArray, *inputImage;
 double *output;
 double closest;
 int elements,nDirections;

// Get the input angle
inputImage = mxGetPr(prhs[0]);
inputArray = mxGetPr(prhs[1]);
outputX = (int)mxGetPr(prhs[2])[0];
outputY = (int)mxGetPr(prhs[3])[0];

/* Create a pointer to the output data */
plhs[0] = mxCreateDoubleMatrix(outputX, outputY,mxREAL);
output = mxGetPr(plhs[0]);
elements=mxGetNumberOfElements(prhs[0]);
nDirections=mxGetNumberOfElements(prhs[1]);


for ( int x = 0; x < elements; x++) {
    closest = inputArray[0];
    output[x] = 1;
    
    for ( int i = 0; i < nDirections; ++i ) {
        if ( fabs( inputArray[ i ] - inputImage[x] ) < fabs( closest - inputImage[x] ) ) 
        {
          closest = inputArray[i];
          output[x] = i+1;
        }
    }
}

}
        