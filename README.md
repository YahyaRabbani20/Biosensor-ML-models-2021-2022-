# Mycotoxin Detection Sensor using DNA-SWCNT and Machine Learning (2021-2022)

## Overview
This repository documents the development of machine learning models to predict the response of **DNA-wrapped Single-Walled Carbon Nanotubes (DNA-SWCNT)** sensors to mycotoxins in food grains. This project combines data from experimental studies of DNA-SWCNTs with supervised machine learning techniques to enhance the detection of **Fumonisin B1 (FB1)**, a common mycotoxin in food grains. 
The repository contains data and models that were used to train **Artificial Neural Networks (ANN)** and **Support Vector Machine (SVM)** models, aiming to classify the fluorescence response of the sensor to varying DNA sequences. This work was part of research conducted between 2021-2022 as phd exchange at EPFL university.

---

## Purpose
The primary goal of this project was to utilize machine learning techniques to predict the behavior of **DNA-SWCNT** sensors under different DNA sequences for detecting the **FB1 mycotoxin**. The models developed were trained on experimental data and cross-validated for accuracy. The successful implementation of machine learning in this domain showcases the potential for **rational design** of DNA sequences for sensor applications.

### Key Highlights:
- **Supervised learning** models (**ANN** and **SVM**) were developed to predict sensor responses.
- **Cross-validation** techniques were employed to enhance the reliability of the models.
- The models successfully classified DNA sequences into high and low shifting responses.

---

## Technologies and Tools Used
- **MATLAB**: For model development, training, and data visualization.
- **Artificial Neural Networks (ANN)**: Used for non-linear mapping and prediction of sensor responses.
- **Support Vector Machines (SVM)**: Employed for binary classification of high and low fluorescence responses.
- **Directed Evolution Data**: Experimental data collected from DNA-SWCNT sensors was used to train the machine learning models.

---

## Key Project Highlights

### 1. Machine Learning Models for DNA-SWCNT Optical Sensors
Machine learning algorithms were employed to predict the fluorescence response of DNA-wrapped SWCNT sensors when exposed to **Fumonisin B1 (FB1)** mycotoxins. The machine learning process included:
- **Artificial Neural Networks (ANN)** were used to predict the non-linear behavior of the sensors.
- **Support Vector Machines (SVM)** provided reliable classification for high and low sensor responses.
- **Cross-validation** techniques like K-fold and Leave-one-out were utilized to improve model accuracy.

### 2. Data Visualization
The fluorescence response of the sensors was visualized using **MATLAB**, allowing the comparison between the predicted and experimental responses of DNA sequences. The models achieved an accuracy of over 80%, making them useful for predicting new DNA sequences for sensor development.

---

## Paper Reference
This repository is based on the findings presented in my paper:

**"Prediction of Mycotoxin Response of DNA-Wrapped Nanotube Sensor with Machine Learning"**, which describes the process of applying **ANN** and **SVM** to predict the behavior of **DNA-SWCNT** sensors for **mycotoxin detection**. The paper highlights the success of these models in classifying DNA sequences with accuracy and the potential for improving sensor design using machine learning.

- You can access the full paper [here](https://doi.org/10.1101/2023.09.07.556334).

---

## Repository Structure
The repository is structured as follows:

1. **/data**: Contains datasets used for training and testing the machine learning models. These include the fluorescence response data of DNA-SWCNT sensors to FB1 mycotoxins.
2. **/models**: Contains MATLAB code for implementing **ANN** and **SVM** models. The code includes data preprocessing, model training, and cross-validation techniques.
3. **README.md**: This file provides an overview of the project, instructions on how to use the models, and key findings from the paper.

---

## How to Use the Models
1. **Data Preparation**:
   - Load the fluorescence response data from the **/data** folder.
   - Preprocess the data using one-hot encoding for DNA sequences.

2. **Training the Models**:
   - Use the MATLAB scripts in the **/models** folder to train the **ANN** and **SVM** models on the provided datasets.
   - K-fold and Leave-one-out cross-validation methods are included in the code to ensure model reliability.

3. **Model Testing**:
   - After training, the models can be tested on new DNA sequences to predict their sensor responses.
   - Use the data visualization scripts to compare the predicted and actual responses.

---

## Acknowledgments
This work was conducted as part of my research at the **Institute of Chemical Sciences and Engineering (ISIC)**, **EPFL**. The project reflects my interest in utilizing machine learning for biosensor development, particularly in the detection of harmful mycotoxins in food grains. The authors express their gratitude for the funding support received from various sources, including the **Swiss National Science Foundation (SNSF)**, the **European Research Council (ERC)** through the European Union's Horizon 2020 research and innovation program (grant agreement no. 853005), and the **Honda Research Institute USA Inc.**. Their generous support made this research possible.


