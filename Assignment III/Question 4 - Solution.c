#include <stdio.h>
const int rows = 5;
const int cols = 2;
int matrixTranspose(int testMatrix[rows][cols], int transpose[cols][rows]);

int main() {

    int originalMatrix[rows][cols] = {{1,2},
                         {3,4},
                         {5,6},
                         {7,8},
                         {9,10}};
    // int transposedMatrix[cols][rows];
    int **transposedMatrix = (int **)malloc(sizeof(int*) * rows);

    for (int i = 0; i < rows; i++){
        *(transposedMatrix+i) = (int*)malloc(sizeof(int)*cols);
    }
    
    matrixTranspose(originalMatrix, transposedMatrix);

    printf("\nTranspose of the matrix:\n");
    for (int i = 0; i < cols; ++i)
        for (int j = 0; j < rows; ++j) {
            printf("%d  ", transposedMatrix[i][j]);
            if (j == rows - 1)
                printf("\n");
        }
    return 0;
}

int matrixTranspose(int myMatrix[rows][cols], int transpose[cols][rows]){

    if (rows == cols)
    {
        for (int i = 0; i < rows; i++){
            for (int j = 0; j < cols; j++) {
                transpose[j][i] = myMatrix[i][j];
            }
        }
    }
    else{
        for (int i = 0; i < rows; i++){
            for (int j = 0; j < cols; j++) {
                *(*(transpose + j) + i) = *(*(myMatrix + i) + j);
            }
        }
    }
    return 0;
}