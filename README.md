# Cloud Computing project

### Team Members

1. Mahadev Hatti - (191CS133)
2. Vithal Mhetre - (191CS262)                 
3. Shrinivas Bagadi - (191CS156)
4. Yash Sharma - (191CS164)

#### Execute VNE-code.py for results

### Example:
#### Sample output
![image](https://raw.githubusercontent.com/mahadevhatti/CC-Project/main/Result-Images/image-1.jpg)
<br><br><br><br><br><br><br>
![image](https://raw.githubusercontent.com/mahadevhatti/CC-Project/main/Result-Images/image-2.jpg)


### Psudo Code
1. The subtaskAllocation() function takes in six arguments: D, C, VL, VK, pmax, and psi.
2. The N variable is initialized to the length of the D array, which represents the number of subtasks.
3. The F array is initialized with N+1 rows and VL+1 columns. The rows correspond to the subtasks, and the columns correspond to the computation capacities of the mobile device.
4. The L and K variables are initialized to zero.
5. The first loop initializes the first row of the F array to zero.
6. The second loop uses dynamic programming to fill in the rest of the F array. For each subtask i, the loop checks if the current computation capacity k is greater than or equal to the required computation capacity D[i-1]*C[i-1]. If so, it calculates the maximum data size that can be computed for the subtask based on the previous row of the F array and the current subtask's data size and computation requirement. It updates the current cell of the F array with this maximum data size.
7. The L and K variables are calculated by backtracking through the F array. Starting from the bottom-right cell of the F array, the algorithm checks whether the maximum data size in the current cell was calculated using the previous row's value. If so, it adds the data size of the current subtask to the L variable and subtracts the computation capacity used from the VL variable. Otherwise, it moves up to the previous row.
8. The K variable is calculated by subtracting the total data size allocated to the mobile device (L) from the total data size of all subtasks (VK).
9. The M variable is calculated by subtracting the total computation capacity used by both the mobile device and the edge server (K + L) from the maximum interference threshold psi.
10. The gamma variable is calculated by dividing the maximum transmit power pmax by the sum of the product of the allocated computation capacities and the corresponding interference threshold. It is then multiplied by 100 to convert it to a percentage.
11. The function returns an array of integers containing the values of M, K, L, and gamma.
12. The main() function sets up sample input values for D, C, VL, VK, pmax, and psi.
13. The subtaskAllocation() function is called with the sample input values, and the returned array of integers is stored in the result variable.

#### Research paper:
Y. Kai, J. Wang and H. Zhu, "Energy minimization for d2d-assisted mobile edge computing networks", Proc. IEEE Int. Conf. Commun. (ICC), pp. 1-6, May. 2019
