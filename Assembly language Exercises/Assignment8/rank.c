
void compute_ranks(float *F, int N, int *R, float *avg, float 
    *passing_avg, int *num_passed) 
{
    int i, j;
    float sum [5]= {0.0, 0.0, 0.0, 0.0, 0.0}; //sum5= 0.0;

// (b) Here use local variables to replace pointers to 
//    reduce the memory aliasing.
    
    int numofpassed = 0;// the number of all the grades >= 50.0
    float total = 0.0;// the total of all the grades
    float passingofavg = 0.0;// the total of all the grades >= 50.0
    
// (c) Using loop unrolling + 5, to decrease the time in loop.
//  Becasue of less time spend in the loop, it will take less circles.
    
    for (i = 0; i < N-2; i += 5) 
    {
        R[i] = 1;
        R[i+1] = 1;
        R [i+2] = 1;
        R [i+3] = 1;
        R [i+4] = 1; // Loop unrolling + 5
        sum[0] += F[i];
        sum[1] += F[i+1];
        sum[2] += F [i+2];
        sum[3] += F [i+3];
        sum[4] += F [i+4];// Loop unrolling + 5
        if (F[i] >= 50.0) {
            passingofavg += F[i];
            numofpassed += 1;
        }
        if (F[i+1] >= 50.0) {
            passingofavg += F[i+1];
            numofpassed += 1;
        }
        if (F[i+2] >= 50.0) {
            passingofavg += F[i+2];
            numofpassed += 1;
        }
        if (F[i+3] >= 50.0) {
            passingofavg += F[i+3];
            numofpassed += 1;
        }
        if (F[i+4] >= 50.0) {
            passingofavg += F[i+4];
            numofpassed += 1;// Loop unrolling + 5
        }
    }
    
    total = sum[0] + sum[1] + sum[2]+ sum[3]+ sum[4];
    for ( ; i < N; i++) {
        R[i] = 1;
        total += F[i];
        if (F[i] >= 50.0) {
            passingofavg += F[i];
            numofpassed += 1;
        }
    }

    
    for (i = 0; i < N; i++) 
    {
        for (j = i+1; j < N; j++) 
        {
            if (F[i] < F[j]) 
            {
                R[i] += 1;
            }
            else if (F[i] > F[j]) 
            {
                R[j] += 1;
            }
        }
    }
    if (N > 0) *avg = total / N;
    if (numofpassed > 0) *passing_avg = passingofavg / numofpassed;
    *num_passed = numofpassed;
} 