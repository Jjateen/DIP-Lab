# Shannon-Fano Coding  

## Author  
**Name:** Jjateen Gundesha  
**Roll Number:** BT22ECI002  

---

### Overview  
This repository contains an implementation of **Shannon-Fano Coding** in MATLAB, including a function (`ShannonFano.m`) and a script (`run.m`) to demonstrate the algorithm. The implementation allows users to compress a set of symbols based on their probabilities and compute the average codeword length.  

---

### Contents  
1. **ShannonFano.m**  
   - A MATLAB function that performs the Shannon-Fano coding algorithm.  
   - Inputs: Symbol probabilities as a row vector.  
   - Outputs: Binary codes for each symbol and the average codeword length.  

2. **run.m**  
   - A script to run the Shannon-Fano coding implementation interactively.  
   - Includes user prompts to input probabilities and displays the results.  

---

### Concept  
**Shannon-Fano Coding** is a lossless data compression technique that generates prefix-free codes for a given set of symbols.  

#### Algorithm Steps  
1. **Sort Symbols**: Arrange symbols by their probabilities in descending order.  
2. **Divide Groups**: Recursively split the set of symbols into two groups with equal or nearly equal probability sums.  
3. **Assign Bits**: Assign `0` to symbols in the left group and `1` to those in the right group.  
4. **Repeat**: Continue splitting until each symbol has a unique binary code.  

The resulting code minimizes the **expected codeword length**, calculated as:  

![Expected Codeword Length Formula](https://latex.codecogs.com/png.image?\dpi{120}\color{White}L_{\text{avg}}%20=%20\sum_{i=1}^{N}%20P_i%20\cdot%20L_i)  

Where:  
- ![P_i](https://latex.codecogs.com/png.image?\dpi{120}\color{White}P_i): Probability of the ![i\text{-th}](https://latex.codecogs.com/png.image?\dpi{120}\color{White}i\text{-th}) symbol.  
- ![L_i](https://latex.codecogs.com/png.image?\dpi{120}\color{White}L_i): Length of the binary codeword for the ![i\text{-th}](https://latex.codecogs.com/png.image?\dpi{120}\color{White}i\text{-th}) symbol.  

---

### How to Use  

#### Running the Script (`run.m`)  
1. **Open MATLAB**:  
   Navigate to the directory containing the files.  

2. **Execute the Script**:  
   Run the `run.m` script:  
   ```matlab
   >> run
   ```  

3. **Input Probabilities**:  
   Enter the probabilities of the symbols as a row vector (e.g., `[0.3, 0.2, 0.2, 0.1, 0.1]`).  

4. **View Results**:  
   The script will:  
   - Display the symbols, probabilities, and their binary codes.  
   - Compute and display the average codeword length.  

---

### Example Output  

#### Input Probabilities:  
- **User Input**: `[0.4, 0.3, 0.2, 0.1]`  

#### Output:  
| Symbol | Probability | Code  |  
|--------|-------------|-------|  
| 1      | 0.4         | `0`   |  
| 2      | 0.3         | `10`  |  
| 3      | 0.2         | `110` |  
| 4      | 0.1         | `111` |  

**Average Codeword Length**: `1.7`  

---

### Function (`ShannonFano.m`)  

The `ShannonFano` function is the core of the implementation.  

#### Inputs:  
- `probabilities`: A row vector containing the probabilities of the symbols.  

#### Outputs:  
- `codewords`: A cell array of binary strings, representing the Shannon-Fano codes.  
- `average_length`: The average codeword length.  

#### Example Usage:  
```matlab
probabilities = [0.4, 0.3, 0.2, 0.1];  
[codewords, average_length] = ShannonFano(probabilities);  
disp(codewords);  
disp(average_length);  
```  

---

### Requirements  
- MATLAB R2022a or newer  

---

### Applications  
Shannon-Fano coding is used in:  
- **Data Compression**: Reducing the size of text, images, and audio files.  
- **Communication Systems**: Efficient binary encoding for data transmission.  

---

### References  
- [Shannon-Fano Coding - Wikipedia](https://en.wikipedia.org/wiki/Shannon%E2%80%93Fano_coding)  
- [Data Compression Basics](https://www.data-compression.com/)  
